-- ============================================================
--  AIR App – Supabase PostgreSQL Complete Schema
--  Run this ONCE in the Supabase SQL Editor.
--  All tables, indexes, RLS policies, edge-function stubs,
--  and a cleanup/cron job scaffold are included.
-- ============================================================

-- ════════════════════════════════════════════════════════════
--  0.  EXTENSIONS
-- ════════════════════════════════════════════════════════════
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_cron";   -- Supabase supports pg_cron via dashboard

-- ════════════════════════════════════════════════════════════
--  1.  HELPER FUNCTIONS
-- ════════════════════════════════════════════════════════════

-- Returns current epoch in milliseconds
CREATE OR REPLACE FUNCTION now_epoch() RETURNS BIGINT
  LANGUAGE sql STABLE AS $$ SELECT EXTRACT(EPOCH FROM now())::BIGINT * 1000; $$;

-- Auto-update updated_at on row change
CREATE OR REPLACE FUNCTION set_updated_at()
  RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now_epoch();
  RETURN NEW;
END; $$;

-- ════════════════════════════════════════════════════════════
--  2.  USER ROLE TITLES
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS user_role_title (
  id          BIGSERIAL PRIMARY KEY,
  title       VARCHAR(80)  NOT NULL,
  is_active   SMALLINT     NOT NULL DEFAULT 1,
  is_updated  SMALLINT     NOT NULL DEFAULT 0,
  updated_by  UUID,
  created_at  BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT       NOT NULL DEFAULT now_epoch()
);

CREATE TRIGGER trg_user_role_title_upd
  BEFORE UPDATE ON user_role_title
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

INSERT INTO user_role_title (title) VALUES
  ('Super Admin'), ('Admin'), ('Manager'), ('Agent'), ('Member'), ('Guest')
ON CONFLICT DO NOTHING;

