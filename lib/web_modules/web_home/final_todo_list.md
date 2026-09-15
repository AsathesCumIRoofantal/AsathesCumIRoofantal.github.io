# final_todo_list.md — AIR Meet (zoom_agora) — fully integrated package

This package (`zoom_agora_29_08_2026_FIXED.zip`) already has every fix that
could be applied **in code** baked in — you're not applying patches anymore,
you're just wiring credentials and running the SQL. What changed vs. the
zip you uploaded is listed at the bottom. Work top to bottom.

---

## 1. Database — run the SQL once

1. Open Supabase → SQL Editor.
2. Paste and run **all** of `supabase/supabase_schema.sql` from this package (not any older copy you may have — this one has the RLS fixes already appended at the bottom, under `PATCH 2026-08-27`). Idempotent, safe to re-run.
3. Run with your real values (needed for the R2-cleanup cron to work):
   ```sql
   ALTER DATABASE postgres SET app.supabase_url = 'https://YOUR_PROJECT.supabase.co';
   ALTER DATABASE postgres SET app.service_role_key = 'YOUR_SERVICE_ROLE_KEY';
   ```
4. **Test:** Database → Policies → `chat_rooms` shows 3 policies (`chat_rooms_member_select`, `chat_rooms_member_update`, `chat_rooms_insert`); `social_reactions` shows 4 (includes `sr_update_own`). If either count is short, the file didn't run to completion — scroll to the bottom of the SQL Editor output for the actual error.

## 2. Database — confirm Realtime is on

Database → Replication → `supabase_realtime` publication should list: `meetings`, `meeting_participants`, `chat_messages`, `social_posts`, `social_comments`. Add any missing ones:
```sql
ALTER PUBLICATION supabase_realtime ADD TABLE meetings;
ALTER PUBLICATION supabase_realtime ADD TABLE meeting_participants;
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
ALTER PUBLICATION supabase_realtime ADD TABLE social_posts;
ALTER PUBLICATION supabase_realtime ADD TABLE social_comments;
```

## 3. Cloudflare R2 — bucket + public access

1. Create the R2 bucket in the Cloudflare dashboard.
2. Turn on public access (or put a custom domain / CDN in front of it) — you need a public base URL.
3. **Test:** manually upload a test file via the dashboard, confirm it loads at `https://YOUR_PUBLIC_BASE_URL/<key>`. Don't move on until this works — everything R2-related downstream depends on this URL pattern.

## 4. Cloudflare R2 — API token

Create an R2 API token (Account → R2 → Manage API tokens) with read/write on the bucket. Note: Account ID, Access Key ID, Secret Access Key.

## 5. Deploy the Edge Function (already fixed in this package)

