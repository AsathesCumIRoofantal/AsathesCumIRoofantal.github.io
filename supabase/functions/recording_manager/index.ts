// Supabase Edge Function: recording_manager
// - start/stop reserved for future recording pipeline
// - upload_file uploads bytes to Cloudflare R2 (S3 compatible)
//
// This function expects JSON body:
//   { action: "upload_file", roomId, filename, contentType?, dataBase64 }
//
// Env vars:
//   CLOUDFLARE_ACCOUNT_ID
//   CLOUDFLARE_R2_ACCESS_KEY_ID
//   CLOUDFLARE_R2_SECRET_ACCESS_KEY
//   R2_BUCKET_NAME
//   R2_PUBLIC_BASE_URL
//
// Notes:
// - Keep uploads reasonably sized when using base64-in-JSON.
// - For large files, switch to presigned URL upload.

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { S3Client, PutObjectCommand } from "npm:@aws-sdk/client-s3@3.733.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
};

function json(data: unknown, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const body = await req.json();
    const action = body?.action as string | undefined;

    if (action === "upload_file") {
      const roomId = body.roomId as string | undefined;
      const filename = body.filename as string | undefined;
      const contentType = (body.contentType as string | undefined) ?? "application/octet-stream";
      const dataBase64 = body.dataBase64 as string | undefined;
      if (!roomId || !filename || !dataBase64) {
        return json({ error: "Missing roomId/filename/dataBase64" }, 400);
      }

      const accountId = Deno.env.get("CLOUDFLARE_ACCOUNT_ID")!;
      const accessKeyId = Deno.env.get("CLOUDFLARE_R2_ACCESS_KEY_ID")!;
      const secretAccessKey = Deno.env.get("CLOUDFLARE_R2_SECRET_ACCESS_KEY")!;
      const bucket = Deno.env.get("R2_BUCKET_NAME")!;
      const publicBase = Deno.env.get("R2_PUBLIC_BASE_URL")!;

      const endpoint = `https://${accountId}.r2.cloudflarestorage.com`;
      const s3 = new S3Client({
        region: "auto",
        endpoint,
        credentials: { accessKeyId, secretAccessKey },
      });

      const bytes = Uint8Array.from(atob(dataBase64), (c) => c.charCodeAt(0));
      const safeName = filename.replaceAll(/[^a-zA-Z0-9._-]/g, "_");
      const key = `files/${roomId}/${crypto.randomUUID()}/${safeName}`;

      await s3.send(new PutObjectCommand({
        Bucket: bucket,
        Key: key,
        Body: bytes,
        ContentType: contentType,
      }));

      const url = `${publicBase.replace(/\/$/, "")}/${key}`;
      return json({ url, r2Key: key });
    }

    // Placeholder for recording actions referenced by the Flutter client.
    if (action === "start" || action === "pause" || action === "resume" || action === "stop") {
      return json({ error: `Action '${action}' not implemented in this build` }, 501);
    }

    return json({ error: "Unknown action" }, 400);
  } catch (e) {
    return json({ error: e instanceof Error ? e.message : String(e) }, 500);
  }
});

