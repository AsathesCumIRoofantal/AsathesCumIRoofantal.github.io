# AIR Meet - Complete Integration Guide

## Overview

This guide covers the complete setup for the Zoom-like video conferencing application with:
- **WebRTC-based video calls** (no Agora/LiveKit dependency)
- **AnyDesk-style screen sharing** with remote control
- **WhatsApp-style community chat** (groups, DMs, file sharing)
- **Facebook-style social feed** (posts, comments, reactions)
- **Cloudflare R2 integration** for file storage
- **Supabase backend** for database and realtime

## Technology Stack (Free Forever)

| Component | Technology | Cost |
|-----------|-----------|------|
| Video/WebRTC | flutter_webrtc (P2P mesh) | Free |
| Signaling | Supabase Realtime (Broadcast) | Free tier |
| Database | Supabase PostgreSQL | Free tier |
| File Storage | Cloudflare R2 | Free tier (10GB/month) |
| Auth | Supabase Auth | Free tier |

## Prerequisites

1. **Supabase Project** - Create at https://supabase.com
2. **Cloudflare R2 Bucket** - Create at https://dash.cloudflare.com
3. **Flutter SDK** - 3.8.0 or higher
4. **Node.js** - For Edge Functions deployment

---

## Step 1: Database Setup

### 1.1 Run the Schema

1. Open your Supabase project dashboard
2. Go to **SQL Editor**
3. Copy the entire contents of `supabase_schema.sql`
4. Paste and run it

This creates:
- User tables with auth integration
- Chat rooms and messages
- Social feed (posts, comments, reactions)
- Meeting management
- Remote device tracking
- RLS policies for security
- RPC functions for reaction counts
- Realtime publications

### 1.2 Enable Realtime

1. Go to **Database** → **Replication**
2. Ensure these tables are added to `supabase_realtime`:
   - `social_posts`
   - `social_comments`
   - `chat_messages`
   - `meeting_participants`
   - `meetings`

---

## Step 2: Cloudflare R2 Setup

### 2.1 Create R2 Bucket

1. Go to Cloudflare Dashboard → **R2** → **Create Bucket**
2. Name it (e.g., `air-meet-files`)
3. Note the bucket name

### 2.2 Get API Credentials

1. Go to **R2** → **Manage R2 API Tokens**
2. Create a new token with permissions:
   - **Object Read & Write**
3. Save:
   - `Access Key ID`
   - `Secret Access Key`
   - `Account ID` (from dashboard URL)

### 2.3 Configure Public Access (Optional)

If you want files to be publicly accessible:

1. Go to **R2** → **Your Bucket** → **Settings** → **Public Access**
2. Enable public access
3. Note the public URL (e.g., `https://pub-xxxxx.r2.dev`)

---

## Step 3: Supabase Edge Functions

### 3.1 Install Supabase CLI

```bash
npm install -g supabase
```

### 3.2 Link to Your Project

```bash
supabase login
supabase link --project-ref YOUR_PROJECT_REF
```

### 3.3 Deploy Edge Function

The `recording_manager` function is already implemented in:
```
supabase/functions/recording_manager/index.ts
```

Deploy it:

```bash
supabase functions deploy recording_manager
```

### 3.4 Set Environment Variables

In Supabase Dashboard → **Edge Functions** → **recording_manager** → **Settings**:

```
CLOUDFLARE_ACCOUNT_ID=your_account_id
CLOUDFLARE_R2_ACCESS_KEY_ID=your_access_key
CLOUDFLARE_R2_SECRET_ACCESS_KEY=your_secret_key
R2_BUCKET_NAME=air-meet-files
R2_PUBLIC_BASE_URL=https://pub-xxxxx.r2.dev
```

---

## Step 4: Flutter Configuration

### 4.1 Update .env File

Create or update `.env` in your project root:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key
```

### 4.2 Initialize Supabase in main.dart

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  
  runApp(MyApp());
}
```

### 4.3 Dependencies Already Included

Your `pubspec.yaml` already has:
- `flutter_webrtc: ^1.4.1`
- `supabase_flutter: ^2.14.2`
- `emoji_picker_flutter: ^2.2.0`
- `file_picker: ^8.1.2`
- And all other required packages

Run:
```bash
flutter pub get
```

---

## Step 5: Platform Permissions

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION"/>
```

For screen sharing on Android, add the foreground service (see flutter_webrtc docs).

### iOS

Add to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is needed for video calls</string>
<key>NSMicrophoneUsageDescription</key>
<string>Microphone access is needed for calls</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Speech recognition is used to generate live captions</string>
```

For screen sharing on iOS, add a Broadcast Upload Extension (see flutter_webrtc docs).