```bash
supabase link --project-ref <your-project-ref>
mkdir -p supabase/functions/recording_manager
cp zoom_agora/supabase_functions/recording_manager/index.ts supabase/functions/recording_manager/index.ts

supabase secrets set CLOUDFLARE_ACCOUNT_ID=xxx
supabase secrets set CLOUDFLARE_R2_ACCESS_KEY_ID=xxx
supabase secrets set CLOUDFLARE_R2_SECRET_ACCESS_KEY=xxx
supabase secrets set R2_BUCKET_NAME=xxx
supabase secrets set R2_PUBLIC_BASE_URL=https://cdn.yourdomain.com

supabase functions deploy recording_manager
```
**Test:** curl it with `{"action":"upload_file","roomId":"test","filename":"hello.txt","contentType":"text/plain","dataBase64":"aGVsbG8gd29ybGQ="}` and a real user JWT in the `Authorization` header — expect `200` with `{ url, r2Key }`, and the returned `url` should open and show "hello world". (This is the exact action that was missing before — it's now included in the function you just deployed.)

## 6. Drop the module into your Flutter project

1. Copy `zoom_agora/` into your project, e.g. `lib/web_modules/web_home/zoom_agora/`.
2. Add to your `pubspec.yaml` (check for version conflicts against your existing deps first):
   ```yaml
   dependencies:
     flutter_webrtc: ^0.11.7
     supabase_flutter: ^2.8.0
     collection: ^1.18.0
     permission_handler: ^11.3.1
     speech_to_text: ^7.0.0
     file_picker: ^8.1.2
     video_player: ^2.9.1
     emoji_picker_flutter: ^3.1.0
     http: any
   ```
3. `flutter pub get`, then `flutter analyze` on `zoom_agora/` — fix any conflicts before continuing.

## 7. Wire Supabase + GetX in your app's `main.dart`

```dart
await Supabase.initialize(
  url: 'https://YOUR_PROJECT.supabase.co',
  anonKey: 'YOUR_ANON_KEY',
);

runApp(GetMaterialApp(
  initialRoute: ZoomRoutes.home,
  getPages: ZoomRoutes.pages,
));
```
Right after your sign-in flow completes, call:
```dart
await CurrentUser.ensureProfileLoaded();
```
**Test:** debug-print `CurrentUser.id` after sign-in — non-null UUID. Confirm a matching row exists in `user_table` with `auth_user_id` set (the schema's `handle_new_auth_user()` trigger creates this automatically on signup).

## 8. Platform permissions

- **Android** `AndroidManifest.xml`: `CAMERA`, `RECORD_AUDIO`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PROJECTION`.
- **iOS** `Info.plist`: `NSCameraUsageDescription`, `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`. Screen share on iOS also needs a Broadcast Upload Extension target (native Xcode project change).
- **Web**: must be served over HTTPS (or `localhost`) or `getUserMedia` is blocked outright.

## 9. RTC backend — WebRTC is now the default, nothing to deploy for it

This package flips the default from Agora to WebRTC (see "What changed" below) — it matches the stack you described (GetX + Supabase, no Agora account) and needs zero extra services: signaling rides entirely on Supabase Realtime.

- **If you're happy with WebRTC:** skip straight to step 10. Public STUN (already configured) is enough for same-network testing.
- **If you specifically want Agora instead:** pass `RtcConfig.fromEnvironment(backend: RtcBackend.agora)` explicitly (or flip it at runtime with the existing `widgets/backend_toggle.dart`), supply `--dart-define=AppIdAgorra=...`, and build/deploy an `agora_token_generator` Edge Function — this one still doesn't exist in either zip, only described in the docs (`todo_kiro_zoom.md` §9-A). `TokenService` already calls it by name, so a live Agora join will 404 until you write and deploy it.

## 10. TURN server — needed before real-world (cross-network) use

Public STUN alone fails across strict NATs / most mobile carriers / corporate firewalls. Before you rely on this for anyone off your local network:
- Self-host `coturn`, or
- Use a hosted free-tier TURN provider (e.g. Metered.ca),

then plug it in:
```dart
RtcConfig.withTurn(
  channelId: meeting.channelName,
  uid: myUid,
  turnUrl: 'turn:your.server.com:3478',
  turnUsername: '...',
  turnCredential: '...',
);
```
**Test:** two devices on different networks (not the same Wi-Fi) can still connect video.

## 11. First real run

```bash
flutter run -d chrome
```
Sign in, go to `/zoom`. Then walk through, in order:
1. `/zoom/community` → create a room → send a message from a second signed-in profile → confirm it arrives live. (Direct test of the RLS id-mismatch fix — if this errors, re-check step 1.)
2. Attach a file in that room → confirm it uploads and the link opens. (Direct test of the `upload_file` fix — if this 400s, you deployed an old copy of the function, not the one from this package.)
3. `/zoom/feed` → create a post with media → react to it → **then change your reaction to a different emoji on the same post** → confirm the count updates rather than silently doing nothing. (Direct test of the `social_reactions` UPDATE-policy fix.)
4. Two tabs/devices, same meeting → both see each other's video, mute/camera state reflects across devices, screen share works.
5. Start/stop cloud recording → snackbar shows a working R2 URL.

## 12. Features that genuinely need your own third-party accounts (not fixable in code, by design)

These need credentials only you can obtain — flagged clearly in-app rather than faked:
- **Push notifications** — needs a Firebase project + `firebase_messaging` wiring.
- **Calendar push (Google/Outlook)** — needs OAuth apps registered with Google/Microsoft.
- **Virtual background** — needs a real-time ML segmentation model; `webrtc_service.dart` explicitly stubs this out rather than pretending it works.
- **Agora RTM** (`services/rtm_service.dart`) — dead code, not called from anywhere; in-meeting chat and Community chat both already run on Supabase, so there's nothing to wire here unless you specifically want Agora's RTM product for something else.

Do these last, after step 11 passes.

---

## What changed vs. the zip you uploaded (already applied in this package — nothing to do)

1. **`supabase/supabase_schema.sql`** — added, with `PATCH 2026-08-27` appended:
   - Fixed `chat_rooms`/`chat_messages` RLS: policies compared `auth.uid()` directly, but `CurrentUser.id` (used as `memberIds`/`senderId` everywhere in the Dart code) is `user_table.user_id`, a different UUID — this silently blocked all Community reads/writes.
   - Added the missing `chat_rooms` INSERT policy (`createRoom()` had nothing to satisfy — RLS defaults to deny).
   - Added the missing `social_reactions` UPDATE policy (changing an existing reaction is an upsert-on-conflict, which needs UPDATE in addition to INSERT).
   - Same id-mismatch fix applied to `temp_files` for consistency (not an active bug — only touched by the Edge Function, which runs as `service_role` and bypasses RLS anyway).
2. **`zoom_agora/supabase_functions/recording_manager/index.ts`** — added the `upload_file` action. `R2UploadService.uploadFile()` (Community attach, Social post media, in-meeting chat attach) already called this action; the function's switch statement never handled it, so every attach anywhere in the app 400'd with "Unknown action: upload_file".
3. **`zoom_agora/models/rtc_config.dart`, `services/rtc_backend_manager.dart`, `in_meeting/zoom_meeting_binding.dart`** — default RTC backend flipped from Agora to WebRTC. This matches both the stack you described (no Agora mentioned) and the module's own README ("real, no Agora... zero per-minute media cost"), which the code hadn't actually matched until now. Agora is still fully wired and reachable via `backend_toggle.dart` for anyone who wants it.
