# AIR Meet — Zoom-parity Flutter module (WebRTC, real, no Agora)

A self-contained Flutter module (drop into `GetMaterialApp`) that does real
video meetings: mesh WebRTC calling, screen sharing, permission-gated
in-app remote control, whiteboard, chat, reactions, polls, Q&A, live
captions, and breakout rooms — synced over Supabase Realtime, with **zero
per-minute media cost**. No Agora, no separate signaling server.

This file is the one thing to read before deploying. `WEBRTC_SETUP.md`
has the deeper technical detail on anything below; `supabase_patch_meeting_live.sql`
is a required database migration — see step 2.

---

## Is it smooth? Honest status

**Solid and wired end to end, no mocks in the path:** joining/creating
meetings, mesh video/audio calls, screen sharing, in-app remote control
with permission prompts, chat, reactions, hand-raise, typing indicators,
whiteboard, polls, Q&A, live captions, call-quality stats, breakout room
assignment, and kicking a participant.

**Real, but with an inherent limitation, not a bug:**
- Mesh calling tops out cleanly around **6-8 simultaneous video
  participants** — every extra person multiplies everyone's upload
  bandwidth. That's the tradeoff for zero-cost calling; scaling further
  needs a media server (SFU) — see `WEBRTC_SETUP.md` §5.
- **iOS cannot be remotely controlled at the OS level** — no app can,
  it's an Apple sandbox restriction. What's built is full control
  *within the shared-screen view*, which works on every platform
  including iOS. See `WEBRTC_SETUP.md` §6 for the exact capability
  matrix by platform.
- **Live captions** only transcribe each device's own microphone (a
  phone can't listen to a remote peer's audio stream directly) — each
  participant's captions broadcast to everyone else, not centrally
  transcribed.
- `broadcastToBreakouts()` (host message to everyone in breakout rooms
  at once) is flagged, not built — needs one more architectural decision
  from you, see `WEBRTC_SETUP.md` §7.

**Needs something only you can provide, not implemented:** cloud
recording (needs a paid service), push notifications (needs your
Firebase credentials), Google/Outlook calendar push (needs OAuth app
credentials), virtual background (needs an ML segmentation model). All
four are cleanly stubbed with clear comments, not silently broken.

Nothing else in the codebase is a stub pretending to be real. Where a
constraint is inherent to the platform or the zero-cost architecture,
it's commented in the code at the exact spot, not hidden.

### UI action audit (just done)

Every `onTap`/`onPressed`/`onSubmitted` in the module was traced to a
real controller method and checked for signature matches — all clean.
Beyond that, a few genuine dead-ends were caught and fixed:
- **Record button** used to silently pretend it started recording
  (the stub set `isRecording = true` with no actual capture). Now shows
  an honest "not connected" dialog instead.
- **Breakout "manual" mode** created empty rooms with no way to actually
  assign anyone to them. Added a real assignment UI (tap a participant
  → pick a room) and an "Open rooms" button to move everyone at once.
- **Breakout broadcast field** accepted text and submitted it into a
  method that just logs to console — now tells the person it isn't wired
  up yet instead of silently doing nothing.
- **Virtual background picker** returned a choice that was never read —
  picking a preset closed the dialog with zero feedback. Now says
  clearly that it isn't implemented yet.
- **Device preview mic/camera toggles** were cosmetic only — turning
  your camera off before joining had no effect on the actual call, you
  always joined with both on. Now respected.

**Known lower-priority gap, not fixed this pass:** the Settings screen's
HD video / mirror / low-light / touch-up / noise-suppression switches
toggle their own state but don't cascade into the actual video pipeline
yet (e.g. "Mirror my video" doesn't affect the real `RTCVideoView`).
They're not dead-ends exactly — the switches work as switches — just not
wired to real effects yet. Low effort to wire if you want it next.

---

## Steps to make it live

### 1. Drop the module in
Copy `zoom_agora/` into your existing Flutter project. This is a module,
not a full app — it expects to be wired into your `GetMaterialApp`:
```dart
GetMaterialApp(
  initialRoute: ZoomRoutes.home,
  getPages: ZoomRoutes.pages,
);
```

### 2. Run the SQL patch — do this before anything else
Open `supabase_patch_meeting_live.sql` in your Supabase SQL editor and
run it once. It fixes RLS policies that, as originally written, silently
blocked meeting creation/join (`auth.uid()` was compared against the
wrong column), adds the `meeting_participants` policies that didn't
exist at all, and adds a trigger that auto-creates a `user_table` row on
signup. **Skipping this means every create/join attempt fails or
silently writes nothing.**

Also double-check one thing the patch flags: `user_last_login_logs_id`'s
NOT NULL constraint on `user_table`, as given, looks like a circular
foreign-key requirement that would block signup entirely if it's really
live. See the comment at the bottom of the patch file.

### 3. Add dependencies
```yaml
dependencies:
  flutter_webrtc: ^0.11.7
  supabase_flutter: ^2.8.0
  collection: ^1.18.0
  permission_handler: ^11.3.1
  speech_to_text: ^7.0.0
```
`flutter pub get`. I couldn't run this myself (no Flutter SDK or network
in the sandbox this was built in) — build once and send me any version-
mismatch errors.

