# AIR Meet — Master TODO
> **Last updated:** 2026-07-06  |  **Scope:** zoom_agora module only  |  Touch only files inside `lib/web_modules/web_home/zoom_agora/`

---

## HOW TO READ THIS FILE

Each task has:
- **File** — exact path relative to `zoom_agora/`
- **Where** — class or method to add/change
- **What** — exactly what to do
- **Status** — `[ ]` not started · `[~]` partial · `[x]` done

Tasks are grouped by feature area, ordered so each group is independently shippable.
Do them top-to-bottom within a group to avoid merge pain.

---

## ═══════════════════════════════════════════════════
## SECTION 1 — FIX BEFORE TESTING (blockers)
## ═══════════════════════════════════════════════════

### 1-A  Waiting room auto-advances when host admits
- [ ] **File:** `pre_meeting/waiting_room_view.dart`
- **Where:** `_S.initState()`
- **What:** Subscribe to `Supabase.instance.client.channel('meeting:<channelId>').onPostgresChanges(...)` filtering `meetings` table on `status = live`. On event navigate to `ZoomRoutes.inMeeting` with same args. Read `channelId` from `Get.arguments`.

### 1-B  Upcoming list loads real data
- [ ] **File:** `pre_meeting/home_view.dart`
- **Where:** `_UpcomingList` — replace static `_items` list
- **What:** Call `MeetingService().recentFor(CurrentUser.id)` in `initState`, store in a `RxList`, rebuild with `Obx`. Show date from `meeting.scheduledAt`.

### 1-C  Recent recordings loads real data
- [ ] **File:** `pre_meeting/home_view.dart`
- **Where:** `_RecentRecordings` — replace static `_items`
- **What:** Query `meetings` where `recording_url IS NOT NULL` ordered by `ended_at DESC LIMIT 5`. Show `video_player` thumbnail + title + duration.

### 1-D  Top chrome shows real meeting title
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_TopChrome.build()` — hardcoded `'Product weekly sync'`
- **What:** Read from `controller.meetingTitle` (add `final meetingTitle = ''.obs` to controller, set in `connectToLiveMeeting` from route args `'title'`).

### 1-E  Record button triggers real recording
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Toolbar.build()` — record `onTap` dialog
- **What:** Replace dialog with `controller.startCloudRecording()`. Show pulsing red dot in `_TopChrome` while `controller.recording.isRecording`. Show snackbar with R2 URL on stop. Requires `recording_manager` Edge Function deployed (see Section 9).

### 1-F  Settings switches cascade to video pipeline
- [ ] **File:** `settings/settings_view.dart`
- **Where:** each `SwitchListTile.onChanged`
- **What:**
  - `hdVideo` → call `(Get.find<RtcBackendManager>().engine as WebRtcService?)?.setVideoConstraints({'width': v ? 1920 : 1280, 'height': v ? 1080 : 720})`
  - `mirror` → add `mirrorVideo` reactive to controller; `_Tile` reads it and wraps local view in `Transform(transform: Matrix4.rotationY(pi))`
  - `noiseSuppression` → `wrtc.Helper.setAndroidAudioConfiguration(enableNoiseSuppression: v != 'off')`


---

## ═══════════════════════════════════════════════════
## SECTION 2 — WHITEBOARD: TEXT EDITOR LAYER
## ═══════════════════════════════════════════════════

> All changes inside `in_meeting/whiteboard_view.dart` + one new model file + controller additions.

### 2-A  New model: WhiteboardText
- [ ] **File:** `models/whiteboard_text.dart` ← **create new file**
- **What:** 
```dart
class WhiteboardText {
  final String id;
  final int uid;
  final String text;
  final double x, y;       // normalised 0-1
  final double fontSize;
  final int colorValue;
  final bool bold, italic;
  WhiteboardText({required this.id, required this.uid, required this.text,
    required this.x, required this.y, this.fontSize = 18,
    this.colorValue = 0xFF000000, this.bold = false, this.italic = false});
  Map<String, dynamic> toJson() => {'id':id,'uid':uid,'text':text,'x':x,'y':y,
    'fs':fontSize,'c':colorValue,'b':bold?1:0,'i':italic?1:0};
  factory WhiteboardText.fromJson(Map<String,dynamic> j) => WhiteboardText(
    id:j['id'],uid:j['uid'],text:j['text'],x:(j['x'] as num).toDouble(),
    y:(j['y'] as num).toDouble(),fontSize:(j['fs'] as num?)?.toDouble()??18,
    colorValue:j['c'] as int? ?? 0xFF000000,bold:j['b']==1,italic:j['i']==1);
}
```

### 2-B  Controller: add text annotation state + methods
- [ ] **File:** `in_meeting/zoom_meeting_controller.dart`
- **Where:** after `whiteboardStrokes` declarations
- **What:** Add:
```dart
final whiteboardTexts = <WhiteboardText>[].obs;

void addWhiteboardText(WhiteboardText t, {bool broadcast = true}) {
  whiteboardTexts.add(t);
  if (broadcast) _sendApp('wb_text', t.toJson());
}
void deleteWhiteboardText(String id, {bool broadcast = true}) {
  whiteboardTexts.removeWhere((t) => t.id == id);
  if (broadcast) _sendApp('wb_text_delete', {'id': id});
}
```
- **Where:** `_handleAppEnvelope` switch — add two cases:
```dart
case 'wb_text':
  whiteboardTexts.add(WhiteboardText.fromJson(payload));
  break;
case 'wb_text_delete':
  whiteboardTexts.removeWhere((t) => t.id == payload['id']);
  whiteboardTexts.refresh();
  break;
```

### 2-C  WhiteboardView: add Text tool button + active tool state
- [ ] **File:** `in_meeting/whiteboard_view.dart`
- **Where:** `_WhiteboardViewState` — add `bool textToolActive = false;`
- **Where:** `_toolbar()` — add after eraser button:
```dart
IconButton(
  tooltip: 'Add text',
  icon: Icon(Icons.text_fields, color: textToolActive ? ZoomTheme.primary : Colors.white70),
  onPressed: () => setState(() { textToolActive = !textToolActive; eraser = false; }),
),
```

