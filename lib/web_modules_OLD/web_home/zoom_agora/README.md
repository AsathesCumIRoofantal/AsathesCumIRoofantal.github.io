# Zoom-Parity Module (Flutter + Agora + GetX)

This module turns the existing `AgoraView` into a complete Zoom-clone scaffold.
Every Zoom feature from the parity TODO has UI + a controller/service stub.
Anything that needs a real backend is marked `// TODO(backend): …` with the
exact call shape you need to provide.

## Folder layout
- `models/`         dumb data classes (Meeting, Participant, ChatMessage, Poll…)
- `services/`       integration stubs (TokenService, RtmService, RecordingService, SttService, CalendarService, PushService, StatsService)
- `pre_meeting/`    Home, Join, DevicePreview, Schedule, WaitingRoom
- `in_meeting/`     enhanced controller + Reactions, Breakouts, Polls, Captions, Whiteboard, Annotation, Settings panels
- `widgets/`        reusable bits (NetworkBadge, ReconnectBanner, ReactionOverlay, ParticipantTile…)
- `settings/`       full settings page (General, Video, Audio, Share, Background, Recording, Statistics, Shortcuts, Accessibility)
- `zoom_routes.dart`   GetX routes wiring everything together

## Wiring (one-time)
```dart
// main.dart
GetMaterialApp(
  initialRoute: ZoomRoutes.home,
  getPages: ZoomRoutes.pages,
);
```

## Required external work (cannot be shipped in-zip)
1. **Token server** — Node/Go endpoint that signs Agora RTC + RTM tokens.
   Point `TokenService.endpoint` at it.
2. **Agora Cloud Recording** REST credentials → `RecordingService`.
3. **STT provider** (Agora STT add-on / Whisper streaming) → `SttService`.
4. **Push** (FCM / APNs) → `PushService`.
5. **Persistence** (Firestore / Supabase) for meetings, chat, recordings.