### 4. Initialize Supabase before the module is used
```dart
await Supabase.initialize(url: 'https://YOUR_PROJECT.supabase.co', anonKey: 'YOUR_ANON_KEY');
```

### 5. Platform permissions
- **Android** (`AndroidManifest.xml`): camera, record audio, foreground
  service (+ foreground-service-media-projection for screen share).
- **iOS** (`Info.plist`): camera, microphone, and speech-recognition
  usage strings. Screen sharing on iOS additionally needs a Broadcast
  Upload Extension target in Xcode (native project change, not something
  addable from Dart alone).
- Exact snippets are in `WEBRTC_SETUP.md` §2.

### 6. TURN server (so calls survive strict NATs)
Self-host `coturn` (docker-compose provided in `WEBRTC_SETUP.md` §4) or
use a free-tier hosted TURN service. Without this, some real-world
networks (mobile carrier NAT, corporate firewalls) will fail to connect
peer-to-peer.

### 7. Test with two real devices/browsers
Same meeting `channelId`, `demoMode: false` (already the default once
you go through the real join/schedule flow). Confirm camera/mic prompts
fire, video connects, screen share works, and remote control shows the
permission dialog.

### 8. Distribute
- Web: HTTPS hosting required (camera/mic/screen APIs refuse plain HTTP).
- Android: signed AAB → Play Console.
- iOS: Xcode archive → TestFlight/App Store (needs a Mac + Apple dev account).

---

## Where things live (quick orientation)

| Concern | File |
|---|---|
| Real-time media (mesh WebRTC) | `services/webrtc_service.dart` |
| Signaling (Supabase Realtime) | `services/signaling_service.dart` |
| Meeting create/join/track in DB | `services/meeting_service.dart` |
| Current user (bridges your auth) | `services/current_user.dart` |
| Remote control protocol | `services/remote_control_service.dart` |
| In-meeting state, chat/polls/qa/whiteboard sync | `in_meeting/zoom_meeting_controller.dart` |
| Whiteboard canvas | `in_meeting/whiteboard_view.dart` |
| Remote-control permission UI | `in_meeting/remote_control_overlay.dart` |
| Live captions | `services/stt_service.dart` |
| Meeting entry points | `pre_meeting/home_view.dart`, `join_view.dart`, `schedule_view.dart` |

## Routes

| Route | Screen |
|---|---|
| `/zoom` | Home |
| `/zoom/join` | Join by ID / link |
| `/zoom/preview` | Camera / mic / speaker test |
| `/zoom/schedule` | Schedule a meeting |
| `/zoom/waiting` | Waiting room |
| `/zoom/meeting` | In-meeting stage + panels |
| `/zoom/settings` | Account & device settings |

## Full technical detail

See `WEBRTC_SETUP.md` for: the complete platform-permission snippets,
the TURN docker-compose, the mesh-vs-SFU tradeoff explained, the exact
remote-control capability matrix per platform, and the full list of
what's real vs. flagged in this pass.

---

## PATCH 2026-07-16 — Multi-screen-share (up to 10) + button-visibility fix

**Screen sharing:** fixed a real bug where a second person starting a
share silently force-stopped the first person's share (the controller
was clearing everyone else's share flag every time). Multiple people can
now share at once, capped at **10 concurrent presenters**, enforced both
client-side and — the part that actually matters — with a database
trigger in `supabase_schema.sql`, so the cap holds regardless of which
client is asking. Added a proper screen-share stage layout that shows one
big view for a single sharer or an even grid for several, instead of the
previous behavior where a shared screen only appeared if that person
happened to also be picked as active speaker.

**Honest caveat, same spirit as the rest of this README:** this is still
zero-cost mesh, so "10 presenters, unlimited viewers" isn't something
software can promise here — each presenter uploads their screen once per
*other person in the meeting*, mesh has no server to fan that out. 10
presenters is a real, useful cap to build; unlimited viewers on top of
mesh would not be an honest claim. See `WEBRTC_SETUP.md` §9 for the full
explanation and what an actual unlimited-viewer webinar shape would
require (an SFU/media server — a separate, sizeable build).

**Buttons/text that were invisible:** several controls (Settings screen's
dropdowns most visibly) inherited their color from *your* app's theme
instead of this module's own dark palette, because they never set an
explicit color. On a light host theme that landed near-black text on this
module's near-black backgrounds — present, just not visible. Fixed at the
root by forcing this module's own `ThemeData` on every route it owns
(`zoom_routes.dart`), rather than patching each unstyled widget one at a
time.

### Things to do on your side
1. Re-run `supabase_schema.sql` — the new 2026-07-16 section at the
   bottom is additive and safe to run on top of what's already applied.
2. Set `app.supabase_url` and `app.service_role_key` as database settings
   (see the comment above the R2-cleanup cron job in the SQL file) —
   without them that one cron job errors on every run.
3. Test screen sharing with 3+ real devices — this was code-reviewed and
   logically verified, not device-tested (still no Flutter SDK/network in
   the sandbox this was built in).
4. Tell me if you actually need real unlimited-viewer scale (a webinar,
   not a meeting) — that's the LiveKit/SFU path, a separate build I can
   scaffold next rather than something to fake on top of mesh.