### 2-D  WhiteboardView: tap to open text popup when text tool active
- [ ] **File:** `in_meeting/whiteboard_view.dart`
- **Where:** `GestureDetector` wrapping the canvas — add `onTapUp` handler:
```dart
onTapUp: (d) {
  if (!textToolActive) return;
  final nx = d.localPosition.dx / size.width;
  final ny = d.localPosition.dy / size.height;
  _showTextPopup(nx, ny);
},
```
- Add `_showTextPopup(double nx, double ny)` method that shows a dialog:
  - `TextField` (multiline, min 2 lines, autofocus)
  - Font size `Slider` 10–48
  - Bold / Italic `ToggleButtons`
  - Color row (same 6-color palette as stroke)
  - Confirm button → calls `controller.addWhiteboardText(WhiteboardText(id: ..., uid: controller.localUid, text: textCtrl.text, x: nx, y: ny, fontSize: size, colorValue: color.value, bold: bold, italic: italic))`

### 2-E  WhiteboardPainter: render text annotations
- [ ] **File:** `in_meeting/whiteboard_view.dart`
- **Where:** `_WhiteboardPainter` — add `List<WhiteboardText> texts` field
- **Where:** `paint()` — after drawing strokes, iterate `texts`:
```dart
for (final t in texts) {
  final style = ui.ParagraphStyle(
    fontSize: t.fontSize,
    fontWeight: t.bold ? FontWeight.bold : FontWeight.normal,
    fontStyle: t.italic ? FontStyle.italic : FontStyle.normal,
  );
  final builder = ui.ParagraphBuilder(style)
    ..pushStyle(ui.TextStyle(color: Color(t.colorValue)))
    ..addText(t.text);
  final para = builder.build()..layout(ui.ParagraphConstraints(width: size.width * 0.4));
  canvas.drawParagraph(para, Offset(t.x * size.width, t.y * size.height));
}
```
- **Where:** `Obx` in `build()` — pass `texts: controller.whiteboardTexts.toList()` to painter.

### 2-F  Host: delete any text annotation
- [ ] **File:** `in_meeting/whiteboard_view.dart`
- **Where:** inside canvas `GestureDetector.onLongPressStart` — find nearest text by distance, show popup with Delete option. Only show delete-others for host (`controller.participants[controller.localUid]?.role == ParticipantRole.host`).

### 2-G  Whiteboard lock: host only
- [ ] **File:** `in_meeting/zoom_meeting_controller.dart`
- **Where:** after `allowAttendeeVideo` declarations
- **What:** Add `final whiteboardLocked = false.obs;`
- Add method: `void toggleWhiteboardLock() { whiteboardLocked.toggle(); _sendApp('wb_lock', {'locked': whiteboardLocked.value}); }`
- In `_handleAppEnvelope`: add `case 'wb_lock': whiteboardLocked.value = payload['locked'] == true;`
- [ ] **File:** `in_meeting/whiteboard_view.dart`
- **Where:** `_WhiteboardViewState` — wrap all GestureDetector callbacks with `if (controller.whiteboardLocked.value && isNotHost) return;`
- **Where:** `_toolbar()` — add lock button visible only to host.


---

## ═══════════════════════════════════════════════════
## SECTION 3 — LOBBY / PRE-JOIN CHECKLIST
## ═══════════════════════════════════════════════════

### 3-A  Device preview: real camera/mic preview
- [ ] **File:** `pre_meeting/device_preview_view.dart`
- **Where:** `_S.initState()`
- **What:** Call `Get.find<RtcBackendManager>().engine.startPreview()` to show real `RTCVideoView` in the preview container instead of the gradient placeholder. Call `stopPreview()` in `dispose()`.

### 3-B  Network quality indicator
- [ ] **File:** `pre_meeting/device_preview_view.dart`
- **Where:** `_preview()` widget — add below the mic level bar
- **What:** Run a quick `RTCPeerConnection` ICE gather (create a peer, `setLocalDescription`, wait 2 s, close). Count candidates: 0 = Poor, 1 = Good (STUN), 2+ = Excellent. Show a `Row` with colored dot + label "Network: Excellent / Good / Poor" + tooltip "TURN relay will be used on poor networks".

### 3-C  Pre-join checklist widget
- [ ] **File:** `pre_meeting/device_preview_view.dart`
- **Where:** `_controls()` — add above the "Join now" button
- **What:** Add a `_ChecklistRow` widget list:
  - `[x]` Camera — turns green when `videoOn == true`
  - `[x]` Microphone — turns green when `micOn == true` AND `micLevel > 0.05` at any point
  - `[ ]` Speaker — turns green when test-speaker button pressed once
  - `[x]` Network — turns green after network check completes
  - `[ ]` Display name — turns green when name field is non-empty
- Gate "Join now" button to `enabled` only when all 5 are green, OR show a "Join anyway" text link below.

### 3-D  Host: invited users checklist before start
- [ ] **File:** `pre_meeting/device_preview_view.dart`
- **Where:** `_controls()` — show only when `Get.arguments['mode'] == 'instant'` AND user is host
- **What:** Fetch `meeting_pre_settings` from Supabase for this `meetingRowId`. Show a `ListView` of invited users, each with:
  - Name + avatar
  - `SwitchListTile` "Join muted" (default on)
  - `SwitchListTile` "Camera off" (default off)
  - `SwitchListTile` "Can share screen" (default off)
- Save changes via `MeetingService().setPreSettings(...)` (add this method).

