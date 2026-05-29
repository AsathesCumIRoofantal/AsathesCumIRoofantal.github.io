// ============================================================
//  AIR App – Meeting Room Controller  (Agora / WebRTC)
// ============================================================
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../constants/app_constants.dart';
import '../../../models/meeting_model.dart';
import '../../../services/meeting_service.dart';
import '../../../../core/permissions/permission_handler.dart';

class MeetingRoomController extends GetxController {
  final MeetingModel meeting;
  MeetingRoomController({required this.meeting});

  // ── Engine toggle ─────────────────────────────────────
  final bool useWebRtc = AppConstants.isAgoraNotUsed;

  // ── Local AV state ────────────────────────────────────
  final RxBool isMicOn          = true.obs;
  final RxBool isCameraOn       = true.obs;
  final RxBool isScreenSharing  = false.obs;
  final RxBool isRecording      = false.obs;
  final RxBool isHandRaised     = false.obs;
  final RxBool isChatOpen       = false.obs;
  final RxBool isParticipantPanelOpen = false.obs;
  final RxBool isWaiting        = false.obs;
  final RxBool isInMeeting      = false.obs;
  final RxBool isSpeakerOn      = true.obs;
  final RxString layoutMode     = 'grid'.obs; // grid | spotlight | sidebar

  final RxList<MeetingParticipant> participants = <MeetingParticipant>[].obs;
  final RxString  activeView    = ''.obs;   // userId of spotlight participant

  @override
  void onInit() {
    super.onInit();
    participants.value = meeting.participants.toList();
    _joinMeeting();
  }

  Future<void> _joinMeeting() async {
    isWaiting.value = true;
    // Request AV permissions
    final granted = await PermissionService.to.requestMeetingPermissions();
    if (!granted && !kIsWeb) {
      Get.snackbar('Permission Required', 'Camera & Microphone access needed');
      isWaiting.value = false;
      return;
    }

    if (AppConstants.isDummyMode) {
      await Future.delayed(const Duration(seconds: 1));
      isInMeeting.value = true;
      isWaiting.value   = false;
      _addDummyParticipants();
      return;
    }

    final success = await MeetingService.to.joinMeeting(meeting.id);
    isInMeeting.value = success;
    isWaiting.value   = false;
  }

  void _addDummyParticipants() {
    if (participants.isEmpty) {
      participants.addAll([
        MeetingParticipant(userId: 'usr_001', name: 'Alice', role: ParticipantRole.host),
        MeetingParticipant(userId: 'usr_002', name: 'Bob',   isMuted: true),
        MeetingParticipant(userId: 'usr_003', name: 'Carol', isCameraOff: true),
        MeetingParticipant(userId: 'usr_004', name: 'Dan',   isHandRaised: true),
      ]);
    }
  }

  // ── Controls ──────────────────────────────────────────
  void toggleMic()         => isMicOn.value         = !isMicOn.value;
  void toggleCamera()      => isCameraOn.value       = !isCameraOn.value;
  void toggleSpeaker()     => isSpeakerOn.value      = !isSpeakerOn.value;
  void toggleScreenShare() => isScreenSharing.value  = !isScreenSharing.value;
  void toggleRecording()   => isRecording.value      = !isRecording.value;
  void raiseHand()         => isHandRaised.value     = !isHandRaised.value;
  void toggleChat()        => isChatOpen.value       = !isChatOpen.value;
  void toggleParticipants() => isParticipantPanelOpen.value = !isParticipantPanelOpen.value;
  void setLayout(String mode) => layoutMode.value    = mode;
  void spotlightUser(String uid) { activeView.value  = uid; layoutMode.value = 'spotlight'; }

  Future<void> endMeeting() async {
    await MeetingService.to.endMeeting(meeting.id);
    Get.back();
  }

  Future<void> leaveMeeting() async {
    await MeetingService.to.leaveMeeting(meeting.id);
    Get.back();
  }

  @override
  void onClose() {
    // Dispose Agora / WebRTC engine
    super.onClose();
  }
}
