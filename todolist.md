# todolist.md — AIR Meet / zoom_agora — get it running, in order

Scope of what was uploaded:
- `Z_reqZoom.zip` → docs + `supabase_schema.sql` + the old edge-function draft (`supabase edge functions.md`, actually a login-log function, not `recording_manager`) + master TODO (`todo_kiro_zoom.md`) + runbook.
- `zoom_agora_27_08_2026_feed.zip` → the actual Flutter module (`zoom_agora/`) with `community/`, `social/`, `in_meeting/`, `pre_meeting/`, `services/`, `widgets/`, and the real `supabase_functions/recording_manager/index.ts`.

Stack confirmed from code: **GetX** (routing + state + `GetxService`), **Supabase** (Postgres + Auth + Realtime + Edge Functions), **Cloudflare R2** (via the `recording_manager` Edge Function using `aws4fetch`), dual RTC backend (**Agora** default / **WebRTC** fallback, toggle in `rtc_backend_manager.dart`).

Two files in this delivery already have the fixes applied — use these instead of the originals:
- **`supabase_schema.sql`** (this delivery) — original schema + all prior patches + a new **PATCH 2026-08-27** appended at the very end (see "What I fixed" below).
- **`recording_manager_index.ts`** (this delivery) — original function + a new `upload_file` action added (rename to `index.ts` when you deploy it).

Work top-to-bottom. Do not skip step 1.

---

## Step 1 — Run the SQL, once, in order