### 3-E  Add MeetingService.setPreSettings()
- [ ] **File:** `services/meeting_service.dart`
- **Where:** bottom of `MeetingService` class
- **What:**
```dart
Future<void> setPreSettings({
  required String meetingId,
  required String userId,
  bool joinMuted = true,
  bool joinVideoOff = false,
  bool canShareScreen = false,
}) => _client.from('meeting_pre_settings').upsert({
  'meeting_id': meetingId,
  'user_id': userId,
  'join_muted': joinMuted ? 1 : 0,
  'join_video_off': joinVideoOff ? 1 : 0,
  'allowed_to_screen_share': canShareScreen ? 1 : 0,
}, onConflict: 'meeting_id,user_id');

Future<Map<String,dynamic>?> getPreSettings({
  required String meetingId, required String userId,
}) => _client.from('meeting_pre_settings').select()
    .eq('meeting_id', meetingId).eq('user_id', userId).maybeSingle();
```

### 3-F  Apply pre-settings on join
- [ ] **File:** `in_meeting/zoom_meeting_binding.dart`
- **Where:** inside the `else` block (live join path), before `connectToLiveMeeting`
- **What:** If `meetingRowId != null && CurrentUser.isSignedIn`, call `MeetingService().getPreSettings(...)`. Use result to override `joinMuted` and `joinVideoOff` args.


---

## ═══════════════════════════════════════════════════
## SECTION 4 — HOST CONTROLS (complete suite)
## ═══════════════════════════════════════════════════

### 4-A  Controller: add missing host methods
- [ ] **File:** `in_meeting/zoom_meeting_controller.dart`
- **Where:** after `makeCoHost()` 
- **What:** Add:
```dart
Future<void> forceVideoOff(int uid) async {
  participants[uid]?.videoOff = true;
  participants.refresh();
  if (uid != localUid) await _sendAppTo(uid, 'force_video', {'off': true});
}
Future<void> renameParticipant(int uid, String newName) async {
  participants[uid]?.name = newName;
  participants.refresh();
  await _sendAppTo(uid, 'rename', {'name': newName});
}
Future<void> lowerAllHands() async {
  for (final p in participants.values) { p.handRaised = false; }
  participants.refresh();
  await _sendApp('lower_all_hands', {});
}
```
- **Where:** `_handleAppEnvelope` — add cases:
```dart
case 'force_video':
  if (payload['off'] == true) toggleLocalVideo();
  break;
case 'rename':
  localName = payload['name'] as String;
  _broadcastName();
  break;
case 'lower_all_hands':
  participants[localUid]?.handRaised = false;
  participants.refresh();
  break;
```

### 4-B  Participants panel: add missing menu items
- [ ] **File:** `in_meeting/participants_panel.dart`
- **Where:** `_Row` — `PopupMenuButton.itemBuilder` list
- **What:** Add these `PopupMenuItem` entries:
  - `'force_mute'` → `controller.muteAll()` for that specific uid (call `engine.muteRemoteAudio(uid, true)`)
  - `'force_video_off'` → `controller.forceVideoOff(uid)`
  - `'rename'` → show `TextField` dialog, call `controller.renameParticipant(uid, newName)`
  - `'spotlight'` → `controller.toggleSpotlight(uid)` (already exists, not in menu)
- Add "Lower all hands" button in the panel footer next to "Mute all".

### 4-C  Per-user chat and screen-share guards
- [ ] **File:** `in_meeting/zoom_meeting_controller.dart`
- **Where:** `sendChatMessage()` — add at top: `if (!allowChat.value) return;`
- **Where:** `toggleScreenShare()` — add check: `if (!allowAttendeeVideo.value && participants[localUid]?.role == ParticipantRole.attendee) return;`


---

## ═══════════════════════════════════════════════════
## SECTION 5 — VIDEO GRID UPGRADES
## ═══════════════════════════════════════════════════

### 5-A  Gallery view (equal-size grid)
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_VideoStage.build()` — replace with a two-mode layout
- **What:** Add `final viewMode = 'speaker'.obs` to controller. Add toggle button in `_TopChrome`. When `viewMode == 'gallery'`, use `GridView.builder` with `crossAxisCount` based on participant count:
  - 1 person → 1 column full screen
  - 2 → 2 columns
  - 3-4 → 2x2
  - 5-6 → 2x3
  - 7-9 → 3x3
  - 10+ → `flutter_staggered_grid_view` `MasonryGridView`

### 5-B  Self-view toggle
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Tile.build()` — wrap with `Obx`
- **What:** `if (p.uid == controller.localUid && controller.selfHidden.value) return const SizedBox.shrink();`
- **Where:** `_Toolbar` — add `_btn(Icons.person_off_outlined, 'Hide self')` that toggles `controller.selfHidden`.

