# AIR Meet / Zoom Web Module — Priority Runbook (to run end-to-end)

> Goal: get **Zoom meeting + Community chat + Social feed + R2 uploads** running.
> Follow this in order (top → bottom). Skip nothing on first setup.

---

## 0) Prerequisites (one-time)

- **Supabase project** created (URL + anon key available).
- **Cloudflare R2** bucket created + a public base URL (either public bucket or CDN domain).
- **HTTPS** for WebRTC on web (Chrome requires https except localhost).

---

## 1) Fix / apply database schema (Supabase SQL Editor)

1. Open Supabase → **SQL Editor**.
2. Run the full file `supabase_schema.sql` from this repo:
   - It now includes:
     - `auth_user_id` linkage
     - meeting_participants RLS fixes (Zoom)
     - community chat tables (+ `chat_message_edits`, `chat_messages.is_edited`)
     - social feed tables (+ RPC helpers)
     - R2 cleanup queue tables

**If you already ran an older schema earlier:** re-run the updated `supabase_schema.sql` — it is mostly idempotent (`IF NOT EXISTS`, `OR REPLACE`).

---

## 2) Enable Realtime tables (Supabase)

In Supabase SQL Editor, run (enable only what you need):

```sql
-- zoom meeting status + participants
ALTER PUBLICATION supabase_realtime ADD TABLE meetings;
ALTER PUBLICATION supabase_realtime ADD TABLE meeting_participants;

-- community chat
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;

-- social feed
ALTER PUBLICATION supabase_realtime ADD TABLE social_posts;
ALTER PUBLICATION supabase_realtime ADD TABLE social_comments;
```

---

## 3) Deploy Edge Function: `recording_manager` (required for R2 file uploads)

This repo contains:

- `supabase/functions/recording_manager/index.ts`

### Required environment variables (Supabase Function secrets)

Set these in Supabase (Functions → Secrets):

- `CLOUDFLARE_ACCOUNT_ID`
- `CLOUDFLARE_R2_ACCESS_KEY_ID`
- `CLOUDFLARE_R2_SECRET_ACCESS_KEY`
- `R2_BUCKET_NAME`
- `R2_PUBLIC_BASE_URL` (example: `https://cdn.yourdomain.com` or your public R2 domain)

### Deploy command (run on your machine)

From your Supabase project folder (where `supabase/` exists):

```bash
supabase functions deploy recording_manager
```

If you don’t have a Supabase CLI project initialized yet, do:

```bash
supabase init
supabase link --project-ref <your-project-ref>
supabase functions deploy recording_manager
```

---

## 4) Flutter: dependencies

From repo root:

```bash
flutter pub get
```

Packages used by what we wired so far:
- `file_picker` (community attach)
- `emoji_picker_flutter` (next: emoji UI)

---

## 5) Flutter: Supabase initialization (required before opening Zoom routes)

Ensure app startup runs:

```dart
await Supabase.initialize(
  url: 'https://YOUR_PROJECT.supabase.co',
  anonKey: 'YOUR_ANON_KEY',
);
```

Then sign-in so `CurrentUser.ensureProfileLoaded()` can load `user_table` (linked by `auth_user_id`).

---

## 6) Run on Web (recommended first)

```bash
flutter run -d chrome
```

Open these routes (GetX):
- `/zoom/community` → community rooms + realtime messages + file attach (R2)
- `/zoom/feed` → social feed + comments (requires social tables)

---

## 7) Minimum smoke checklist (fast)

- **Schema ok**: opening `/zoom/community` shows room list (or “No conversations yet”).
- **Realtime ok**: send a message from one browser profile, other receives without refresh.
- **R2 upload ok**: attach a file in community room → message contains a URL → URL opens/downloads.
- **Social ok**: create a post → appears in feed; add comment → appears in detail view.

---

## 8) If something fails — what to check first

- **RLS blocking** (most common): ensure you are authenticated and `user_table.auth_user_id` is populated.
- **Realtime not firing**: confirm the `ALTER PUBLICATION ... ADD TABLE ...` statements were run.
- **R2 upload fails**: verify Edge Function deployed + secrets set + `R2_PUBLIC_BASE_URL` valid.

---

## 9) Next priorities (feature-complete roadmap)

After the above is running:
- Add **emoji picker** + reactions UI in Community chat.
- Add **social media upload to R2** (images/videos in PostCreateView).
- Add **recording start/stop** (depends on a real recording pipeline; current function only implements `upload_file`).

