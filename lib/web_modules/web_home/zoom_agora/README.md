# AIR Meet — Zoom-Parity Module (Polished + Mock-deployed)

A self-contained Flutter module that ships Zoom-parity UI for video meetings,
seeded with realistic dummy users so the app **feels deployed** even without a
real Agora/RTC backend.

## What's new in this build

- **Polished UI/UX** across every screen (home, join, device preview, schedule,
  waiting room, in-meeting, chat, participants, polls, Q&A, breakouts, stats).
- **Shared design tokens** in `widgets/zoom_theme.dart` (colors, gradients,
  typography, responsive helpers, `InitialsAvatar`).
- **Mock simulation** in `mock/mock_data.dart` — seeds 10 dummy participants,
  chat history, polls, Q&A, breakouts, waiting-room guests, then keeps things
  alive with rotating active-speaker, periodic chat, reactions, and network
  jitter on a 3-second tick.
- **Fully responsive layouts** — every screen uses `LayoutBuilder` to switch
  between mobile (single column / bottom sheets), tablet, and desktop
  (multi-column / side pane).
- **In-meeting side pane** opens inline on desktop and as a modal bottom sheet
  on mobile.

## Routes

```dart
import 'package:get/get.dart';
import 'zoom_agora/zoom_routes.dart';

GetMaterialApp(
  initialRoute: ZoomRoutes.home,
  getPages: ZoomRoutes.pages,
);
```

| Route                  | Screen                          |
| ---------------------- | ------------------------------- |
| `/zoom`                | Home (hero + upcoming + tiles)  |
| `/zoom/join`           | Join by ID / link               |
| `/zoom/preview`        | Camera / mic / speaker test     |
| `/zoom/schedule`       | Schedule a meeting              |
| `/zoom/waiting`        | Waiting-room screen             |
| `/zoom/meeting`        | In-meeting stage + panels       |
| `/zoom/settings`       | Account & device settings       |

## Mock data

`ZoomMeetingBinding` seeds and starts the simulation automatically when the
meeting route is entered. To swap in a real backend, replace
`MockMeetingSim` with your live data source and remove the `..seed()` /
`sim.start()` calls.

## Production wiring (still TODO)

These services are stubs — wire them when you go live:

- `services/token_service.dart` — RTC/RTM token signing endpoint
- `services/recording_service.dart` — Agora Cloud Recording REST
- `services/stt_service.dart` — Captions provider (Agora STT / Whisper)
- `services/rtm_service.dart` — Agora RTM client
