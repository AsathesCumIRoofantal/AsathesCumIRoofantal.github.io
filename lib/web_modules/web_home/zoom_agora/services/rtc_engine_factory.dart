import '../models/rtc_config.dart';
import 'agora_rtc_service.dart';
import 'rtc_engine_interface.dart';
import 'webrtc_service.dart';

/// Constructs the right [RtcEngineInterface] for the requested backend.
/// Centralised so swapping engines is a one-liner from anywhere.
class RtcEngineFactory {
  static RtcEngineInterface create(RtcBackend backend) {
    switch (backend) {
      case RtcBackend.agora:  return AgoraRtcService();
      case RtcBackend.webrtc: return WebRtcService();
    }
  }
}
