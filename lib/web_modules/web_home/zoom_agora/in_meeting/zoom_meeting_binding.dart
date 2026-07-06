import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
import '../mock/mock_data.dart';
import '../models/rtc_config.dart';
import '../services/rtc_backend_manager.dart';
import '../services/current_user.dart';

/// Binds the controller and the RTC backend manager (Agora <-> WebRTC swap).
///
/// - `demoMode == true` (default, or a live join throws — e.g. no
///   camera/mic permission, no network): falls back to [MockMeetingSim] so
///   the UI still "feels deployed", same as the original module.
/// - Otherwise: joins a real mesh WebRTC call over Supabase signaling.
///
/// Pass route arguments to control this:
///   Get.toNamed(ZoomRoutes.meeting, arguments: {
///     'channelId': meeting.channelName,
///     'displayName': myName,
///     'demoMode': false,
///   });
class ZoomMeetingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RtcBackendManager>()) {
      final mgr = Get.put(RtcBackendManager(), permanent: true);
      mgr.init(RtcConfig.fromEnvironment(backend: RtcBackend.webrtc));
    }

    Get.lazyPut<ZoomMeetingController>(() {
      final c = ZoomMeetingController();
      final mgr = Get.find<RtcBackendManager>();
      final args = Get.arguments as Map? ?? const {};
      final channelId = (args['channelId'] as String?) ?? 'air_space_default_channel';
      final localName = (args['displayName'] as String?) ?? 'Guest';
      final demoMode = (args['demoMode'] as bool?) ?? true;
      final meetingRowId = args['meetingRowId'] as String?;
      final joinMuted = args['joinMuted'] as bool? ?? false;
      final joinVideoOff = args['joinVideoOff'] as bool? ?? false;

      if (demoMode) {
        final sim = MockMeetingSim(c)..seed();
        Future.microtask(sim.start);
      } else {
        final uid = DateTime.now().millisecondsSinceEpoch.remainder(1 << 20);
        final config = RtcConfig(backend: RtcBackend.webrtc, channelId: channelId, uid: uid);
        Future.microtask(() async {
          try {
            await CurrentUser.ensureProfileLoaded();
            await c.connectToLiveMeeting(
              backendManager: mgr,
              config: config,
              name: CurrentUser.isSignedIn ? CurrentUser.name : localName,
              meetingRowId: meetingRowId,
              joinMuted: joinMuted,
              joinVideoOff: joinVideoOff,
            );
          } catch (_) {
            // Live join failed (permission denied, offline, etc.) — don't
            // strand the user on a blank screen, drop into the mock demo.
            final sim = MockMeetingSim(c)..seed();
            sim.start();
          }
        });
      }
      return c;
    });
  }
}