### 5-C  Active speaker glow animation
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Tile` — the `isSpeaking` `boxShadow` is static
- **What:** Replace with a `TweenAnimationBuilder<double>` that pulses the shadow `blurRadius` from 8 to 24 and back when `isSpeaking`. Use `duration: Duration(milliseconds: 600)`.

### 5-D  Video reel / recordings playback in home
- [ ] **File:** `pre_meeting/home_view.dart`
- **Where:** `_RecentRecordings` — `onPressed` the play icon button (currently does nothing)
- **What:** Navigate to a new `ZoomRoutes.player` route passing `r2Url`. Create new file `pre_meeting/recording_player_view.dart` with `video_player` package. Responsive: on desktop shows side-by-side thumbnail grid + inline player; on mobile shows full-screen `VideoPlayer` widget. Add `ZoomRoutes.player = '/zoom/player'` to `zoom_routes.dart`.

### 5-E  Reels / short video clips (Facebook/Instagram-style)
- [ ] **File:** `pre_meeting/home_view.dart`
- **Where:** after `_RecentRecordings` widget in scroll column
- **What:** Add `_ReelsFeed` widget — a horizontal `PageView` of short meeting clips (`recording_url` rows where `ended_at - started_at < 120` seconds). Each reel card:
  - Full-bleed `video_player` autoplay (muted by default)
  - Tap to unmute, double-tap to like
  - Overlay: participant names, meeting title, reactions bar
  - `PageView.builder` with `controller.addListener` to pause off-screen videos
- Uses `carousel_slider` package (already in project).


---

## ═══════════════════════════════════════════════════
## SECTION 6 — WHATSAPP-STYLE COMMUNITY + GROUP CHAT
## ═══════════════════════════════════════════════════

> All community/group chat lives in a **new folder** `zoom_agora/community/` so it doesn't touch in-meeting code. Uses the existing `chat_rooms` + `chat_messages` Supabase tables from the schema.

### 6-A  New routes
- [ ] **File:** `zoom_routes.dart`
- **Where:** `ZoomRoutes` abstract class + `pages` list
- **What:** Add:
```dart
static const community     = '/zoom/community';
static const communityRoom = '/zoom/community/room';
static const communityNew  = '/zoom/community/new';
```
Add `GetPage` entries for each.

### 6-B  New: CommunityHomeView
- [ ] **File:** `community/community_home_view.dart` ← **create**
- **What:** Two-column layout (desktop) / bottom-nav (mobile).
  - Left column: vertical list of community tiles (name, last message preview, unread badge, avatar). Source: `chat_rooms` where current user is in `member_ids`, ordered by `last_message_at DESC`.
  - Right column: `CommunityRoomView` when a room is selected, else an empty-state illustration.
  - FAB `+` opens `CommunityNewView`.
  - Each tile swipe-right → Archive. Long-press → Mute / Pin / Delete.
  - Use `AnimationConfiguration.staggeredList` from `flutter_staggered_animations` for tile entrance.

### 6-C  New: CommunityRoomView (WhatsApp-like chat thread)
- [ ] **File:** `community/community_room_view.dart` ← **create**
- **What:** Full WhatsApp chat thread. Sections:
  - **Header:** room name, member count, video-call button (→ `_startInstantMeeting` with room members pre-invited), info icon (→ room info sheet).
  - **Message list:** `ListView.builder` + `scrollable_positioned_list`. Group by date. Bubble style matching existing `ChatPanel._Bubble` but richer:
    - Text, image (tap to full-screen hero), video (inline `video_player`), file (icon + filename + download), location pin, voice note (waveform + play button)
    - Swipe right → reply (sets `replyToId`). Long-press → react / copy / forward / delete / star.
    - Delivered / Read receipts — two blue ticks.
    - Starred messages section (filter `chat_messages` where `is_starred = 1`).
  - **Composer:**
    - Attach button → bottom sheet with: Camera, Gallery, Document, Location, Contact.
    - Voice note button — hold to record, slide left to cancel (using `record` package).
    - Emoji picker (using `emoji_picker_flutter`).
    - `@mention` autocomplete triggered by `@` keystroke.

### 6-D  New: CommunityNewView
- [ ] **File:** `community/community_new_view.dart` ← **create**
- **What:** 
  - Toggle: Individual DM / Group / Community (broadcast).
  - Contact search field querying `user_table` by name or mobile.
  - Selected members chip row with remove.
  - Group name + avatar upload (Cloudflare R2 via `temp_files`).
  - Create → inserts `chat_rooms` row + adds all `member_ids`.

### 6-E  New: CommunityService
- [ ] **File:** `community/community_service.dart` ← **create**
- **What:**
```dart
class CommunityService {
  final _db = Supabase.instance.client;

