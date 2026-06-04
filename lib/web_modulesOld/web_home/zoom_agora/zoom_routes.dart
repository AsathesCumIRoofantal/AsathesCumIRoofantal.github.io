import 'package:get/get.dart';
import 'pre_meeting/home_view.dart';
import 'pre_meeting/join_view.dart';
import 'pre_meeting/device_preview_view.dart';
import 'pre_meeting/schedule_view.dart';
import 'pre_meeting/waiting_room_view.dart';
import 'in_meeting/zoom_meeting_view.dart';
import 'in_meeting/zoom_meeting_binding.dart';
import 'settings/settings_view.dart';

abstract class ZoomRoutes {
  static const home          = '/zoom';
  static const join          = '/zoom/join';
  static const devicePreview = '/zoom/preview';
  static const schedule      = '/zoom/schedule';
  static const waiting       = '/zoom/waiting';
  static const inMeeting     = '/zoom/meeting';
  static const settings      = '/zoom/settings';

  static final pages = <GetPage>[
    GetPage(name: home,          page: () => const ZoomHomeView()),
    GetPage(name: join,          page: () => const ZoomJoinView()),
    GetPage(name: devicePreview, page: () => const DevicePreviewView()),
    GetPage(name: schedule,      page: () => const ScheduleView()),
    GetPage(name: waiting,       page: () => const WaitingRoomView()),
    GetPage(name: settings,      page: () => const SettingsView()),
    GetPage(name: inMeeting,     page: () => const ZoomMeetingView(), binding: ZoomMeetingBinding()),
  ];
}
