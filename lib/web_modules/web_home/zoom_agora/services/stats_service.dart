import 'package:get/get.dart';

/// Live call quality numbers, shown in `stats_panel.dart`.
/// Populated from real WebRTC `getStats()` data — see
/// `ZoomMeetingController._applyStats()`, which converts the engine's
/// cumulative byte counters into these kbps/loss/resolution figures.
class StatsService {
  final cpuAppPct      = 0.obs;
  final cpuTotalPct    = 0.obs;
  final txKbps         = 0.obs;
  final rxKbps         = 0.obs;
  final jitterMs       = 0.obs;
  final packetLossPct  = 0.0.obs;
  final lastResolution = '1280x720'.obs;
  final codec          = 'H264'.obs;
  // cpuAppPct/cpuTotalPct/jitterMs aren't populated yet — flutter_webrtc's
  // getStats() doesn't expose CPU usage, and jitter needs one more stat
  // report field this pass didn't wire. Safe to leave at 0 for now; the
  // panel just won't show movement on those three specifically.
}
