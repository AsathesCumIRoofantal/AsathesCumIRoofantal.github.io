# test.md — verify each todolist.md step before moving to the next

Test in order. Each block only tests what its matching `todolist.md` step added — don't skip ahead if a block fails; later blocks assume earlier ones pass.

---

## Test 1 — SQL ran clean (todolist Step 1)

- [ ] Supabase SQL Editor shows no red errors after running the full `supabase_schema.sql` from this delivery.
- [ ] Table Editor shows these tables exist: `user_table`, `chat_rooms`, `chat_messages`, `chat_message_edits`, `meetings`, `meeting_participants`, `meeting_pre_settings`, `social_posts`, `social_reactions`, `social_comments`, `temp_files`, `r2_pending_deletes`.
- [ ] Database → Policies: `chat_rooms` shows **3** policies (`chat_rooms_member_select`, `chat_rooms_member_update`, `chat_rooms_insert`). If you only see 2, the PATCH 2026-08-27 section didn't run — re-run the tail of the file.
- [ ] `social_reactions` shows **4** policies (`sr_select`, `sr_upsert_own`, `sr_delete_own`, `sr_update_own`).
- [ ] Run: `ALTER DATABASE postgres SET app.supabase_url = '...'; ALTER DATABASE postgres SET app.service_role_key = '...';` — confirm no error.

## Test 2 — Realtime enabled (todolist Step 2)

- [ ] Supabase → Database → Replication → `supabase_realtime` publication lists: `meetings`, `meeting_participants`, `chat_messages`, `social_posts`, `social_comments`.

## Test 3 — R2 bucket reachable (todolist Step 3)

- [ ] Upload a test file manually via the Cloudflare dashboard into the bucket.
- [ ] Open `https://YOUR_PUBLIC_BASE_URL/<the-file-key>` in a browser — it loads/downloads. If this fails, fix public access / CDN domain before continuing; nothing downstream will work otherwise.

## Test 4 — Edge Function deployed (todolist Step 4)

- [ ] `supabase functions list` shows `recording_manager` as deployed.
- [ ] `supabase secrets list` shows all 5 secrets set (values hidden, names visible).
- [ ] Smoke-test with curl (replace placeholders; get a JWT by signing in through your app once and pulling it from Supabase Auth debug tools, or from `Supabase.instance.client.auth.currentSession!.accessToken` via a debug print):
  ```bash
  curl -X POST https://YOUR_PROJECT.supabase.co/functions/v1/recording_manager \
    -H "Authorization: Bearer YOUR_USER_JWT" \
    -H "Content-Type: application/json" \
    -d '{"action":"upload_file","roomId":"test","filename":"hello.txt","contentType":"text/plain","dataBase64":"aGVsbG8gd29ybGQ="}'
  ```
  - [ ] Response is `200` with a JSON body containing `url` and `r2Key`.
  - [ ] Opening the returned `url` in a browser shows "hello world".
  - [ ] If you deployed `agora_token_generator` too: same curl pattern against that function with `{"channel":"test","uid":1,"role":"publisher"}` returns `{ token, expiresAt }`.

## Test 5 — Flutter module compiles (todolist Step 5)

- [ ] `flutter pub get` completes with no unresolved version conflicts.
- [ ] `flutter analyze` on the `zoom_agora/` folder — no import-not-found or undefined-symbol errors (warnings are fine).

## Test 6 — App boots with Supabase + GetX wired (todolist Step 6)

