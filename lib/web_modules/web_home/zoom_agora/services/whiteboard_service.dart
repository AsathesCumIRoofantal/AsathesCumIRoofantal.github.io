/// Free, in-app collaborative whiteboard. Strokes themselves live in
/// `ZoomMeetingController.whiteboardStrokes` and sync over the same
/// WebRTC data channel used for chat/control (see `_sendApp('wb_...')`)
/// — no Agora Interactive Whiteboard license, no separate server. This
/// service just tracks whether the panel is open.
class WhiteboardService {
  bool isOpen = false;
  Future<void> open() async => isOpen = true;
  Future<void> close() async => isOpen = false;
}