  Future<List<Map<String,dynamic>>> listRooms(String userId) async { ... }
  Future<Map<String,dynamic>> createRoom({required String name, required String type, required List<String> memberIds}) async { ... }
  Future<List<Map<String,dynamic>>> loadMessages(String roomId, {int limit = 40, String? before}) async { ... }
  Future<void> sendMessage({required String roomId, required String senderId, required String senderName, required String type, String? text, String? mediaUrl, String? mediaName, int? mediaSize, String? replyToId}) async { ... }
  Future<void> markSeen(String roomId, String userId) async { ... }
  Stream<Map<String,dynamic>> subscribeRoom(String roomId) { ... } // Supabase Realtime
  Future<void> deleteMessage(String messageId) async { ... }
}
```

### 6-F  Document sharing: file picker + R2 upload
- [ ] **File:** `community/community_room_view.dart`
- **Where:** attach button → Document option
- **What:** Use `file_picker` package. On file selected:
  1. Insert a row in `temp_files` with `expires_at = now + 30 days`.
  2. Call `recording_manager` Edge Function with `action: 'upload_file'`, stream bytes.
  3. Edge Function uploads to R2 at `files/<roomId>/<uuid>/<filename>`, returns `{ url, r2Key }`.
  4. Send message with `type: 'file'`, `media_url`, `media_name`, `media_size`.
- Receiver sees file icon + name + "Download" button (opens URL in browser / downloads on mobile).

### 6-G  Revert to old message (WhatsApp message history)
- [ ] **File:** `community/community_room_view.dart`
- **Where:** message long-press menu → "Message info"
- **What:** Show a bottom sheet listing the edit history. Requires new Supabase table:
  ```sql
  -- Add to supabase_schema.sql at bottom with date comment:
  CREATE TABLE IF NOT EXISTS chat_message_edits (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    message_id UUID NOT NULL REFERENCES chat_messages(id) ON DELETE CASCADE,
    old_content TEXT NOT NULL,
    edited_at  BIGINT NOT NULL DEFAULT now_epoch(),
    edited_by  UUID  NOT NULL
  );
  ```
  When a message is edited: insert old content into `chat_message_edits`, update `chat_messages.content` + set `is_edited = 1`. Show "(edited)" label on bubble. Long-press → "View history" opens the edits sheet.


---

## ═══════════════════════════════════════════════════
## SECTION 7 — FACEBOOK-STYLE POSTS, COMMENTS & FEED
## ═══════════════════════════════════════════════════

> Lives in `zoom_agora/social/` folder. Backed by new Supabase tables. Independent of in-meeting code.

### 7-A  New Supabase tables (append to supabase_schema.sql)
- [ ] **File:** `supabase_schema.sql` — append at end with comment `-- 2026-07-06 social feed`
- **What:**
```sql
CREATE TABLE IF NOT EXISTS social_posts (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  author_id    UUID NOT NULL REFERENCES user_table(user_id),
  author_name  VARCHAR(120) NOT NULL,
  content      TEXT,
  media_urls   TEXT[]  NOT NULL DEFAULT '{}',
  media_types  TEXT[]  NOT NULL DEFAULT '{}', -- 'image'|'video'|'reel'
  visibility   VARCHAR(20) NOT NULL DEFAULT 'public'
               CHECK (visibility IN ('public','friends','private','community')),
  community_id UUID REFERENCES chat_rooms(id), -- null = public feed
  reaction_counts JSONB NOT NULL DEFAULT '{}', -- {"like":5,"love":2}
  comment_count INT  NOT NULL DEFAULT 0,
  share_count   INT  NOT NULL DEFAULT 0,
  is_deleted   SMALLINT NOT NULL DEFAULT 0,
  created_at   BIGINT   NOT NULL DEFAULT now_epoch(),
  updated_at   BIGINT   NOT NULL DEFAULT now_epoch()
);
CREATE TABLE IF NOT EXISTS social_reactions (
  id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  target_id  UUID NOT NULL,  -- post_id or comment_id
  target_type VARCHAR(20) NOT NULL CHECK (target_type IN ('post','comment')),
  user_id    UUID NOT NULL REFERENCES user_table(user_id),
  emoji      VARCHAR(10) NOT NULL DEFAULT 'like',
  created_at BIGINT NOT NULL DEFAULT now_epoch(),
  UNIQUE(target_id, user_id)
);
CREATE TABLE IF NOT EXISTS social_comments (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id     UUID NOT NULL REFERENCES social_posts(id) ON DELETE CASCADE,
  parent_id   UUID REFERENCES social_comments(id), -- null = top-level
  author_id   UUID NOT NULL REFERENCES user_table(user_id),
  author_name VARCHAR(120) NOT NULL,
  content     TEXT NOT NULL,
  media_url   TEXT,
  is_deleted  SMALLINT NOT NULL DEFAULT 0,
  created_at  BIGINT   NOT NULL DEFAULT now_epoch(),
  updated_at  BIGINT   NOT NULL DEFAULT now_epoch()
);
```
Enable RLS on both, add policies matching `social_posts.author_id = auth.uid()` for write.

### 7-B  New routes
- [ ] **File:** `zoom_routes.dart`
- **What:**
```dart
static const feed        = '/zoom/feed';
static const postDetail  = '/zoom/feed/post';
static const postCreate  = '/zoom/feed/create';
```

### 7-C  New: FeedView (Facebook home feed)
- [ ] **File:** `social/feed_view.dart` ← **create**
- **What:** `CustomScrollView` with slivers:
  1. `SliverToBoxAdapter` — story/reel strip (horizontal `PageView` of short clips, see 5-E)
  2. `SliverToBoxAdapter` — "Create post" card with avatar + text field (navigates to `postCreate`)
  3. `SliverList` — `PostCard` widgets loaded from `social_posts`, paginated (load 10 at a time, load more on scroll near bottom)
  - Two-column masonry on desktop (≥ 1024 px), single column on mobile
  - Filter chips: All · Community · Videos · Photos
  - Realtime: subscribe `social_posts` channel, new posts slide in from top with `AnimatedList`

### 7-D  New: PostCard widget
- [ ] **File:** `social/post_card.dart` ← **create**
- **What:**
  - Header: avatar + name + time ago + visibility badge + `⋯` menu (edit / delete / report / copy link)
  - Content: text with `@mention` + `#hashtag` highlighted. "See more" after 3 lines.
  - Media: single image → full bleed. 2 images → side by side. 3+ → 2-column grid with `+N` overlay. Video → `video_player` with play button, auto-pause when off screen.
  - Reaction bar: `👍 Like  ❤️ Love  😂 Haha  😮 Wow  😢 Sad  😡 Angry` — long press to see all 6. Count shown. Tap to toggle.
  - Footer: `Comment   Share   Send` buttons matching Facebook layout.
  - Tap comment count → navigate to `postDetail` focused on comments.

### 7-E  New: PostDetailView
- [ ] **File:** `social/post_detail_view.dart` ← **create**
- **What:**
  - `SliverAppBar` with post content
  - `SliverList` of `CommentTile` widgets
  - Nested replies: `CommentTile` has a "Replies (N) ▾" expander showing child comments indented
  - Reply composer at bottom — sticky, includes emoji, @mention, image attach
  - Realtime: subscribe `social_comments` filtered by `post_id`

### 7-F  New: PostCreateView
- [ ] **File:** `social/post_create_view.dart` ← **create**
- **What:**
  - Avatar + expandable `TextField` "What's on your mind?"
  - Media tray: pick image/video from gallery (up to 10), reorder by drag, remove by X
  - Video trim: if video > 60 s, show a trim slider using `video_player` package seek
  - Audience picker: Public / Community (pick from list) / Private
  - Tag people: search `user_table`, adds `@name` to content
  - Location tag (optional, uses device GPS)
  - Post button → uploads media to R2 → inserts `social_posts` row

### 7-G  New: SocialService
- [ ] **File:** `social/social_service.dart` ← **create**
- **What:**
```dart
class SocialService {
  Future<List<Map<String,dynamic>>> loadFeed({int page = 0}) async { ... }
  Future<void> createPost({...}) async { ... }
  Future<void> reactToPost(String postId, String emoji) async { ... }
  Future<void> unreactToPost(String postId) async { ... }
  Future<List<Map<String,dynamic>>> loadComments(String postId) async { ... }
  Future<void> addComment({required String postId, String? parentId, required String content}) async { ... }
  Future<void> deletePost(String postId) async { ... }
  Stream<Map<String,dynamic>> subscribeFeed() { ... }
}
```


