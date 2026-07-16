import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pre_meeting/home_view.dart';
import 'pre_meeting/join_view.dart';
import 'pre_meeting/device_preview_view.dart';
import 'pre_meeting/schedule_view.dart';
import 'pre_meeting/waiting_room_view.dart';
import 'in_meeting/zoom_meeting_view.dart';
import 'in_meeting/zoom_meeting_binding.dart';
import 'settings/settings_view.dart';
import 'widgets/zoom_theme.dart';

/// Forces this module's own dark ThemeData on every route it owns, so
/// buttons/dropdowns/etc. never silently inherit an invisible color combo
/// from whatever ThemeData the host app's GetMaterialApp is using. See
/// ZoomTheme.themeData's doc comment for the full explanation.
Widget _themed(Widget child) => Theme(data: ZoomTheme.themeData, child: child);

abstract class ZoomRoutes {
  static const home          = '/zoom';
  static const join          = '/zoom/join';
  static const devicePreview = '/zoom/preview';
  static const schedule      = '/zoom/schedule';
  static const waiting       = '/zoom/waiting';
  static const inMeeting     = '/zoom/meeting';
  static const settings      = '/zoom/settings';

  static final pages = <GetPage>[
    GetPage(name: home,          page: () => _themed(const ZoomHomeView())),
    GetPage(name: join,          page: () => _themed(const ZoomJoinView())),
    GetPage(name: devicePreview, page: () => _themed(const DevicePreviewView())),
    GetPage(name: schedule,      page: () => _themed(const ScheduleView())),
    GetPage(name: waiting,       page: () => _themed(const WaitingRoomView())),
    GetPage(name: settings,      page: () => _themed(const SettingsView())),
    GetPage(name: inMeeting,     page: () => _themed(const ZoomMeetingView()), binding: ZoomMeetingBinding()),
  ];
}