1. Open Supabase → SQL Editor.
2. Paste and run the **entire** `supabase_schema.sql` from this delivery (not the one from the zip — it's missing the last patch). It's idempotent (`IF NOT EXISTS` / `OR REPLACE` / `DROP POLICY IF EXISTS`), safe to re-run.
3. Two `ALTER DATABASE` lines it can't run for you — run these yourself with your real values, or the R2-cleanup cron job errors every run (visible in Database → Cron → job history, not silent):
   ```sql
   ALTER DATABASE postgres SET app.supabase_url = 'https://YOUR_PROJECT.supabase.co';
   ALTER DATABASE postgres SET app.service_role_key = 'YOUR_SERVICE_ROLE_KEY';
   ```

## Step 2 — Enable Realtime on the tables the app subscribes to

The schema's own `PATCH 2026-07-06 §F` and the social-feed section already run most of this, but confirm in Supabase → Database → Replication (or re-run explicitly):
```sql
ALTER PUBLICATION supabase_realtime ADD TABLE meetings;
ALTER PUBLICATION supabase_realtime ADD TABLE meeting_participants;
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
ALTER PUBLICATION supabase_realtime ADD TABLE social_posts;
ALTER PUBLICATION supabase_realtime ADD TABLE social_comments;
```
(`ALTER PUBLICATION ... ADD TABLE` throws if the table's already in the publication — check Replication tab first, or wrap in a `DO $$ ... EXCEPTION WHEN duplicate_object THEN NULL; END $$` if you want it idempotent.)

## Step 3 — Cloudflare R2 bucket

1. Create an R2 bucket in the Cloudflare dashboard.
2. Enable public access on it (or attach a custom domain / CDN in front of it) — you need a public base URL either way.
3. Create an R2 API token (Account → R2 → Manage API tokens) with read/write on that bucket. Note the Access Key ID + Secret Access Key + your Cloudflare Account ID.

## Step 4 — Deploy the Edge Function (use the corrected `recording_manager_index.ts` from this delivery)

1. On your machine, in your Supabase project folder:
   ```bash
   supabase init            # only if not already done
   supabase link --project-ref <your-project-ref>
   mkdir -p supabase/functions/recording_manager
   ```
2. Copy this delivery's `recording_manager_index.ts` in as `supabase/functions/recording_manager/index.ts`.
3. Set secrets:
   ```bash
   supabase secrets set CLOUDFLARE_ACCOUNT_ID=xxx
   supabase secrets set CLOUDFLARE_R2_ACCESS_KEY_ID=xxx
   supabase secrets set CLOUDFLARE_R2_SECRET_ACCESS_KEY=xxx
   supabase secrets set R2_BUCKET_NAME=xxx
   supabase secrets set R2_PUBLIC_BASE_URL=https://cdn.yourdomain.com
   ```
4. Deploy:
   ```bash
   supabase functions deploy recording_manager
   ```
5. **Only if you're keeping the default Agora backend** (see Step 8): also build and deploy `agora_token_generator` — it does **not exist yet** anywhere in either zip, only described (`todo_kiro_zoom.md` §9-A, schema §G comment). `TokenService.fetchRtcToken`/`fetchRtmToken` already call it by name, so joining a real (non-demo) Agora meeting will fail with a 404 function-not-found until you create and deploy it. If you switch the default backend to WebRTC instead, you can skip this entirely — see Step 8.

## Step 5 — Flutter: drop the module in + dependencies

1. Copy `zoom_agora/` (from the feed zip) into your Flutter project, e.g. `lib/web_modules/web_home/zoom_agora/` (matches the path convention in `todo_kiro_zoom.md`'s header).
2. Add to `pubspec.yaml` (cross-check against your existing versions for conflicts):
   ```yaml
   dependencies:
     flutter_webrtc: ^0.11.7
     supabase_flutter: ^2.8.0
     collection: ^1.18.0
     permission_handler: ^11.3.1
     speech_to_text: ^7.0.0
     file_picker: ^8.1.2
     video_player: ^2.9.1
     http: any   # used directly by services/recording_service.dart
   ```
   `emoji_picker_flutter`, `record`, `confetti`, `audio_waveforms`, `fast_contacts` are only needed once you build the Section 8/9-adjacent enrichments in `todo_kiro_zoom.md` — skip for the initial bring-up.
3. `flutter pub get`. Fix any version-conflict errors against your host app's existing deps before moving on.

## Step 6 — Wire GetX + Supabase init in your app

In your `main.dart` (or wherever your app boots), **before** any zoom_agora route is pushed:
```dart
await Supabase.initialize(
  url: 'https://YOUR_PROJECT.supabase.co',
  anonKey: 'YOUR_ANON_KEY',
);

runApp(GetMaterialApp(
  initialRoute: ZoomRoutes.home,   // or your own home + a button into '/zoom'
  getPages: ZoomRoutes.pages,
));
```
After sign-in (OTP/email/whatever your host app uses), call:
```dart
await CurrentUser.ensureProfileLoaded();
```
This resolves `user_table.user_id` via `auth_user_id = auth.uid()` — required before any create/join/chat/post call, per `services/current_user.dart`. The `handle_new_auth_user()` trigger from the schema auto-creates the `user_table` row on signup, so this should resolve immediately after your first sign-in with no extra code.

## Step 7 — Platform permissions

- **Android** `AndroidManifest.xml`: `CAMERA`, `RECORD_AUDIO`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PROJECTION` (for screen share).
- **iOS** `Info.plist`: `NSCameraUsageDescription`, `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`. Screen share on iOS additionally needs a Broadcast Upload Extension target in Xcode (native project change — not something added from Dart).
- **Web**: must be served over HTTPS (camera/mic/screen-share APIs refuse plain HTTP; `localhost` is exempt).

## Step 8 — Decide: Agora or WebRTC as the default RTC backend

`models/rtc_config.dart` defaults `backend: RtcBackend.agora`. Two real options — pick one before testing:

- **Keep Agora** → you must (a) have deployed `agora_token_generator` from Step 4.5, and (b) pass `AppIdAgorra`/`AgorraToken1234567890` via `--dart-define` at build time (see `RtcConfig.fromEnvironment`). Without an App ID, `demoMode` auto-activates (mock engine, no real video) — not a crash, but not a real call either.
- **Switch default to WebRTC** (recommended if you don't already have an Agora account — it's what the top-level READMEs describe as "no Agora, zero per-minute cost"): change `RtcBackend.agora` → `RtcBackend.webrtc` in `RtcConfig`'s default constructor, and set up a TURN server (below). No Edge Function needed for this path — signaling rides entirely on Supabase Realtime (`services/signaling_service.dart`).

## Step 9 — TURN server (only matters for the WebRTC backend)

Public STUN alone will fail on strict NATs / corporate firewalls / most mobile carrier networks. Either:
- Self-host `coturn` (see `WEBRTC_SETUP.md` in the zip, §4, for a docker-compose — note: that file wasn't included in either upload, only referenced by the READMEs; write your own coturn compose if you don't have it), or
- Use a free-tier hosted TURN provider (e.g. Metered.ca) and plug the URL/username/credential into `RtcConfig.withTurn(...)`.

## Step 10 — First run

```bash
flutter run -d chrome
```
Navigate to `/zoom` (or whatever route you mounted it under). Sign in first — every zoom_agora screen assumes `CurrentUser.isSignedIn`.

## Step 11 — Push notifications, calendar push, virtual background, cloud recording UI polish

These are explicitly flagged as **not implemented / needs your credentials** in both READMEs — Firebase project (push), Google/Outlook OAuth app (calendar), an ML segmentation model (virtual background). Cloud recording itself (R2 upload) *is* implemented once Step 4 is deployed — what's still open is only the push/calendar/virtual-bg pieces. Do these last, after the core flows in Steps 1–10 are confirmed working (see `test.md`).

---

## What I fixed / found while reading the uploaded files (all now in the delivered `supabase_schema.sql`, PATCH 2026-08-27 at the bottom)

1. **`chat_rooms` and `chat_messages` RLS compared the wrong id.** `CurrentUser.id` (used as `memberIds`, `senderId`, `authorId` everywhere in the Dart code) resolves to `user_table.user_id`, not `auth.uid()` — confirmed by the doc comment in `services/current_user.dart` and by every other patched table (`meeting_participants`, `social_posts`, etc.) using a `(SELECT user_id FROM user_table WHERE auth_user_id = auth.uid()::uuid)` subquery. `chat_rooms`/`chat_messages`, from the original (unpatched) section 14, still compared `auth.uid()::uuid` directly against `member_ids`/`admin_ids`/`sender_id`. Since those two ids are never equal for a real user, **every Community read and write was being silently rejected by RLS** — `listRooms()` always returns `[]`, `createRoom()`/`sendMessage()` throw. Fixed by rewriting those policies to the same subquery pattern as the rest of the schema.
2. **`chat_rooms` had no `INSERT` policy at all.** RLS was enabled with only `SELECT`/`UPDATE` policies — `CommunityService.createRoom()` would fail with "new row violates row-level security policy" even after fix #1. Added `chat_rooms_insert`.
3. **`social_reactions` had no `UPDATE` policy.** `SocialService.reactToPost()` does an `upsert(onConflict: 'target_id,user_id')` — changing an *existing* reaction's emoji compiles to `INSERT ... ON CONFLICT DO UPDATE`, which needs an UPDATE policy in addition to INSERT/SELECT. Only `sr_select`/`sr_upsert_own`/`sr_delete_own` existed — a user could react once but switching from 👍 to ❤️ silently did nothing. Added `sr_update_own`.
4. **`temp_files` had the same id-mismatch as #1**, though not currently exercised by any client code (only an Edge Function running as `service_role`, which bypasses RLS, would touch it) — fixed anyway for consistency, at zero cost.
5. **`recording_manager/index.ts` (the real one, in the feed zip) never implemented `upload_file`.** `services/r2_upload_service.dart` — used by `community_room_view.dart` attach, `social/post_create_view.dart` media upload, and `in_meeting/chat_panel.dart` file attach — calls `{ action: 'upload_file', roomId, filename, contentType, dataBase64 }`, but the function's `switch` only had `start`/`getPartUrl`/`complete`/`abort`/`pause`/`resume`. Every attach/upload anywhere in the app would 400 with `Unknown action: upload_file`. Added the `upload_file` case in the delivered `recording_manager_index.ts` (base64-decodes, single-shot `PUT`s to R2, records a `temp_files` row for the existing cleanup cron, returns `{ url, r2Key }`).
6. **Note, not changed:** `Z_reqZoom.zip`'s `supabase edge functions.md` is a login-audit-log function (`user_logging_data` insert), unrelated to `recording_manager` — don't confuse the two when deploying; it's a separate function you may or may not want, not a substitute for `recording_manager`.
7. **Confirmed already fixed in the zip itself (no action needed, just flagging so you don't re-do it):** `user_last_login_logs_id` circular FK, `meeting_participants` missing RLS policies, `auth_user_id` linkage, `handle_new_auth_user()` signup trigger, `trg_queue_r2_delete` (was declared but never created — fixed in the zip's own PATCH 2026-07-16 §B), and the raw `INSERT INTO cron.job` that bypassed `cron.schedule()` validation (also fixed in PATCH 2026-07-16 §C).