---

## ═══════════════════════════════════════════════════
## SECTION 8 — IN-MEETING CHAT ENRICHMENTS
## ═══════════════════════════════════════════════════

### 8-A  Emoji picker
- [ ] **File:** `in_meeting/chat_panel.dart`
- **Where:** `_Composer` — `Icons.emoji_emotions_outlined` `onPressed`
- **What:** Show `EmojiPicker` from `emoji_picker_flutter` in a `SizedBox(height: 250)` bottom sheet. On emoji selected append to `input.text`.

### 8-B  File / image attach
- [ ] **File:** `in_meeting/chat_panel.dart`
- **Where:** `_Composer` — `Icons.attach_file` `onPressed`
- **What:** Show bottom sheet with Camera / Gallery / Document options. On file picked: upload to R2 via `recording_manager` Edge Function (`action: 'upload_file'`). Send `ChatMessage` with `attachments: [url]`. `_Bubble` renders images with `CachedNetworkImage`, files with icon + download tap.

### 8-C  Message reply
- [ ] **File:** `in_meeting/chat_panel.dart`
- **Where:** `_Bubble` — add swipe gesture (`Dismissible` or `GestureDetector.onHorizontalDragEnd`)
- **What:** On swipe right, set a `Rxn<ChatMessage> replyTarget` in the panel state. Show a reply preview bar above the composer. `sendChatMessage()` includes `replyToId`. `_Bubble` shows the quoted message above its own text.

### 8-D  Search in chat
- [ ] **File:** `in_meeting/chat_panel.dart`
- **Where:** `_Header` — search `IconButton.onPressed`
- **What:** Toggle a search bar row. Filter `controller.chat` by `text.toLowerCase().contains(query)`. Highlight matching substring with `TextSpan`.

### 8-E  Unread badge — real count
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Toolbar._btn` for 'Chat'
- **What:** Add `final _lastReadIndex = 0.obs` to controller. Badge shows `controller.chat.length - _lastReadIndex.value`. When chat pane opens, `_lastReadIndex.value = controller.chat.length`.

### 8-F  Message reactions on bubbles
- [ ] **File:** `in_meeting/chat_panel.dart`
- **Where:** `_Bubble` — long press
- **What:** Show a `Row` of 6 emoji buttons in a `Overlay`. Tap → broadcast `_sendApp('chat_react', {'id': m.id, 'emoji': emoji, 'uid': localUid})`. `_Bubble` renders reaction counts below the bubble text. Controller handles `case 'chat_react'`: find message by id, add to `reactions` map.


---

## ═══════════════════════════════════════════════════
## SECTION 9 — EDGE FUNCTIONS TO DEPLOY
## ═══════════════════════════════════════════════════

> Each function = one folder under `supabase/functions/<name>/index.ts`. Deploy with `supabase functions deploy <name>`.

### 9-A  `agora_token_generator`
- [ ] **File:** `supabase/functions/agora_token_generator/index.ts` ← **create**
- **What:** Accepts `{ channel, uid, role }`. Uses `agora-token` npm package. Signs with `AGORA_APP_ID` + `AGORA_APP_CERTIFICATE` from env. Returns `{ token, expiresAt }`.

### 9-B  `recording_manager`
- [ ] **File:** `supabase/functions/recording_manager/index.ts` ← **create**
- **What:** Switch on `action`:
  - `start` → call R2 `CreateMultipartUpload`, return `{ uploadId, r2Key }`. Update `meetings.recording_upload_id`.
  - `upload_file` → stream body bytes to R2 `PutObject`, return `{ url, r2Key }`. Insert `temp_files` row.
  - `stop` → call R2 `CompleteMultipartUpload`. Update `meetings.recording_url`.
  - `pause` / `resume` → no-op for R2 (future: hook SFU mixer).
- Env vars: `CLOUDFLARE_ACCOUNT_ID`, `CLOUDFLARE_R2_ACCESS_KEY_ID`, `CLOUDFLARE_R2_SECRET_ACCESS_KEY`, `R2_BUCKET_NAME`, `R2_PUBLIC_BASE_URL`.

### 9-C  `push_notification`
- [ ] **File:** `supabase/functions/push_notification/index.ts` ← **create**
- **What:** Accepts `{ token, title, body, data }`. Uses Firebase Admin SDK `messaging().send(...)`. Env: `FIREBASE_PROJECT_ID`, `FIREBASE_CLIENT_EMAIL`, `FIREBASE_PRIVATE_KEY`.

### 9-D  `ai_summarize`
- [ ] **File:** `supabase/functions/ai_summarize/index.ts` ← **create**
- **What:** Accepts `{ lines: string[] }`. Calls Anthropic Claude `haiku` or OpenAI `gpt-4o-mini`. Returns `{ summary: string }`. Env: `ANTHROPIC_API_KEY` or `OPENAI_API_KEY`.

### 9-E  `cleanup_r2_files`
- [ ] **File:** `supabase/functions/cleanup_r2_files/index.ts` ← **create**
- **What:** Reads up to 100 rows from `r2_pending_deletes`. Calls R2 `DeleteObjects`. Deletes processed rows from the table. Called by pg_cron hourly.


---

## ═══════════════════════════════════════════════════
## SECTION 10 — ANYDESK REMOTE CONTROL COMPLETIONS
## ═══════════════════════════════════════════════════

### 10-A  Keyboard event capture (controller side)
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Tile._withControlForwarding` — wrap child with `Focus` widget
- **What:** When `rc.isControlling`, add `HardwareKeyboard.instance.addHandler` in a `StatefulWidget`'s `initState`. On key event, call `rc.sendKeyEvent(controller.localUid, keyCode: ..., modifiers: ..., action: ...)`. Remove handler in `dispose`.