### Web

No extra permissions needed, but must be served over HTTPS.

---

## Step 6: TURN Server (Optional but Recommended)

For better NAT traversal behind corporate firewalls:

### 6.1 Self-Host coturn (Free)

Create `docker-compose.yml`:

```yaml
services:
  coturn:
    image: coturn/coturn:latest
    network_mode: host
    command: >
      -n --log-file=stdout
      --listening-port=3478
      --realm=yourdomain.com
      --user=meetuser:CHANGE_ME_STRONG_SECRET
      --external-ip=YOUR_SERVER_PUBLIC_IP
```

Deploy on any free-tier VM (Oracle Cloud Free Tier, Fly.io, Render).

### 6.2 Configure in App

Update `RtcConfig.withTurn()` in your meeting initialization:

```dart
final config = RtcConfig.withTurn(
  channelId: meeting.channelName,
  uid: myUid,
  turnUrl: 'turn:yourdomain.com:3478',
  turnUsername: 'meetuser',
  turnCredential: 'CHANGE_ME_STRONG_SECRET',
);
```

---

## Step 7: Running the App

### 7.1 Development

```bash
# Web
flutter run -d chrome

# Android
flutter run

# iOS
flutter run
```

### 7.2 Production Build

```bash
# Web
flutter build web

# Android
flutter build apk

# iOS
flutter build ios
```

---

## Feature Overview

### Video Meetings (WebRTC)

- **P2P Mesh Topology**: No media server cost
- **Screen Sharing**: AnyDesk-style with remote control
- **Remote Control**: Permission-gated click/drag forwarding
- **Max Participants**: 6-8 video (mesh limitation)
- **Signaling**: Supabase Realtime Broadcast

### Community Chat (WhatsApp-style)

- **Room Types**: Individual DM, Group, Broadcast
- **Features**:
  - Text messages with emoji picker
  - File sharing (via R2)
  - Message editing with history
  - Reply threading
  - Read receipts
  - Realtime sync

### Social Feed (Facebook-style)

- **Posts**: Text, images, videos
- **Reactions**: 6 emoji reactions with counts
- **Comments**: Nested replies
- **Visibility**: Public, Friends, Private, Community
- **Realtime**: Live feed updates

### File Storage (Cloudflare R2)

- **Chat Attachments**: Files uploaded via Edge Function
- **Post Media**: Images/videos for social feed
- **Automatic Cleanup**: Cron job deletes expired files

---

## Architecture Diagram

```
┌─────────────────┐
│   Flutter App   │
│  (WebRTC + UI)  │
└────────┬────────┘
         │
         ├──────────────────┐
         │                  │
         ▼                  ▼
┌─────────────────┐  ┌─────────────────┐
│  Supabase       │  │  Cloudflare R2  │
│  - Database     │  │  - File Storage │
│  - Realtime     │  │  - Edge Function│
│  - Auth         │  │                 │
└─────────────────┘  └─────────────────┘
```

---

## Troubleshooting

### WebRTC Connection Issues

1. **Check STUN/TURN**: Ensure ICE servers are configured
2. **Network**: Test on different networks (home vs office)
3. **Permissions**: Verify camera/mic permissions granted

### File Upload Fails

1. **Check Edge Function**: Verify `recording_manager` is deployed
2. **Environment Variables**: Ensure R2 credentials are set
3. **CORS**: Check Edge Function CORS headers

### Realtime Not Working

1. **Enable Publications**: Verify tables added to `supabase_realtime`
2. **RLS Policies**: Check policies allow read/write
3. **Connection**: Ensure Supabase client initialized

---

## Scaling Considerations

### Current Limitations

- **Video Participants**: 6-8 (mesh topology)
- **File Upload Size**: Limited by Edge Function timeout
- **TURN Server**: Single point (can add multiple)

### Future Upgrades

- **SFU (Media Server)**: Self-host LiveKit for 100+ participants
- **Presigned URLs**: For large file uploads (>10MB)
- **CDN**: Cloudflare CDN for R2 content delivery

---

## Security Notes

1. **RLS Policies**: All tables have Row Level Security enabled
2. **Auth Integration**: Users linked via `auth_user_id`
3. **Edge Functions**: Service role key used server-side only
4. **TURN Credentials**: Use strong secrets in production

---

## Support & Resources

- **WebRTC Docs**: https://flutter-webrtc.org
- **Supabase Docs**: https://supabase.com/docs
- **Cloudflare R2**: https://developers.cloudflare.com/r2
- **coturn**: https://github.com/coturn/coturn

---

## License

This implementation uses free forever packages. No per-minute billing for video calls.
