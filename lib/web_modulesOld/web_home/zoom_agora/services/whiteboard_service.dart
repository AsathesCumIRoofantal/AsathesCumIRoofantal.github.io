/// Wrap Agora Interactive Whiteboard or tldraw web view.
class WhiteboardService {
  bool isOpen = false;
  String? roomToken;
  Future<void> open() async { /* TODO: createRoom + token */ isOpen = true; }
  Future<void> close() async { isOpen = false; }
  Future<String> exportPng() async => 'TODO_url';
}
