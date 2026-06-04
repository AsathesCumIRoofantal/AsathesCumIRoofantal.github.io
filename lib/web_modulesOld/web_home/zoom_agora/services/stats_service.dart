import 'package:get/get.dart';

/// Polls Agora `RtcStats`, `LocalVideoStats`, `RemoteVideoStats`.
class StatsService {
  final cpuAppPct      = 0.obs;
  final cpuTotalPct    = 0.obs;
  final txKbps         = 0.obs;
  final rxKbps         = 0.obs;
  final jitterMs       = 0.obs;
  final packetLossPct  = 0.0.obs;
  final lastResolution = '1280x720'.obs;
  final codec          = 'H264'.obs;
  // TODO: register engine.registerEventHandler(...) and update these.
}
