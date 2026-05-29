// ============================================================
//  AIR App – Meeting Service  (Agora / WebRTC abstraction)
// ============================================================
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../models/meeting_model.dart';

abstract class IMeetingService {
  Future<List<MeetingModel>> getMeetings();
  Future<MeetingModel?>      createMeeting(MeetingModel meeting);
  Future<bool>               joinMeeting(String meetingId);
  Future<void>               endMeeting(String meetingId);
  Future<void>               leaveMeeting(String meetingId);
}

class MeetingService extends GetxService implements IMeetingService {
  static MeetingService get to => Get.find();

  /// true  → Flutter WebRTC engine
  /// false → Agora RTC engine  (default)
  final bool useWebRtc = AppConstants.isAgoraNotUsed;

  final _meetings = DummyMeetings.meetings;

  @override
  Future<List<MeetingModel>> getMeetings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _meetings;
  }

  @override
  Future<MeetingModel?> createMeeting(MeetingModel meeting) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _meetings.insert(0, meeting);
    return meeting;
  }

  @override
  Future<bool> joinMeeting(String meetingId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Dummy: always succeed
    if (AppConstants.isDummyMode) return true;
    // Real: fetch token from edge function then join Agora/WebRTC channel
    return true;
  }

  @override
  Future<void> endMeeting(String meetingId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> leaveMeeting(String meetingId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // ── Agora Token (edge function) ───────────────────────────
  Future<String?> fetchAgoraToken(String channelName, int uid) async {
    if (AppConstants.isDummyMode) return AppConstants.agoraTempToken;
    // Real: call edge function token_generator
    return null;
  }
}
