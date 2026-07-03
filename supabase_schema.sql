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
  user_last_login_logs_id                UUID NOT NULL FOREIGN KEY (id) REFERENCES user_logging_data(user_last_login_logs_id),
  fcm_token                              TEXT,
  created_at                             BIGINT       NOT NULL DEFAULT now_epoch(),
  created_by                             UUID,
  updated_at                             BIGINT       NOT NULL DEFAULT now_epoch(),
  updated_by                             UUID
);

CREATE INDEX IF NOT EXISTS idx_user_table_mobile  ON user_table(mobile);
CREATE INDEX IF NOT EXISTS idx_user_table_role    ON user_table(user_role);
CREATE INDEX IF NOT EXISTS idx_user_table_active  ON user_table(is_active);

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
-- Edge Fuctions
import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  console.log("A--------------");
  
  try {
    // throw new Error("I AM HERE");
    // return new Response("NAVIN");

    console.log(req.method);
    const body = await req.json();
//      const raw = await req.text();

// console.log("RAW:", raw);

// let body = {};

// if (raw.trim().length > 0) {
//   body = JSON.parse(raw);
// }

// console.log(body);

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
      {
        global: {
          headers: {
            Authorization: req.headers.get("Authorization") ?? "",
          },
        },
      },
    );

    // // Validate logged in user
    if (body.isLogin == true) {
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return new Response(
        JSON.stringify({
          success: false,
          message: "Unauthorized",
        }),
        {
          status: 401,
          headers: { ...corsHeaders,
            "Content-Type": "application/json" },
        },
      );
    }
  }

   

    // Insert login log
    const { data: log, error: logError } = await supabase
      .from("user_logging_data")
      .insert({
        user_id: user.id,
        system_platform_logged: body.system_platform_logged,
        geo_location_logged: body.geo_location_logged,
        is_from_android: body.is_from_android,
        is_from_ios: body.is_from_ios,
        is_from_web: body.is_from_web,
        ip_address: body.ip_address,
        app_version: body.app_version,
        is_login: body.is_login,        
      })
      .select()
      .single();

    if (logError) throw logError;

    // Update user_table
    const { error: updateError } = await supabase
      .from("user_table")
      .update({
        user_last_login_logs_id: log.id,
        // last_login_at: new Date().toISOString(),
      })
      .eq("auth_user_id", user.id);

    if (updateError) throw updateError;

    // Return updated AirUser
    const { data: airUser, error: userError } = await supabase
      .from("user_table")
      .select("*")
      .eq("auth_user_id", user.id)
      .single();

    if (userError) throw userError;

    return new Response(
      JSON.stringify(airUser),
      {
        status: 200,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (e) {
    console.log("Here");
    console.log(e);
   
    return new Response(
      JSON.stringify({
        success: false,
        message: e instanceof Error ? e.message : "Unknown error",
      }),
      {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});
// next one