### 10-B  Scroll forwarding
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Tile._withControlForwarding` `GestureDetector`
- **What:** Add `onPanUpdate` mapped to `rc.sendScroll(controller.localUid, d.delta.dx / box.maxWidth, d.delta.dy / box.maxHeight)`.

### 10-C  Native injection receiver (shared screen view only)
- [ ] **File:** `services/remote_control_service.dart`
- **Where:** `_handleDataMessage` — `mouseMove` / `mouseClick` / `keyEvent` cases
- **What:** On Web: use `dart:html` to dispatch `MouseEvent` / `KeyboardEvent` on `document.elementFromPoint(x * window.innerWidth, y * window.innerHeight)`. On Android/iOS: this is sandbox-blocked — show a clearly labelled "in-screen-share-view only" overlay and do nothing further.

### 10-D  Clipboard receiver
- [ ] **File:** `services/remote_control_service.dart`
- **Where:** `clipboardSync` case
- **What:** `Clipboard.setData(ClipboardData(text: ctrl.clipboardText!));`

### 10-E  Heartbeat guard
- [ ] **File:** `services/remote_control_service.dart`
- **Where:** `grantControl()` — start a `Timer.periodic(Duration(seconds: 5), ...)` that sends `ControlEventType.heartbeat`
- **Where:** `_handleDataMessage` — `heartbeat` case resets a `_lastHeartbeat` timestamp
- Add a separate timer that checks `_lastHeartbeat` every 10 s; if gap > 15 s calls `revokeControl(localUid)`.

### 10-F  Control request from toolbar
- [ ] **File:** `in_meeting/zoom_meeting_view.dart`
- **Where:** `_Toolbar.build()` — add button visible only when another participant is sharing:
```dart
Obx(() {
  final sharer = controller.participants.values.firstWhereOrNull((p) => p.isScreenSharing && p.uid != controller.localUid);
  if (sharer == null) return const SizedBox.shrink();
  return _btn(Icons.mouse_outlined, 'Request ctrl', onTap: () =>
    controller.remoteControl?.requestControl(sharer.uid, controller.localUid));
}),
```


---

## ═══════════════════════════════════════════════════
## SECTION 11 — PUSH NOTIFICATIONS
## ═══════════════════════════════════════════════════

### 11-A  Wire PushService
- [ ] **File:** `services/push_service.dart`
- **Where:** `init()`
- **What:**
```dart
Future<void> init() async {
  await FirebaseMessaging.instance.requestPermission();
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null && CurrentUser.isSignedIn) {
    await Supabase.instance.client.from('user_table')
      .update({'fcm_token': token}).eq('auth_user_id', CurrentUser.authUid);
  }
  FirebaseMessaging.instance.onTokenRefresh.listen((t) async {
    await Supabase.instance.client.from('user_table')
      .update({'fcm_token': t}).eq('auth_user_id', CurrentUser.authUid);
  });
}
Future<void> notifyInvite({required String toToken, required String meetingId}) async {
  await Supabase.instance.client.functions.invoke('push_notification', body: {
    'token': toToken, 'title': 'Meeting invite', 'body': 'You were invited to join',
    'data': {'route': ZoomRoutes.join, 'meetingId': meetingId},
  });
}
Future<void> notifyChatMention({required String toToken, required String fromName, required String preview}) async {
  await Supabase.instance.client.functions.invoke('push_notification', body: {
    'token': toToken, 'title': '$fromName mentioned you', 'body': preview,
  });
}
```

### 11-B  Call PushService.init() on app start
- [ ] **File:** `in_meeting/zoom_meeting_binding.dart`
- **Where:** `dependencies()` — after `RtcBackendManager` registration
- **What:** `if (CurrentUser.isSignedIn) unawaited(PushService().init());`


---

## ═══════════════════════════════════════════════════
## SECTION 12 — NEW PACKAGES NEEDED
## ═══════════════════════════════════════════════════

Add these to `pubspec.yaml` (all are well-maintained, pinned to exact minor):

```yaml
# Video playback
video_player: ^2.9.1

# Emoji picker
emoji_picker_flutter: ^2.2.0

# Audio recording (voice notes)
record: ^5.1.2

# File picker
file_picker: ^8.1.2

# Social: confetti burst on 👏 reaction
confetti: ^0.8.0

# Social: audio waveform visualisation for voice notes
audio_waveforms: ^1.0.5

# Community: phone contacts picker for DM invite
fast_contacts: ^3.0.0
```

---

## ═══════════════════════════════════════════════════
## SECTION 13 — NEW FILE / FOLDER MAP
## ═══════════════════════════════════════════════════

```
zoom_agora/
├── community/
│   ├── community_home_view.dart        ← Section 6-B
│   ├── community_room_view.dart        ← Section 6-C
│   ├── community_new_view.dart         ← Section 6-D
│   └── community_service.dart          ← Section 6-E
│
├── social/
│   ├── feed_view.dart                  ← Section 7-C
│   ├── post_card.dart                  ← Section 7-D
│   ├── post_detail_view.dart           ← Section 7-E
│   ├── post_create_view.dart           ← Section 7-F
│   └── social_service.dart             ← Section 7-G
│
├── pre_meeting/
│   └── recording_player_view.dart      ← Section 5-D
│
├── models/
│   └── whiteboard_text.dart            ← Section 2-A
│
└── supabase/functions/
    ├── agora_token_generator/index.ts  ← Section 9-A
    ├── recording_manager/index.ts      ← Section 9-B
    ├── push_notification/index.ts      ← Section 9-C
    ├── ai_summarize/index.ts           ← Section 9-D
    └── cleanup_r2_files/index.ts       ← Section 9-E
```

---

## ═══════════════════════════════════════════════════
## SECTION 14 — SQL ADDITIONS (append to supabase_schema.sql)
## ═══════════════════════════════════════════════════

```sql
-- ── 2026-07-06 ──────────────────────────────────────────────
-- social_posts, social_reactions, social_comments  → Section 7-A
-- chat_message_edits                               → Section 6-G
-- meeting_pre_settings                             → Section 3-C/D

