import 'dart:async';

/// Real-time speech-to-text + translation.
/// Plug Agora STT add-on, Deepgram, or a Whisper websocket.
class SttService {
  final _captionCtrl = StreamController<({int uid, String text, String? lang, bool isFinal})>.broadcast();
  Stream get onCaption => _captionCtrl.stream;

  bool enabled = false;
  String targetLang = 'en';

  Future<void> start({required String channel}) async {
    enabled = true;
    // TODO(backend): open websocket, forward audio frames, emit captions
  }
  Future<void> stop() async { enabled = false; }
  void setLanguage(String code) => targetLang = code;
  Future<String> summarize(List<String> transcript) async {
    // TODO(backend): call LLM with transcript → summary + action items
    return 'TODO: summary';
  }
  void dispose() => _captionCtrl.close();
}
