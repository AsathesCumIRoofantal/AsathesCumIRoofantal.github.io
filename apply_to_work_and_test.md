# apply_to_work_and_test.md — do one, test one, then move on

This interleaves `todolist.md` and `test.md` into a single pass so you apply
a change and immediately confirm it before touching the next thing. Check
each box before moving to the next numbered block.

Files referenced below are the **corrected** versions delivered alongside
this file, not the originals from the two zips:
- `supabase_schema.sql` (has PATCH 2026-08-27 appended)
- `recording_manager_index.ts` (has the `upload_file` action added — rename to `index.ts` on deploy)

---

### 1. Apply: run `supabase_schema.sql` (this delivery) in Supabase SQL Editor
**Test:**
- [ ] No red errors in the SQL Editor output
- [ ] `chat_rooms` has 3 policies in Database → Policies (`chat_rooms_member_select`, `chat_rooms_member_update`, `chat_rooms_insert`)
- [ ] `social_reactions` has 4 policies (includes `sr_update_own`)

→ If either policy count is wrong, the file didn't fully execute — scroll to the very bottom of the SQL editor output for the actual error and re-run just the `PATCH 2026-08-27` block.

---

### 2. Apply: `ALTER DATABASE postgres SET app.supabase_url = '...'` / `app.service_role_key = '...'`
**Test:**
- [ ] Both statements ran with no error
- [ ] Database → Cron → job history for `cleanup-r2-pending-deletes` shows no auth errors on its next run (may take up to an hour — safe to skip verifying this immediately and come back to it later)

---

### 3. Apply: confirm/enable Realtime publication on `meetings`, `meeting_participants`, `chat_messages`, `social_posts`, `social_comments`
**Test:**
- [ ] Database → Replication → `supabase_realtime` lists all 5 tables

---

### 4. Apply: create Cloudflare R2 bucket + public access/CDN domain
**Test:**
- [ ] Manually uploaded test file opens at `https://YOUR_PUBLIC_BASE_URL/<key>`

→ Don't proceed until this loads. Every later R2 test depends on this URL pattern being correct.

---

### 5. Apply: create R2 API token, note Account ID / Access Key / Secret
**Test:**
- [ ] You have all 5 values ready: `CLOUDFLARE_ACCOUNT_ID`, `CLOUDFLARE_R2_ACCESS_KEY_ID`, `CLOUDFLARE_R2_SECRET_ACCESS_KEY`, `R2_BUCKET_NAME`, `R2_PUBLIC_BASE_URL`

---

### 6. Apply: `supabase functions deploy recording_manager` using **this delivery's** `recording_manager_index.ts`
**Test:**
- [ ] `supabase functions list` shows it deployed
- [ ] curl smoke test with `action: "upload_file"` (see `test.md` Test 4) returns 200 + a working URL

→ This is the direct test that you deployed the *corrected* function, not the original (which 400s on `upload_file`).

---

### 7. (Only if keeping Agora as default backend) Apply: build + deploy `agora_token_generator`
**Test:**
- [ ] curl smoke test against it returns `{ token, expiresAt }`

→ If you're switching to WebRTC instead (see block 13), skip this and come back only if you change your mind later.

---

### 8. Apply: copy `zoom_agora/` into your Flutter project; add dependencies to `pubspec.yaml`; `flutter pub get`
**Test:**
- [ ] `flutter pub get` succeeds with no version conflicts
- [ ] `flutter analyze` on `zoom_agora/` shows no unresolved-import errors

---

### 9. Apply: `Supabase.initialize(...)` at app start + `GetMaterialApp(initialRoute: ZoomRoutes.home, getPages: ZoomRoutes.pages)`
**Test:**
- [ ] App boots without a Supabase init crash

---

### 10. Apply: call `CurrentUser.ensureProfileLoaded()` right after your sign-in step
**Test:**
- [ ] After signing in, `CurrentUser.id` returns a non-null value (debug print it once)
- [ ] `user_table` in Supabase has a row with your `auth_user_id` populated

---

### 11. Apply: platform permission entries (`AndroidManifest.xml` / `Info.plist`)
**Test:**
- [ ] Camera/mic OS permission dialogs actually appear on first use, on both platforms you support

---

### 12. Apply: decide Agora vs WebRTC; if WebRTC, change `RtcConfig`'s default `backend`
**Test:**
- [ ] Debug-print `RtcConfig().backend` — matches your decision
- [ ] Joining a meeting hits the code path you expect (Agora function call, or Supabase Realtime signaling — check Network/logs)

---

### 13. Apply (WebRTC path only): stand up TURN (self-hosted coturn or hosted free tier); plug into `RtcConfig.withTurn(...)`
**Test:**
- [ ] Two participants on different networks (not the same LAN) can still connect video

---

### 14. Apply: `flutter run -d chrome`, sign in, open `/zoom`
**Test:**
- [ ] Home screen renders, no red error screen

---

### 15. Apply: open `/zoom/community`, create a room, send a message from two signed-in profiles
**Test:**
- [ ] Room list loads (empty state is fine on first run — confirms no RLS block)
- [ ] New room appears in `chat_rooms` table after creating it
- [ ] Message sent from Profile A appears on Profile B without a refresh

→ This is the direct test of the id-mismatch fix (Fix #1/#2 in `todolist.md`). If this fails with an RLS error, stop and re-check block 1.

---

### 16. Apply: attach a file in a community room
**Test:**
- [ ] File uploads, message bubble shows a working download/view URL

→ Direct test of the `upload_file` fix (block 6 above). If this 400s, you likely deployed the original function instead of this delivery's corrected one.

---

### 17. Apply: open `/zoom/feed`, create a post with media, react to it, comment on it
**Test:**
- [ ] Post appears with uploaded media
- [ ] React with one emoji, then **switch to a different emoji on the same post** — count updates both times

→ Direct test of the `social_reactions` UPDATE-policy fix. If the second reaction silently does nothing, `sr_update_own` didn't get created — re-check block 1.

---

### 18. Apply: join a meeting from two devices/tabs with the same `channelId`
**Test:**
- [ ] Both see each other's video, mute/camera toggles reflect across devices, screen share works

---

### 19. Apply: start/stop cloud recording (requires block 6 done)
**Test:**
- [ ] Red dot pulses on start
- [ ] Stop gives a snackbar with a working R2 URL
- [ ] Recent-recordings list on home screen shows the new entry

---

### 20. Confirm not-yet-implemented features fail honestly (no code change expected here)
**Test:**
- [ ] Push notifications, calendar push, virtual background all show a clear "not available" state — not a crash, not a fake success

---

Once all 20 blocks are checked, cross-reference the full **PRIORITY EXECUTION ORDER** table at the bottom of `todo_kiro_zoom.md` (from the uploaded zip) for the next tier of feature work (whiteboard text tool, host controls, gallery view, emoji/reply/search in chat, breakouts, push notifications) — that table is still accurate and wasn't part of what needed fixing here.