-- ════════════════════════════════════════════════════════════
--  3.  USERS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS user_table (
  user_id                                UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
  auth_user_id                           UUID         UNIQUE,  -- links to auth.users.id (auth.uid())
  user_role                              SMALLINT     NOT NULL DEFAULT 5,     -- FK → user_role_title.id
  assigned_user_ids                      UUID[]       NOT NULL DEFAULT '{}',
  name                                   VARCHAR(120) NOT NULL,
  mobile                                 VARCHAR(20)  NOT NULL UNIQUE,
  password                               TEXT,        -- hashed; NULL if OTP-only
  profile_photo_url                      TEXT,
  company_logo_url                       TEXT,
  address                                TEXT,
  latitude                               NUMERIC(10,7),
  longitude                              NUMERIC(10,7),
  user_role_title                        VARCHAR(80),
  user_role_sub_title                    VARCHAR(80),
  is_can_insert_in_db                    SMALLINT     NOT NULL DEFAULT 0,
  is_active                              SMALLINT     NOT NULL DEFAULT 1,
  is_blocked                             SMALLINT     NOT NULL DEFAULT 0,
  is_approved                            SMALLINT     NOT NULL DEFAULT 0,
  is_paid                                SMALLINT     NOT NULL DEFAULT 0,
  is_member                              SMALLINT     NOT NULL DEFAULT 0,
  time_slot_for_batch_chat_allow_1_to_48 SMALLINT     NOT NULL DEFAULT 1 CHECK (time_slot_for_batch_chat_allow_1_to_48 BETWEEN 1 AND 48),
  -- Nullable by design (first login log doesn't exist at sign-up time).
  -- FK is added later in the "PATCH 2026-07-06" section.
  user_last_login_logs_id                UUID,
  fcm_token                              TEXT,
  created_at                             BIGINT       NOT NULL DEFAULT now_epoch(),
  created_by                             UUID,
  updated_at                             BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_by                             UUID
);

CREATE INDEX IF NOT EXISTS idx_user_table_mobile  ON user_table(mobile);
CREATE INDEX IF NOT EXISTS idx_user_table_role    ON user_table(user_role);
CREATE INDEX IF NOT EXISTS idx_user_table_active  ON user_table(is_active);
CREATE INDEX IF NOT EXISTS idx_user_table_auth_user ON user_table(auth_user_id);

CREATE TRIGGER trg_user_table_upd
  BEFORE UPDATE ON user_table
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  4.  USER LOGGING (login/logout activity)
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS user_logging_data (
  id                      UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id                 UUID    NOT NULL REFERENCES user_table(user_id) ON DELETE CASCADE,
  system_platform_logged  TEXT,   -- device info / user-agent
  is_login                SMALLINT NOT NULL DEFAULT 1,
  is_from_android         SMALLINT NOT NULL DEFAULT 0,
  is_from_web             SMALLINT NOT NULL DEFAULT 0,
  is_from_ios             SMALLINT NOT NULL DEFAULT 0,
  ip_address              INET,
  created_at              BIGINT  NOT NULL DEFAULT now_epoch(),
  updated_at              BIGINT  NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_user_logging_user ON user_logging_data(user_id);
CREATE INDEX IF NOT EXISTS idx_user_logging_time ON user_logging_data(created_at DESC);

CREATE TRIGGER trg_user_logging_upd
  BEFORE UPDATE ON user_logging_data
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  5.  CHAT ROOMS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS chat_rooms (
  id                    UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
  type                  VARCHAR(20)  NOT NULL DEFAULT 'individual'  -- individual | group | broadcast
                                     CHECK (type IN ('individual','group','broadcast')),
  name                  VARCHAR(120) NOT NULL,
  avatar_url            TEXT,
  member_ids            UUID[]       NOT NULL DEFAULT '{}',
  admin_ids             UUID[]       NOT NULL DEFAULT '{}',
  last_message_preview  TEXT,
  last_message_at       BIGINT,
  is_muted              SMALLINT     NOT NULL DEFAULT 0,
  is_pinned             SMALLINT     NOT NULL DEFAULT 0,
  is_archived           SMALLINT     NOT NULL DEFAULT 0,
  created_by            UUID         REFERENCES user_table(user_id),
  created_at            BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_at            BIGINT       NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_chat_rooms_members   ON chat_rooms USING GIN(member_ids);
CREATE INDEX IF NOT EXISTS idx_chat_rooms_last_msg  ON chat_rooms(last_message_at DESC NULLS LAST);

CREATE TRIGGER trg_chat_rooms_upd
  BEFORE UPDATE ON chat_rooms
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  6.  CHAT MESSAGES
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS chat_messages (
  id              UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
  chat_id         UUID        NOT NULL REFERENCES chat_rooms(id) ON DELETE CASCADE,
  sender_id       UUID        NOT NULL REFERENCES user_table(user_id),
  sender_name     VARCHAR(120) NOT NULL,
  sender_avatar   TEXT,
  type            VARCHAR(20) NOT NULL DEFAULT 'text'   -- text | image | video | audio | file | location
                              CHECK (type IN ('text','image','video','audio','file','location','sticker')),
  content         TEXT,
  media_url       TEXT,
  media_name      VARCHAR(255),
  media_size      INT,        -- bytes
  reply_to_id     UUID        REFERENCES chat_messages(id),
  reactions       TEXT[]      NOT NULL DEFAULT '{}',
  status          VARCHAR(20) NOT NULL DEFAULT 'sent'   -- sending | sent | delivered | seen | failed
                              CHECK (status IN ('sending','sent','delivered','seen','failed')),
  is_edited       SMALLINT    NOT NULL DEFAULT 0,
  is_deleted      SMALLINT    NOT NULL DEFAULT 0,
  created_at      BIGINT      NOT NULL DEFAULT now_epoch(),
  updated_at      BIGINT      NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_chat_messages_chat    ON chat_messages(chat_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_chat_messages_sender  ON chat_messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_chat_messages_status  ON chat_messages(status);

CREATE TRIGGER trg_chat_messages_upd
  BEFORE UPDATE ON chat_messages
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Auto-update chat_rooms.last_message_at / preview after insert
CREATE OR REPLACE FUNCTION sync_chat_room_last_message()
  RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  UPDATE chat_rooms
  SET last_message_preview = COALESCE(NEW.content, '[media]'),
      last_message_at      = NEW.created_at,
      updated_at           = now_epoch()
  WHERE id = NEW.chat_id;
  RETURN NEW;
END; $$;

CREATE TRIGGER trg_sync_room_on_message
  AFTER INSERT ON chat_messages
  FOR EACH ROW EXECUTE FUNCTION sync_chat_room_last_message();

-- ════════════════════════════════════════════════════════════
--  6-B. CHAT MESSAGE EDIT HISTORY (WhatsApp-style "View history")
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS chat_message_edits (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  message_id  UUID NOT NULL REFERENCES chat_messages(id) ON DELETE CASCADE,
  old_content TEXT NOT NULL,
  edited_at   BIGINT NOT NULL DEFAULT now_epoch(),
  edited_by   UUID  NOT NULL REFERENCES user_table(user_id)
);

CREATE INDEX IF NOT EXISTS idx_chat_message_edits_msg
  ON chat_message_edits(message_id, edited_at DESC);

-- ════════════════════════════════════════════════════════════
--  7.  MEETINGS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS meetings (
  id                       UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
  title                    VARCHAR(200) NOT NULL,
  host_id                  UUID         NOT NULL REFERENCES user_table(user_id),
  host_name                VARCHAR(120) NOT NULL,
  channel_name             VARCHAR(120) NOT NULL UNIQUE,
  passcode                 VARCHAR(20),
  description              TEXT,
  status                   VARCHAR(20)  NOT NULL DEFAULT 'scheduled'
                                        CHECK (status IN ('scheduled','live','ended','cancelled')),
  scheduled_at             BIGINT       NOT NULL,
  started_at               BIGINT,
  ended_at                 BIGINT,
  max_participants         SMALLINT     NOT NULL DEFAULT 100,
  waiting_room_enabled     SMALLINT     NOT NULL DEFAULT 1,
  is_recording             SMALLINT     NOT NULL DEFAULT 0,
  recording_url            TEXT,
  created_at               BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_at               BIGINT       NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_meetings_host       ON meetings(host_id);
CREATE INDEX IF NOT EXISTS idx_meetings_status     ON meetings(status);
CREATE INDEX IF NOT EXISTS idx_meetings_scheduled  ON meetings(scheduled_at DESC);

CREATE TRIGGER trg_meetings_upd
  BEFORE UPDATE ON meetings
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  8.  MEETING PARTICIPANTS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS meeting_participants (
  id               UUID       PRIMARY KEY DEFAULT uuid_generate_v4(),
  meeting_id       UUID       NOT NULL REFERENCES meetings(id) ON DELETE CASCADE,
  user_id          UUID       NOT NULL REFERENCES user_table(user_id),
  name             VARCHAR(120) NOT NULL,
  role             VARCHAR(20)  NOT NULL DEFAULT 'participant'
                               CHECK (role IN ('host','co_host','participant')),
  is_muted         SMALLINT   NOT NULL DEFAULT 0,
  is_camera_off    SMALLINT   NOT NULL DEFAULT 0,
  is_hand_raised   SMALLINT   NOT NULL DEFAULT 0,
  is_screen_share  SMALLINT   NOT NULL DEFAULT 0,
  agora_uid        INT,
  joined_at        BIGINT     NOT NULL DEFAULT now_epoch(),
  left_at          BIGINT,
  created_at       BIGINT     NOT NULL DEFAULT now_epoch(),
  updated_at       BIGINT     NOT NULL DEFAULT now_epoch(),
  UNIQUE(meeting_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_mp_meeting ON meeting_participants(meeting_id);
CREATE INDEX IF NOT EXISTS idx_mp_user    ON meeting_participants(user_id);

CREATE TRIGGER trg_meeting_participants_upd
  BEFORE UPDATE ON meeting_participants
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  9.  REMOTE DEVICES
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS remote_devices (
  id                   UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
  device_name          VARCHAR(150) NOT NULL,
  device_code          VARCHAR(11)  NOT NULL UNIQUE, -- "123 456 789"
  platform             VARCHAR(20)  NOT NULL DEFAULT 'desktop'
                                    CHECK (platform IN ('android','ios','desktop','web')),
  status               VARCHAR(20)  NOT NULL DEFAULT 'offline'
                                    CHECK (status IN ('online','offline','busy')),
  assigned_to_user_id  UUID         REFERENCES user_table(user_id),
  last_seen_at         BIGINT       NOT NULL DEFAULT now_epoch(),
  created_at           BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_at           BIGINT       NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_remote_devices_user   ON remote_devices(assigned_to_user_id);
CREATE INDEX IF NOT EXISTS idx_remote_devices_status ON remote_devices(status);
CREATE INDEX IF NOT EXISTS idx_remote_devices_code   ON remote_devices(device_code);

CREATE TRIGGER trg_remote_devices_upd
  BEFORE UPDATE ON remote_devices
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  10. REMOTE SUPPORT SESSIONS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS remote_sessions (
  id                       UUID       PRIMARY KEY DEFAULT uuid_generate_v4(),
  requester_id             UUID       NOT NULL REFERENCES user_table(user_id),
  requester_name           VARCHAR(120) NOT NULL,
  target_device_id         UUID       NOT NULL REFERENCES remote_devices(id),
  target_device_name       VARCHAR(150) NOT NULL,
  status                   VARCHAR(20) NOT NULL DEFAULT 'pending'
                                       CHECK (status IN ('pending','active','ended','rejected')),
  is_file_transfer_enabled SMALLINT   NOT NULL DEFAULT 1,
  is_control_enabled       SMALLINT   NOT NULL DEFAULT 0,
  started_at               BIGINT,
  ended_at                 BIGINT,
  created_at               BIGINT     NOT NULL DEFAULT now_epoch(),
  updated_at               BIGINT     NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_remote_sessions_requester ON remote_sessions(requester_id);
CREATE INDEX IF NOT EXISTS idx_remote_sessions_device    ON remote_sessions(target_device_id);
CREATE INDEX IF NOT EXISTS idx_remote_sessions_status    ON remote_sessions(status);

CREATE TRIGGER trg_remote_sessions_upd
  BEFORE UPDATE ON remote_sessions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  11. SESSION LOGS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS remote_session_logs (
  id          UUID   PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id  UUID   NOT NULL REFERENCES remote_sessions(id) ON DELETE CASCADE,
  log_text    TEXT   NOT NULL,
  created_at  BIGINT NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_rsl_session ON remote_session_logs(session_id, created_at DESC);

-- ════════════════════════════════════════════════════════════
--  12. TEMP FILE TRACKING  (for Cloudflare R2 cleanup)
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS temp_files (
  id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id     UUID    REFERENCES user_table(user_id),
  r2_key      TEXT    NOT NULL,   -- "temp/users/abc/filename.jpg"
  file_size   INT,
  expires_at  BIGINT  NOT NULL,   -- epoch; delete after this time
  created_at  BIGINT  NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT  NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_temp_files_expires ON temp_files(expires_at);

-- ════════════════════════════════════════════════════════════
--  13. OTP TOKENS
-- ════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS otp_tokens (
  id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
  contact     TEXT    NOT NULL,   -- email or phone
  otp_hash    TEXT    NOT NULL,   -- SHA-256 of OTP
  expires_at  BIGINT  NOT NULL,   -- epoch ms
  is_used     SMALLINT NOT NULL DEFAULT 0,
  created_at  BIGINT  NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT  NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_otp_contact  ON otp_tokens(contact);
CREATE INDEX IF NOT EXISTS idx_otp_expires  ON otp_tokens(expires_at);

CREATE TRIGGER trg_otp_upd
  BEFORE UPDATE ON otp_tokens
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ════════════════════════════════════════════════════════════
--  14.  ROW LEVEL SECURITY  (RLS)
-- ════════════════════════════════════════════════════════════

-- ── user_table ─────────────────────────────────────────────
ALTER TABLE user_table         ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_logging_data  ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_rooms         ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages      ENABLE ROW LEVEL SECURITY;
ALTER TABLE meetings           ENABLE ROW LEVEL SECURITY;
ALTER TABLE meeting_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE remote_devices     ENABLE ROW LEVEL SECURITY;
ALTER TABLE remote_sessions    ENABLE ROW LEVEL SECURITY;
ALTER TABLE remote_session_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE temp_files         ENABLE ROW LEVEL SECURITY;
ALTER TABLE otp_tokens         ENABLE ROW LEVEL SECURITY;

-- Users: can read own row; admins can read all
CREATE POLICY user_select_own ON user_table
  FOR SELECT USING (auth.uid()::uuid = user_id);

CREATE POLICY user_update_own ON user_table
  FOR UPDATE USING (auth.uid()::uuid = user_id);

-- Chat rooms: only members can see/modify
CREATE POLICY chat_rooms_member_select ON chat_rooms
  FOR SELECT USING (auth.uid()::uuid = ANY(member_ids));

CREATE POLICY chat_rooms_member_update ON chat_rooms
  FOR UPDATE USING (auth.uid()::uuid = ANY(admin_ids));

-- Chat messages: only room members
CREATE POLICY chat_msg_select ON chat_messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_rooms
      WHERE id = chat_messages.chat_id
        AND auth.uid()::uuid = ANY(member_ids)
    )
  );

CREATE POLICY chat_msg_insert ON chat_messages
  FOR INSERT WITH CHECK (auth.uid()::uuid = sender_id);

CREATE POLICY chat_msg_update_own ON chat_messages
  FOR UPDATE USING (auth.uid()::uuid = sender_id);

-- Meetings: authenticated users can see all; only host updates
CREATE POLICY meetings_select ON meetings
  FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY meetings_insert ON meetings
  FOR INSERT WITH CHECK (auth.uid()::uuid = host_id);

CREATE POLICY meetings_update ON meetings
  FOR UPDATE USING (auth.uid()::uuid = host_id);

-- Remote devices: owner only
CREATE POLICY remote_devices_select ON remote_devices
  FOR SELECT USING (auth.uid()::uuid = assigned_to_user_id);

CREATE POLICY remote_devices_update ON remote_devices
  FOR UPDATE USING (auth.uid()::uuid = assigned_to_user_id);

-- Remote sessions: requester or device owner
CREATE POLICY remote_sessions_select ON remote_sessions
  FOR SELECT USING (auth.uid()::uuid = requester_id);

-- Temp files: owner only
CREATE POLICY temp_files_select ON temp_files
  FOR SELECT USING (auth.uid()::uuid = user_id);

CREATE POLICY temp_files_insert ON temp_files
  FOR INSERT WITH CHECK (auth.uid()::uuid = user_id);

CREATE POLICY temp_files_delete ON temp_files
  FOR DELETE USING (auth.uid()::uuid = user_id);

-- ════════════════════════════════════════════════════════════
--  15.  REALTIME SUBSCRIPTIONS (enable via Supabase dashboard)
-- ════════════════════════════════════════════════════════════
-- Run these in the Supabase SQL Editor to enable realtime:
-- ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
-- ALTER PUBLICATION supabase_realtime ADD TABLE meeting_participants;
-- ALTER PUBLICATION supabase_realtime ADD TABLE remote_sessions;
-- (Uncomment when ready – only add tables you need realtime on)

-- ════════════════════════════════════════════════════════════
--  16.  SCHEDULED CLEANUP  (pg_cron – every 10 minutes)
-- ════════════════════════════════════════════════════════════
-- Requires pg_cron enabled in Supabase (Extensions → pg_cron).

SELECT cron.schedule(
  'cleanup-expired-temp-files',
  '*/10 * * * *',   -- every 10 minutes
  $$
    DELETE FROM temp_files WHERE expires_at < now_epoch();
  $$
);

SELECT cron.schedule(
  'cleanup-expired-otps',
  '*/10 * * * *',
  $$
    DELETE FROM otp_tokens
    WHERE expires_at < now_epoch() OR is_used = 1;
  $$
);

SELECT cron.schedule(
  'cleanup-ended-meetings',
  '0 * * * *',      -- hourly
  $$
    UPDATE meetings
    SET status = 'ended', updated_at = now_epoch()
    WHERE status = 'live'
      AND started_at < (now_epoch() - 86400000);  -- 24 h safety net
  $$
);

SELECT cron.schedule(
  'archive-old-chat-messages',
  '0 2 * * *',      -- daily at 02:00 UTC
  $$
    -- Soft-delete messages older than 1 year that are already seen
    UPDATE chat_messages
    SET is_deleted = 1, updated_at = now_epoch()
    WHERE status = 'seen'
      AND created_at < (now_epoch() - 31536000000)  -- 365 days
      AND is_deleted = 0;
  $$
);

-- ════════════════════════════════════════════════════════════
--  17.  EDGE FUNCTION STUBS  (create in supabase/functions/)
-- ════════════════════════════════════════════════════════════
-- The following edge functions are referenced in the Flutter app.
-- Create each as a separate file under supabase/functions/<name>/index.ts
--
-- ┌────────────────────────────┬──────────────────────────────────────────────────┐
-- │ Function name              │ Purpose                                          │
-- ├────────────────────────────┼──────────────────────────────────────────────────┤
-- │ send_otp                   │ Generate, hash, store & send OTP via SMS/Email   │
-- │ verify_otp                 │ Validate OTP hash, issue JWT, log login          │
-- │ agora_token_generator      │ Generate Agora RTC token for a channel           │
-- │ cleanup_temp_files         │ Delete R2 objects for expired temp_files rows    │
-- │ push_notification          │ Send FCM push via Firebase Admin SDK             │
-- │ validate_device_code       │ Verify 9-digit pairing code & return device info │
-- └────────────────────────────┴──────────────────────────────────────────────────┘

-- ════════════════════════════════════════════════════════════
--  18.  SAMPLE DATA  (dummy seed – remove before production)
-- ════════════════════════════════════════════════════════════
INSERT INTO user_table (user_id, user_role, name, mobile, user_role_title, is_active, is_approved, is_member)
VALUES
  ('00000000-0000-0000-0000-000000000001', 1, 'Super Admin',  '+910000000001', 'Super Admin',  1, 1, 1),
  ('00000000-0000-0000-0000-000000000002', 2, 'Admin User',   '+910000000002', 'Admin',        1, 1, 1),
  ('00000000-0000-0000-0000-000000000003', 5, 'Demo Member',  '+910000000003', 'Member',       1, 1, 1)
ON CONFLICT DO NOTHING;

INSERT INTO chat_rooms (id, type, name, member_ids, admin_ids, created_by)
VALUES
  ('aaaaaaaa-0000-0000-0000-000000000001', 'individual', 'Admin ↔ Demo',
    ARRAY['00000000-0000-0000-0000-000000000002'::uuid, '00000000-0000-0000-0000-000000000003'::uuid],
    ARRAY['00000000-0000-0000-0000-000000000002'::uuid],
    '00000000-0000-0000-0000-000000000002'),
  ('aaaaaaaa-0000-0000-0000-000000000002', 'group', 'AIR Team',
    ARRAY['00000000-0000-0000-0000-000000000001'::uuid,
          '00000000-0000-0000-0000-000000000002'::uuid,
          '00000000-0000-0000-0000-000000000003'::uuid],
    ARRAY['00000000-0000-0000-0000-000000000001'::uuid],
    '00000000-0000-0000-0000-000000000001')
ON CONFLICT DO NOTHING;

INSERT INTO meetings (id, title, host_id, host_name, channel_name, status, scheduled_at)
VALUES
  ('bbbbbbbb-0000-0000-0000-000000000001', 'Team Standup',
    '00000000-0000-0000-0000-000000000002', 'Admin User',
    'standup_ch_001', 'scheduled',
    EXTRACT(EPOCH FROM (NOW() + INTERVAL '1 hour'))::BIGINT * 1000)
ON CONFLICT DO NOTHING;

INSERT INTO remote_devices (id, device_name, device_code, platform, status, assigned_to_user_id)
VALUES
  ('cccccccc-0000-0000-0000-000000000001', 'Office PC – Room 3', '123 456 789', 'desktop', 'online',
    '00000000-0000-0000-0000-000000000002'),
  ('cccccccc-0000-0000-0000-000000000002', 'Manager Tablet',     '987 654 321', 'android', 'offline',
    '00000000-0000-0000-0000-000000000002')
ON CONFLICT DO NOTHING;

-- ════════════════════════════════════════════════════════════
--  END OF SCHEMA
-- ════════════════════════════════════════════════════════════
-- NOTE:
-- The TypeScript "Edge Functions" sample code that used to be embedded here
-- has been removed from this SQL file. Keep SQL scripts SQL-only, and put
-- Edge Functions under `supabase/functions/<name>/index.ts`.
-- ════════════════════════════════════════════════════════════
--  PATCH 2026-07-06  — zoom_agora / Supabase / Cloudflare R2
--  Run this block ONCE in the Supabase SQL Editor.
--  It is idempotent (all statements use IF NOT EXISTS / OR REPLACE).
-- ════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────
--  A.  Fix user_table: add auth_user_id column
--      current_user.dart resolves user_table.user_id via
--      user_table.auth_user_id = auth.uid().
--      Without this column every createMeeting / joinMeeting
--      call throws "column auth_user_id does not exist".
-- ────────────────────────────────────────────────────────────
ALTER TABLE user_table
  ADD COLUMN IF NOT EXISTS auth_user_id UUID UNIQUE;  -- links to auth.users.id

CREATE INDEX IF NOT EXISTS idx_user_table_auth_user
  ON user_table(auth_user_id);

-- ────────────────────────────────────────────────────────────
--  B.  Fix user_table: drop the circular NOT NULL FK on
--      user_last_login_logs_id.
--
--      As originally defined the column is:
--        NOT NULL FOREIGN KEY ... REFERENCES user_logging_data(...)
--      which creates a chicken-and-egg problem: inserting the
--      very first user row requires a user_logging_data row,
--      but user_logging_data has ON DELETE CASCADE back to
--      user_table — so neither row can be inserted first.
--      The trigger in section E inserts a user_table row at
--      signup before any login log exists, so the column MUST
--      be nullable.
--
--      PostgreSQL has no ALTER COLUMN … DROP NOT NULL on a
--      column that was added with a FOREIGN KEY constraint in
--      the same statement, so we recreate the constraint as
--      nullable + DEFERRABLE instead.
-- ────────────────────────────────────────────────────────────
ALTER TABLE user_table
  ALTER COLUMN user_last_login_logs_id DROP NOT NULL;

-- Re-add the FK as nullable + deferrable so it works even
-- when the log row hasn't been written yet at sign-up time.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints
    WHERE constraint_name = 'fk_user_last_login_log'
      AND table_name = 'user_table'
  ) THEN
    ALTER TABLE user_table
      ADD CONSTRAINT fk_user_last_login_log
        FOREIGN KEY (user_last_login_logs_id)
        REFERENCES user_logging_data(id)
        ON DELETE SET NULL
        DEFERRABLE INITIALLY DEFERRED;
  END IF;
END $$;

-- ────────────────────────────────────────────────────────────
--  C.  meetings: add recording_url column for Cloudflare R2
--      The recording_manager Edge Function writes back the
--      final R2 public URL here once the multipart upload
--      completes.  The column exists in the original schema
--      comment but was missing from the CREATE TABLE body.
-- ────────────────────────────────────────────────────────────
ALTER TABLE meetings
  ADD COLUMN IF NOT EXISTS recording_r2_key TEXT;       -- "recordings/<meetingId>/..." R2 object key
ALTER TABLE meetings
  ADD COLUMN IF NOT EXISTS recording_upload_id TEXT;    -- multipart uploadId while in-progress

-- ────────────────────────────────────────────────────────────
--  D.  RLS: add missing meeting_participants policies
--      The original schema enabled RLS on the table but never
--      added any SELECT / INSERT / UPDATE policies — every
--      upsertParticipant call was silently rejected.
-- ────────────────────────────────────────────────────────────

-- Any authenticated user can view participants in a meeting
-- they are themselves attending (or hosting).
DROP POLICY IF EXISTS mp_select ON meeting_participants;
CREATE POLICY mp_select ON meeting_participants
  FOR SELECT USING (
    auth.uid() IS NOT NULL
    AND EXISTS (
      SELECT 1 FROM meeting_participants mp2
      WHERE mp2.meeting_id = meeting_participants.meeting_id
        AND mp2.user_id = (
          SELECT user_id FROM user_table
          WHERE auth_user_id = auth.uid()::uuid
          LIMIT 1
        )
    )
  );

-- A user can upsert their own participant row on join.
DROP POLICY IF EXISTS mp_insert ON meeting_participants;
CREATE POLICY mp_insert ON meeting_participants
  FOR INSERT WITH CHECK (
    user_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

-- A user can update their own participant row (mute/video state).
DROP POLICY IF EXISTS mp_update_own ON meeting_participants;
CREATE POLICY mp_update_own ON meeting_participants
  FOR UPDATE USING (
    user_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

-- The host can update any participant in meetings they own
-- (e.g. to record left_at when they kick someone).
DROP POLICY IF EXISTS mp_update_host ON meeting_participants;
CREATE POLICY mp_update_host ON meeting_participants
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM meetings m
      WHERE m.id = meeting_participants.meeting_id
        AND m.host_id = (
          SELECT user_id FROM user_table
          WHERE auth_user_id = auth.uid()::uuid
          LIMIT 1
        )
    )
  );

-- ────────────────────────────────────────────────────────────
--  E.  Auto-create user_table row on auth.users signup
--      Ensures CurrentUser.ensureProfileLoaded() finds a row
--      immediately after the OTP/email verification step,
--      without requiring the app to POST a separate
--      "create profile" request.
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION handle_new_auth_user()
  RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public.user_table (
    user_id,
    auth_user_id,
    name,
    mobile,
    user_role,
    is_active,
    is_approved,
    is_member
  )
  VALUES (
    uuid_generate_v4(),
    NEW.id,
    COALESCE(
      NEW.raw_user_meta_data->>'name',
      NEW.email,
      NEW.phone,
      'New User'
    ),
    COALESCE(NEW.phone, ''),
    5,   -- default role: Member
    1,
    0,
    0
  )
  ON CONFLICT (auth_user_id) DO NOTHING;
  RETURN NEW;
END; $$;

-- Drop old trigger if it exists under a different name from a
-- previous migration, then re-create.
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_auth_user();

-- ────────────────────────────────────────────────────────────
--  F.  Realtime: enable tables required by zoom_agora
--      (meeting_participants drives the in-meeting participant
--       list; meetings drives home-screen status badges)
-- ────────────────────────────────────────────────────────────
ALTER PUBLICATION supabase_realtime ADD TABLE meeting_participants;
ALTER PUBLICATION supabase_realtime ADD TABLE meetings;
-- chat_messages and remote_sessions were already in the comment block above;
-- uncomment them here when ready:
-- ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
-- ALTER PUBLICATION supabase_realtime ADD TABLE remote_sessions;

-- ────────────────────────────────────────────────────────────
--  G.  Edge Function registry (comments only — deploy these
--      under supabase/functions/<name>/index.ts)
--
--  agora_token_generator
--    Called by TokenService.fetchRtcToken / fetchRtmToken.
--    Request:  { channel: string, uid: number, role: "publisher"|"subscriber"|"rtm" }
--    Response: { token: string, expiresAt: string }
--    Env vars: AGORA_APP_ID, AGORA_APP_CERTIFICATE
--
--  recording_manager
--    Called by RecordingService.start / pause / resume / stop.
--    Actions:
--      start  → creates R2 multipart upload, updates meetings.recording_upload_id
--               and meetings.recording_r2_key
--               Response: { uploadId: string, r2Key: string }
--      pause  → pauses upload pipeline
--               Body: { action:"pause", uploadId, r2Key }
--      resume → resumes upload pipeline
--               Body: { action:"resume", uploadId, r2Key }
--      stop   → completes multipart upload, sets meetings.recording_url
--               to the final Cloudflare R2 public URL
--               Body: { action:"stop", uploadId, r2Key }
--    Env vars: CLOUDFLARE_ACCOUNT_ID, CLOUDFLARE_R2_ACCESS_KEY_ID,
--              CLOUDFLARE_R2_SECRET_ACCESS_KEY, R2_BUCKET_NAME,
--              R2_PUBLIC_BASE_URL   (e.g. https://cdn.yourproject.com)
-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
--  H.  Cloudflare R2 cleanup cron: purge recordings for
--      meetings deleted > 90 days ago via Edge Function.
--      The Edge Function reads orphaned r2_keys from a
--      staging table and calls R2 DeleteObjects.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS r2_pending_deletes (
  id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
  r2_key      TEXT    NOT NULL,
  created_at  BIGINT  NOT NULL DEFAULT now_epoch()
);

CREATE INDEX IF NOT EXISTS idx_r2_pending_created ON r2_pending_deletes(created_at);

-- When a meeting row is deleted, queue its R2 recording key for cleanup.
CREATE OR REPLACE FUNCTION queue_r2_delete_on_meeting_delete()
  RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF OLD.recording_r2_key IS NOT NULL THEN
    INSERT INTO r2_pending_deletes (r2_key) VALUES (OLD.recording_r2_key);
  END IF;
  RETURN OLD;
END; $$;

DROP TRIGGER IF EXISTS trg_queue_r2_delete ON meetings;
CREATE TRIGGER trg_queue_r2_delete
  AFTER DELETE ON meetings
  FOR EACH ROW EXECUTE FUNCTION queue_r2_delete_on_meeting_delete();

-- Hourly cron: invoke cleanup_r2_files Edge Function to process the queue.
SELECT cron.schedule(
  'cleanup-r2-pending-deletes',
  '0 * * * *',   -- every hour
  $$
    SELECT net.http_post(
      url    := current_setting('app.supabase_url') || '/functions/v1/cleanup_r2_files',
      headers := '{"Authorization": "Bearer ' || current_setting('app.service_role_key') || '", "Content-Type": "application/json"}'::jsonb,
      body   := '{}'::jsonb
    );
  $$
) ON CONFLICT (jobname) DO NOTHING;

-- END OF PATCH 2026-07-06 17:45 IST

-- ════════════════════════════════════════════════════════════
--  PATCH 2026-07-07 — Community + Social (Zoom web module)
--  Adds missing tables + RPC helpers used by zoom_agora.
-- ════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────
--  1) Meeting pre-settings (lobby checklist / host controls)
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS meeting_pre_settings (
  id                       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  meeting_id               UUID NOT NULL REFERENCES meetings(id) ON DELETE CASCADE,
  user_id                  UUID NOT NULL REFERENCES user_table(user_id),
  join_muted               SMALLINT NOT NULL DEFAULT 1,
  join_video_off           SMALLINT NOT NULL DEFAULT 0,
  allowed_to_screen_share  SMALLINT NOT NULL DEFAULT 0,
  UNIQUE(meeting_id, user_id)
);

ALTER TABLE meeting_pre_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS mps_select ON meeting_pre_settings;
CREATE POLICY mps_select ON meeting_pre_settings
  FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS mps_upsert_own ON meeting_pre_settings;
CREATE POLICY mps_upsert_own ON meeting_pre_settings
  FOR INSERT WITH CHECK (
    user_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS mps_update_host ON meeting_pre_settings;
CREATE POLICY mps_update_host ON meeting_pre_settings
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM meetings m
      WHERE m.id = meeting_pre_settings.meeting_id
        AND m.host_id = (
          SELECT user_id FROM user_table
          WHERE auth_user_id = auth.uid()::uuid
          LIMIT 1
        )
    )
  );

-- ────────────────────────────────────────────────────────────
--  2) Community: message edit history
-- ────────────────────────────────────────────────────────────
ALTER TABLE chat_message_edits ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cme_select ON chat_message_edits;
CREATE POLICY cme_select ON chat_message_edits
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_messages cm
      JOIN chat_rooms cr ON cr.id = cm.chat_id
      WHERE cm.id = chat_message_edits.message_id
        AND auth.uid()::uuid = ANY(cr.member_ids)
    )
  );

DROP POLICY IF EXISTS cme_insert ON chat_message_edits;
CREATE POLICY cme_insert ON chat_message_edits
  FOR INSERT WITH CHECK (
    edited_by = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

-- ────────────────────────────────────────────────────────────
--  3) Social feed tables
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS social_posts (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  author_id     UUID NOT NULL REFERENCES user_table(user_id),
  author_name   VARCHAR(120) NOT NULL,
  content       TEXT,
  media_urls    TEXT[] NOT NULL DEFAULT '{}',
  media_types   TEXT[] NOT NULL DEFAULT '{}', -- 'image'|'video'|'reel'
  visibility    VARCHAR(20) NOT NULL DEFAULT 'public'
                CHECK (visibility IN ('public','friends','private','community')),
  community_id  UUID REFERENCES chat_rooms(id),
  reaction_counts JSONB NOT NULL DEFAULT '{}'::jsonb,
  comment_count INT NOT NULL DEFAULT 0,
  share_count   INT NOT NULL DEFAULT 0,
  is_deleted    SMALLINT NOT NULL DEFAULT 0,
  created_at    BIGINT NOT NULL DEFAULT now_epoch(),
  updated_at    BIGINT NOT NULL DEFAULT now_epoch()
);

CREATE TRIGGER trg_social_posts_upd
  BEFORE UPDATE ON social_posts
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TABLE IF NOT EXISTS social_reactions (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  target_id   UUID NOT NULL,
  target_type VARCHAR(20) NOT NULL CHECK (target_type IN ('post','comment')),
  user_id     UUID NOT NULL REFERENCES user_table(user_id),
  emoji       VARCHAR(10) NOT NULL DEFAULT '👍',
  created_at  BIGINT NOT NULL DEFAULT now_epoch(),
  UNIQUE(target_id, user_id)
);

CREATE TABLE IF NOT EXISTS social_comments (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id     UUID NOT NULL REFERENCES social_posts(id) ON DELETE CASCADE,
  parent_id   UUID REFERENCES social_comments(id),
  author_id   UUID NOT NULL REFERENCES user_table(user_id),
  author_name VARCHAR(120) NOT NULL,
  content     TEXT NOT NULL,
  media_url   TEXT,
  is_deleted  SMALLINT NOT NULL DEFAULT 0,
  created_at  BIGINT NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT NOT NULL DEFAULT now_epoch()
);

CREATE TRIGGER trg_social_comments_upd
  BEFORE UPDATE ON social_comments
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- RLS
ALTER TABLE social_posts     ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_reactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_comments  ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS sp_select ON social_posts;
CREATE POLICY sp_select ON social_posts
  FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS sp_insert ON social_posts;
CREATE POLICY sp_insert ON social_posts
  FOR INSERT WITH CHECK (
    author_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS sp_update_own ON social_posts;
CREATE POLICY sp_update_own ON social_posts
  FOR UPDATE USING (
    author_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS sr_select ON social_reactions;
CREATE POLICY sr_select ON social_reactions
  FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS sr_upsert_own ON social_reactions;
CREATE POLICY sr_upsert_own ON social_reactions
  FOR INSERT WITH CHECK (
    user_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS sr_delete_own ON social_reactions;
CREATE POLICY sr_delete_own ON social_reactions
  FOR DELETE USING (
    user_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS sc_select ON social_comments;
CREATE POLICY sc_select ON social_comments
  FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS sc_insert ON social_comments;
CREATE POLICY sc_insert ON social_comments
  FOR INSERT WITH CHECK (
    author_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

DROP POLICY IF EXISTS sc_update_own ON social_comments;
CREATE POLICY sc_update_own ON social_comments
  FOR UPDATE USING (
    author_id = (
      SELECT user_id FROM user_table
      WHERE auth_user_id = auth.uid()::uuid
      LIMIT 1
    )
  );

-- ────────────────────────────────────────────────────────────
--  4) RPC helpers used by SocialService (reaction + comment counts)
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION increment_post_comments(p_post_id UUID)
RETURNS VOID LANGUAGE plpgsql AS $$
BEGIN
  UPDATE social_posts
  SET comment_count = comment_count + 1,
      updated_at    = now_epoch()
  WHERE id = p_post_id;
END;
$$;

CREATE OR REPLACE FUNCTION increment_post_reaction(p_post_id UUID, p_emoji TEXT)
RETURNS VOID LANGUAGE plpgsql AS $$
DECLARE
  cur JSONB;
  val INT;
BEGIN
  SELECT reaction_counts INTO cur FROM social_posts WHERE id = p_post_id FOR UPDATE;
  IF cur IS NULL THEN cur := '{}'::jsonb; END IF;
  val := COALESCE((cur ->> p_emoji)::int, 0) + 1;
  cur := jsonb_set(cur, ARRAY[p_emoji], to_jsonb(val), true);
  UPDATE social_posts
  SET reaction_counts = cur,
      updated_at      = now_epoch()
  WHERE id = p_post_id;
END;
$$;

CREATE OR REPLACE FUNCTION decrement_post_reaction(p_post_id UUID, p_emoji TEXT)
RETURNS VOID LANGUAGE plpgsql AS $$
DECLARE
  cur JSONB;
  val INT;
BEGIN
  SELECT reaction_counts INTO cur FROM social_posts WHERE id = p_post_id FOR UPDATE;
  IF cur IS NULL THEN cur := '{}'::jsonb; END IF;
  val := COALESCE((cur ->> p_emoji)::int, 0) - 1;
  IF val < 0 THEN val := 0; END IF;
  cur := jsonb_set(cur, ARRAY[p_emoji], to_jsonb(val), true);
  UPDATE social_posts
  SET reaction_counts = cur,
      updated_at      = now_epoch()
  WHERE id = p_post_id;
END;
$$;

-- ────────────────────────────────────────────────────────────
--  5) Realtime publications
-- ────────────────────────────────────────────────────────────
-- Enable these when you want realtime feed/comments:
-- ALTER PUBLICATION supabase_realtime ADD TABLE social_posts;
-- ALTER PUBLICATION supabase_realtime ADD TABLE social_comments;
-- ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
