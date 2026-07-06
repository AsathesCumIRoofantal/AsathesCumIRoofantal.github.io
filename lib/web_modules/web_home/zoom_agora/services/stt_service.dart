import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Live captions via on-device speech recognition (Android's
/// SpeechRecognizer / iOS's Speech framework through the `speech_to_text`
/// package) — free, no per-minute cloud STT bill.
///
/// Important scope note: this can only transcribe audio *this device* has
/// permission to capture, i.e. the local user's own microphone — it
/// cannot transcribe a remote participant's incoming WebRTC audio stream.
/// So captions work the same way real-time captioning works in most
/// consumer apps without a server in the loop: everyone who wants
/// captions turns them on, each device transcribes its own speaker, and
/// the recognized text is broadcast to everyone else over the data
/// channel (wired in `zoom_meeting_controller.dart`).
class SttService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _available = false;
  bool enabled = false;
  String targetLang = 'en_US';

  final _captionCtrl =
      StreamController<({int uid, String text, String? lang, bool isFinal})>.broadcast();
  Stream<({int uid, String text, String? lang, bool isFinal})> get onCaption => _captionCtrl.stream;

  /// [uid] identifies whose mic this is (always the local uid in
  /// practice) so the controller can label/broadcast it correctly.
  Future<void> start({required String channel, required int uid}) async {
    _available = await _speech.initialize(
      onError: (e) => debugPrint('SttService: recognition error: $e'),
      onStatus: (s) => debugPrint('SttService: status $s'),
    );
    if (!_available) {
      debugPrint('SttService: speech recognition unavailable on this device.');
      return;
    }
    enabled = true;
    await _listenOnce(uid);
  }

  Future<void> _listenOnce(int uid) async {
    if (!enabled) return;
    await _speech.listen(
      localeId: targetLang,
      onResult: (r) => _captionCtrl.add((
        uid: uid,
        text: r.recognizedWords,
        lang: targetLang,
        isFinal: r.finalResult,
      )),
      listenFor: const Duration(minutes: 5),
      pauseFor: const Duration(seconds: 8),
      partialResults: true,
    );
    // The OS recognizer auto-stops after `listenFor`/silence — restart
    // it for a continuous captioning experience while enabled.
    unawaited(Future.delayed(const Duration(minutes: 5), () {
      if (enabled) _listenOnce(uid);
    }));
  }

  Future<void> stop() async {
    enabled = false;
    await _speech.stop();
  }

  void setLanguage(String localeId) => targetLang = localeId;

  /// No LLM wired in — that needs an API key/provider only you can
  /// supply. This is a plain fallback so the button still does
  /// something; swap in a real call (OpenAI/Claude/etc via your own
  /// backend, never a raw API key in the client) when you're ready.
  Future<String> summarize(List<String> transcript) async {
    if (transcript.isEmpty) return 'No transcript captured yet.';
    return 'Transcript (${transcript.length} lines) — plug an LLM call in '
        'SttService.summarize() for a real summary:\n\n${transcript.join('\n')}';
  }

  void dispose() => _captionCtrl.close();
}
