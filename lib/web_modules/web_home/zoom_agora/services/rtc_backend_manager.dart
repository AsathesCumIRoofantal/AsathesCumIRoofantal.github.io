import 'dart:async';
import 'package:get/get.dart';
import '../models/rtc_config.dart';
import 'rtc_engine_factory.dart';
import 'rtc_engine_interface.dart';

/// Holds the currently active RTC engine and exposes a reactive
/// [backend] Rx so any widget (e.g. the toggle button) can switch
/// the implementation at runtime without rebuilding the app.
///
/// Usage:
///   final mgr = Get.find<RtcBackendManager>();
///   mgr.backend.value = RtcBackend.webrtc; // triggers hot-swap
class RtcBackendManager extends GetxService {
  final Rx<RtcBackend> backend = RtcBackend.agora.obs;
  RtcEngineInterface? _engine;
  RtcConfig _config = const RtcConfig();
  final _swapCtrl = StreamController<RtcBackend>.broadcast();

  /// Fires every time the backend is swapped — UI can listen to flash a
  /// snackbar or re-attach video views.
  Stream<RtcBackend> get onSwap => _swapCtrl.stream;

  RtcEngineInterface get engine =>
      _engine ??= RtcEngineFactory.create(backend.value);

  Future<void> init(RtcConfig config) async {
    _config = config;
    backend.value = config.backend;
    _engine = RtcEngineFactory.create(backend.value);
    await _engine!.initialize(config);

    // React to runtime toggles.
    ever<RtcBackend>(backend, (b) async {
      if (_engine?.backend == b) return;
      final wasJoined = _engine?.isJoined ?? false;
      final ch = _config.channelId;
      try { await _engine?.leaveChannel(); } catch (_) {}
      try { await _engine?.dispose();      } catch (_) {}
      _config = _config.copyWith(backend: b);
      _engine = RtcEngineFactory.create(b);
      await _engine!.initialize(_config);
      if (wasJoined) {
        await _engine!.joinChannel(
          channelId: ch, token: _config.token, uid: _config.uid);
      }
      _swapCtrl.add(b);
    });
  }

  /// Convenience flip — used by the toggle button.
  void toggle() => backend.value =
      backend.value == RtcBackend.agora ? RtcBackend.webrtc : RtcBackend.agora;

  @override
  void onClose() {
    _engine?.dispose();
    _swapCtrl.close();
    super.onClose();
  }
}