CREATE TABLE IF NOT EXISTS meeting_pre_settings (
  id                       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  meeting_id               UUID NOT NULL REFERENCES meetings(id) ON DELETE CASCADE,
  user_id                  UUID NOT NULL REFERENCES user_table(user_id),
  join_muted               SMALLINT NOT NULL DEFAULT 1,
  join_video_off           SMALLINT NOT NULL DEFAULT 0,
  allowed_to_screen_share  SMALLINT NOT NULL DEFAULT 0,
  UNIQUE(meeting_id, user_id)
);
ALTER TABLE meeting_participants
  ADD COLUMN IF NOT EXISTS breakout_room_id VARCHAR(20);
```

---

## ═══════════════════════════════════════════════════
## SECTION 15 — ZOOM TEST CHECKLIST (ready to go)
## ═══════════════════════════════════════════════════

Run these manually with two real devices / two browser tabs on the same local network.

```
PRE-MEETING
[ ]  Open /zoom — top bar, hero, upcoming list render without errors
[ ]  Tap "New meeting" — device preview screen opens
[ ]  Lobby checklist turns green as you enable cam/mic/speaker
[ ]  Tap "Join now" — navigates to /zoom/meeting in demo mode (demoMode: true)
[ ]  Tap "Join now" with demoMode: false — camera/mic permission prompt fires

IN MEETING — VIDEO
[ ]  Both participants see each other's video tiles
[ ]  Mute / unmute mic → other participant's tile shows mic icon change
[ ]  Turn off / on camera → other participant sees initials avatar swap
[ ]  Screen share starts → shared screen fills big tile
[ ]  Switch to Gallery view — equal grid renders for all participants

IN MEETING — WHITEBOARD
[ ]  Open whiteboard panel → blank white canvas appears
[ ]  Draw a stroke → second device sees it in < 1 second
[ ]  Tap Text tool → popup dialog appears with text field + controls
[ ]  Type text, confirm → text appears on canvas on both devices
[ ]  Host taps lock → non-host draw attempts are blocked

IN MEETING — CHAT
[ ]  Type a message → second device receives it in real time
[ ]  Attach an image → uploads and shows in bubble on both sides
[ ]  Swipe right on a bubble → reply bar appears above composer
[ ]  Long-press bubble → emoji reaction popup appears
[ ]  Search icon → filters messages matching query

IN MEETING — HOST CONTROLS
[ ]  Mute participant → their mic icon shows muted on both devices
[ ]  Force video off → their video turns off on both devices
[ ]  Rename participant → new name appears on their tile
[ ]  Lower all hands → all ✋ icons disappear
[ ]  Transfer host → role badge updates for both users
[ ]  Remove participant → kicked user navigates to /zoom home

REMOTE CONTROL
[ ]  Participant A starts screen share
[ ]  Participant B opens People panel → "Request control" appears
[ ]  B requests control → A sees permission dialog
[ ]  A accepts → B sees "Controlling" badge on tile
[ ]  B clicks on tile → A sees remote cursor overlay move
[ ]  B clicks stop → control revoked, cursor disappears

COMMUNITY CHAT
[ ]  Open /zoom/community → room list loads from Supabase
[ ]  Open a room → message history loads, Realtime subscription active
[ ]  Send text message → other user sees it without refresh
[ ]  Send an image → uploads to R2, shows in bubble
[ ]  Edit a sent message → "(edited)" label appears, old content in history
[ ]  Long-press a message → react with emoji, reaction count updates

SOCIAL FEED
[ ]  Open /zoom/feed → posts load from Supabase
[ ]  Create a post with image → uploads to R2, appears in feed
[ ]  Like a post → reaction count increments in real time
[ ]  Open comments → thread loads, can reply nested
[ ]  Short meeting clips appear in reel strip at top

BREAKOUTS
[ ]  Host creates 2 rooms (manual) → assigns participants
[ ]  Tap "Open rooms" → participants leave main, join breakout channels
[ ]  Each breakout shows only its own participants
[ ]  Host closes breakouts → participants return to main room

RECORDINGS
[ ]  Start recording (requires recording_manager deployed) → red dot pulses
[ ]  Stop recording → snackbar with R2 URL appears
[ ]  R2 URL opens the video correctly in browser
[ ]  Recent recordings list on home screen shows the new entry
[ ]  Click play → recording_player_view opens with video_player
```


---

## ═══════════════════════════════════════════════════
## PRIORITY EXECUTION ORDER
## ═══════════════════════════════════════════════════

Work top-to-bottom. Each row is independently shippable. Items in the same row can be done in parallel.

| Sprint | Sections | Outcome |
|--------|----------|---------|
| **1** (fix now) | 1-A, 1-B, 1-C, 1-D | Zoom home screen shows real data, waiting room auto-advances |
| **2** (core UX) | 2-A → 2-G | Whiteboard has text editor, locks, host delete |
| **3** (lobby) | 3-A → 3-F | Real device preview, checklist, host pre-settings |
| **4** (host power) | 4-A → 4-C | Force mute/video/rename/lower hands all work |
| **5** (video) | 5-A → 5-C | Gallery view, self-hide, speaker glow animation |
| **6** (chat++) | 8-A → 8-F | Emoji, file attach, reply, search, reactions |
| **7** (remote ctrl) | 10-A → 10-F | Keyboard, scroll, heartbeat, toolbar button |
| **8** (backend) | 9-A → 9-E | Deploy all 5 Edge Functions |
| **9** (recording) | 1-E, 5-D, 5-E | Record button live, video player, reels feed |
| **10** (community) | 6-A → 6-G | WhatsApp community + group + DM + docs + edit history |
| **11** (social) | 7-A → 7-G | Posts, comments, reactions, reel strip |
| **12** (push) | 11-A, 11-B | FCM invite + chat mention notifications |

---

*End of file — 2026-07-06*