- [ ] App launches without a Supabase-initialization crash.
- [ ] Sign in (through your host app's existing auth flow).
- [ ] Add a temporary debug print or breakpoint after `CurrentUser.ensureProfileLoaded()` — confirm `CurrentUser.id` returns a non-null UUID and `CurrentUser.name` is not "Guest".
- [ ] In Supabase Table Editor → `user_table`: a row exists with your `auth_user_id` populated and matching the signed-in user.

## Test 7 — Platform permissions fire (todolist Step 7)

- [ ] **Android**: on first camera/mic use, the OS permission dialog appears (not a silent failure).
- [ ] **iOS**: same — camera/mic dialogs appear with your custom usage-description text.
- [ ] **Web**: served over `https://` (or `localhost`); no console error about insecure context blocking `getUserMedia`.

## Test 8 — RTC backend choice works (todolist Step 8)

If you kept **Agora**:
- [ ] `RtcConfig.fromEnvironment()` picks up your `--dart-define=AppIdAgorra=...` value (`appId` non-empty at runtime — debug print it).
- [ ] `demoMode` is `false` once the App ID is set.
- [ ] Joining a meeting calls `agora_token_generator` successfully (watch the Network tab / Supabase function logs) — no 404.

If you switched to **WebRTC**:
- [ ] `RtcConfig` default now shows `backend: RtcBackend.webrtc` in code.
- [ ] Joining a meeting does **not** call any Agora-related function; `services/signaling_service.dart` traffic appears in Supabase Realtime instead.

## Test 9 — TURN reachable (todolist Step 9, WebRTC path only)

- [ ] From a network you don't control (e.g. mobile data, not the same LAN as your dev machine), two participants can still connect video. If they can connect on the same Wi-Fi but not across networks, TURN isn't actually being used — check `iceServers` includes your TURN entry and that the TURN server is reachable (`turnutils_uclient` or an online WebRTC TURN test tool).

## Test 10 — First real run (todolist Step 10) — use `ZOOM_RUNBOOK_PRIORITY.md`'s smoke checklist

- [ ] `flutter run -d chrome`, navigate to `/zoom` — home screen renders with no red error screen.
- [ ] `/zoom/community` → shows room list or "No conversations yet" (**not** an RLS error in the console — this is the direct test of Fix #1/#2 above).
- [ ] Create a new community/DM room from the UI → row appears in `chat_rooms` table in Supabase.
- [ ] Send a message in a room from Browser Profile A → Browser Profile B (same room, signed in as a different member) receives it without refreshing.
- [ ] Attach a file/image in a community room → uploads (this is the direct test of Fix #5 — `upload_file`) → message bubble shows a working URL.
- [ ] `/zoom/feed` → posts load (may be empty on first run — that's fine, confirms no RLS error).
- [ ] Create a post with an image → uploads to R2, appears in feed.
- [ ] Like/react to a post → count increments. **Then change your reaction to a different emoji on the same post** — this is the direct test of Fix #3 (`social_reactions` UPDATE policy); confirm the count updates rather than silently no-op'ing.
- [ ] Open comments on a post → add a comment → appears, `comment_count` increments.
- [ ] Two devices/tabs, same meeting `channelId` → both see each other's video tile, mute/unmute reflects on the other side, screen share works.

## Test 11 — Flagged-as-not-implemented features (todolist Step 11)

These are expected to **not** work yet (per both READMEs) — confirm they fail *honestly*, not silently:
- [ ] Push notification button/flow shows a clear "not configured" state, not a crash or a fake success toast.
- [ ] Calendar push (Google/Outlook) shows the same.
- [ ] Virtual background picker says clearly it isn't implemented (per the "UI action audit" section of the README — this was already fixed once; regressions here mean something got reverted).
- [ ] Cloud recording start/stop **does** work once Step 4 is deployed (this one *is* implemented) — red dot pulses on start, snackbar with a working R2 URL on stop.

---

## If a test fails — quick triage

| Symptom | Likely cause | Where to look |
|---|---|---|
| `/zoom/community` throws or silently shows nothing even after Fix #1/#2 | SQL patch didn't run, or ran against a different Supabase project than the app connects to | Re-check Test 1; check `Supabase.initialize(url: ...)` matches the project you ran the SQL in |
| Any insert/select "violates row-level security policy" | `CurrentUser.ensureProfileLoaded()` wasn't called, or `user_table` row missing | Test 6 |
| File attach 400s with "Unknown action" | Deployed the *old* `recording_manager/index.ts` instead of this delivery's corrected one | Re-deploy from `recording_manager_index.ts` in this delivery |
| Realtime doesn't fire, but manual refresh shows the data | Table missing from `supabase_realtime` publication | Test 2 |
| Video never connects across two different networks | No TURN server, or TURN credentials wrong | Test 9 |
| Joining a meeting 404s calling a function | `agora_token_generator` not deployed but backend is still `agora` | Step 8 — either deploy it or switch to `webrtc` |
