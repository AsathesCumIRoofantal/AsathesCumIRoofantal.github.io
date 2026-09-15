// supabase/functions/recording_manager/index.ts
//
// This did not exist before this pass — supabase_schema.sql only had a
// comment block describing the contract (see section G). This is the
// real implementation: R2 (Cloudflare's S3-compatible object storage)
// multipart upload, signed server-side with aws4fetch so the R2 secret
// key never reaches the Flutter client.
//
// Deploy:  supabase functions deploy recording_manager
// Secrets: supabase secrets set CLOUDFLARE_ACCOUNT_ID=... \
//            CLOUDFLARE_R2_ACCESS_KEY_ID=... CLOUDFLARE_R2_SECRET_ACCESS_KEY=... \
//            R2_BUCKET_NAME=... R2_PUBLIC_BASE_URL=https://cdn.yourproject.com
//
// Actions (all POST, JSON body, requires the caller's Supabase auth JWT
// in the Authorization header — same as every other Edge Function this
// project already calls):
//
//   { action: "start", channel, uid, meetingId, ext? }
//     → creates an R2 multipart upload, stores uploadId/r2Key on the
//       meetings row, returns { uploadId, r2Key }
//
//   { action: "getPartUrl", uploadId, r2Key, partNumber }
//     → returns a presigned PUT URL for that part number so the CLIENT
//       uploads the raw bytes directly to R2 (never through this
//       function — Edge Functions have a request-body size ceiling that
//       a video chunk would blow through). { url }
//
//   { action: "complete", uploadId, r2Key, parts: [{partNumber, etag}] }
//     → completes the multipart upload, sets meetings.recording_url to
//       the public R2 URL, clears is_recording. Response: { url }
//
//   { action: "abort", uploadId, r2Key }
//     → aborts an in-progress multipart upload (e.g. user cancelled).
//
//   { action: "pause" } / { action: "resume" }
//     → bookkeeping only. R2/S3 multipart upload has no native
//       pause/resume verb — "pausing" is really just the client
//       temporarily not calling getPartUrl/PUT. These two actions exist
//       so the client's pause/resume buttons have something to call and
//       so is_recording/is_paused stay accurate in the meetings row for
//       every other participant's UI to reflect.
//
//   { action: "upload_file", roomId, filename, contentType, dataBase64 }
//     → ADDED 2026-08-27. R2UploadService.uploadFile() (Community room
//       attach, Social post media, in-meeting chat attach) already called
//       this action — it was simply missing from this function, so every
//       attach/upload in the app 400'd with "Unknown action: upload_file"
//       until now. Single-shot PUT (base64 body, decoded here), not a
//       multipart upload — fine for chat/community/post attachments;
//       large video recordings should keep using start/getPartUrl/complete
//       above. Also inserts a `temp_files` row so the existing R2 cleanup
//       cron (see supabase_schema.sql §16 / PATCH 2026-07-06 §H) can purge
//       it later. Response: { url, r2Key }
import { serve } from 'https://deno.land/std@0.224.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.45.4';
import { AwsClient } from 'https://esm.sh/aws4fetch@1.0.20';

const ACCOUNT_ID = Deno.env.get('CLOUDFLARE_ACCOUNT_ID')!;
const ACCESS_KEY_ID = Deno.env.get('CLOUDFLARE_R2_ACCESS_KEY_ID')!;
const SECRET_ACCESS_KEY = Deno.env.get('CLOUDFLARE_R2_SECRET_ACCESS_KEY')!;
const BUCKET = Deno.env.get('R2_BUCKET_NAME')!;
const PUBLIC_BASE_URL = Deno.env.get('R2_PUBLIC_BASE_URL')!;

const R2_ENDPOINT = `https://${ACCOUNT_ID}.r2.cloudflarestorage.com`;

const r2 = new AwsClient({
  accessKeyId: ACCESS_KEY_ID,
  secretAccessKey: SECRET_ACCESS_KEY,
  service: 's3',
  region: 'auto',
});

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
  };
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders(), 'Content-Type': 'application/json' },
  });
}

function supabaseFromRequest(req: Request) {
  return createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!,
    { global: { headers: { Authorization: req.headers.get('Authorization')! } } },
  );
}

// Minimal S3 XML parsing (Deno's std has no XML parser bundled and the
// full R2/S3 responses are simple enough not to need one).
function extractTag(xml: string, tag: string): string | null {
  const m = xml.match(new RegExp(`<${tag}>([^<]*)</${tag}>`));
  return m ? m[1] : null;
}

serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders() });

  try {
    const body = await req.json();
    const action = body.action as string;
    const supabase = supabaseFromRequest(req);

    const { data: userData, error: authErr } = await supabase.auth.getUser();
    if (authErr || !userData?.user) return json({ error: 'Not authenticated' }, 401);
    const uid = userData.user.id;

    switch (action) {
      case 'start': {
        const { meetingId, channel, ext } = body;
        if (!meetingId) return json({ error: 'meetingId required' }, 400);

        // Only the host may start a recording — mirrors the RLS intent
        // already established in the schema for meeting management.
        const { data: meeting, error: mErr } = await supabase
          .from('meetings').select('id, host_id').eq('id', meetingId).single();
        if (mErr || !meeting) return json({ error: 'Meeting not found' }, 404);
        if (meeting.host_id !== uid) return json({ error: 'Only the host can record' }, 403);

        const r2Key = `recordings/${meetingId}/${Date.now()}.${ext ?? 'webm'}`;
        const initRes = await r2.fetch(
          `${R2_ENDPOINT}/${BUCKET}/${r2Key}?uploads`,
          { method: 'POST' },
        );
        if (!initRes.ok) {
          return json({ error: `R2 init failed: ${await initRes.text()}` }, 502);
        }
        const xml = await initRes.text();
        const uploadId = extractTag(xml, 'UploadId');
        if (!uploadId) return json({ error: 'R2 did not return an UploadId' }, 502);

        await supabase.from('meetings').update({
          is_recording: 1,
          recording_upload_id: uploadId,
          recording_r2_key: r2Key,
        }).eq('id', meetingId);

        return json({ uploadId, r2Key });
      }

      case 'getPartUrl': {
        const { uploadId, r2Key, partNumber } = body;
        if (!uploadId || !r2Key || !partNumber) {
          return json({ error: 'uploadId, r2Key, partNumber required' }, 400);
        }
        const url = `${R2_ENDPOINT}/${BUCKET}/${r2Key}` +
          `?partNumber=${partNumber}&uploadId=${encodeURIComponent(uploadId)}`;
        // Sign a PUT the client will perform directly against R2.
        const signed = await r2.sign(new Request(url, { method: 'PUT' }), {
          aws: { signQuery: true },
        });
        return json({ url: signed.url });
      }

      case 'complete': {
        const { uploadId, r2Key, parts, meetingId } = body;
        if (!uploadId || !r2Key || !Array.isArray(parts)) {
          return json({ error: 'uploadId, r2Key, parts[] required' }, 400);
        }
        const partsXml = parts
          .sort((a: any, b: any) => a.partNumber - b.partNumber)
          .map((p: any) => `<Part><PartNumber>${p.partNumber}</PartNumber><ETag>${p.etag}</ETag></Part>`)
          .join('');
        const completeBody =
          `<CompleteMultipartUpload>${partsXml}</CompleteMultipartUpload>`;

        const completeRes = await r2.fetch(
          `${R2_ENDPOINT}/${BUCKET}/${r2Key}?uploadId=${encodeURIComponent(uploadId)}`,
          { method: 'POST', body: completeBody },
        );
        if (!completeRes.ok) {
          return json({ error: `R2 complete failed: ${await completeRes.text()}` }, 502);
        }

        const publicUrl = `${PUBLIC_BASE_URL}/${r2Key}`;
        if (meetingId) {
          await supabase.from('meetings').update({
            is_recording: 0,
            recording_url: publicUrl,
          }).eq('id', meetingId);
        }
        return json({ url: publicUrl });
      }

      case 'abort': {
        const { uploadId, r2Key, meetingId } = body;
        if (!uploadId || !r2Key) return json({ error: 'uploadId, r2Key required' }, 400);
        await r2.fetch(
          `${R2_ENDPOINT}/${BUCKET}/${r2Key}?uploadId=${encodeURIComponent(uploadId)}`,
          { method: 'DELETE' },
        );
        if (meetingId) {
          await supabase.from('meetings').update({ is_recording: 0 }).eq('id', meetingId);
        }
        return json({ ok: true });
      }

      case 'upload_file': {
        const { roomId, filename, contentType, dataBase64 } = body;
        if (!filename || !dataBase64) {
          return json({ error: 'filename, dataBase64 required' }, 400);
        }

        // Decode base64 -> raw bytes (Deno has no Buffer; atob + charCode
        // walk is the standard edge-runtime-safe way to do this).
        const binary = atob(dataBase64 as string);
        const bytes = new Uint8Array(binary.length);
        for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);

        const safeName = (filename as string).replace(/[^a-zA-Z0-9._-]/g, '_');
        const r2Key = `files/${roomId ?? 'misc'}/${crypto.randomUUID()}/${safeName}`;

        const putRes = await r2.fetch(`${R2_ENDPOINT}/${BUCKET}/${r2Key}`, {
          method: 'PUT',
          body: bytes,
          headers: { 'Content-Type': (contentType as string) ?? 'application/octet-stream' },
        });
        if (!putRes.ok) {
          return json({ error: `R2 upload failed: ${await putRes.text()}` }, 502);
        }

        const url = `${PUBLIC_BASE_URL}/${r2Key}`;

        // Track for cleanup — mirrors the temp_files contract in
        // supabase_schema.sql (30-day expiry, purged by the existing
        // r2_pending_deletes cron). Best-effort: don't fail the upload
        // if this insert has a problem, the file is already live.
        try {
          await supabase.from('temp_files').insert({
            user_id: (
              await supabase.from('user_table').select('user_id').eq('auth_user_id', uid).single()
            ).data?.user_id,
            r2_key: r2Key,
            file_size: bytes.byteLength,
            expires_at: Date.now() + 30 * 24 * 60 * 60 * 1000,
          });
        } catch (_e) {
          // non-fatal
        }

        return json({ url, r2Key });
      }

      case 'pause': {
        const { meetingId } = body;
        if (meetingId) await supabase.from('meetings').update({ is_recording: 2 }).eq('id', meetingId);
        return json({ ok: true }); // 2 = paused, by convention with is_recording's 0/1
      }

      case 'resume': {
        const { meetingId } = body;
        if (meetingId) await supabase.from('meetings').update({ is_recording: 1 }).eq('id', meetingId);
        return json({ ok: true });
      }

      default:
        return json({ error: `Unknown action: ${action}` }, 400);
    }
  } catch (e) {
    return json({ error: String(e) }, 500);
  }
});
