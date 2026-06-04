import 'dart:async';
import 'package:get/get.dart';
import '../models/participant.dart';
import '../models/chat_message.dart';
import '../models/poll.dart';
import '../models/breakout_room.dart';
import '../models/qa_item.dart';
import '../services/rtm_service.dart';
import '../services/recording_service.dart';
import '../services/stt_service.dart';
import '../services/stats_service.dart';
import '../services/whiteboard_service.dart';
import '../services/token_service.dart';

/// Layer on top of your existing AgoraRtcController. Holds every Zoom-parity
/// state piece. Wire actual engine calls where marked TODO(engine).
class ZoomMeetingController extends GetxController {
  // ── services ───────────────────────────────────────────────────────────
  final rtm        = RtmService();
  final recording  = RecordingService();
  final stt        = SttService();
  final stats      = StatsService();
  final whiteboard = WhiteboardService();

  // ── meeting meta ──────────────────────────────────────────────────────
  final meetingId  = ''.obs;
  final isLocked   = false.obs;
  final isMuteAllOn= false.obs;
  final allowAttendeeUnmute = true.obs;
  final allowChat  = true.obs;
  final allowRename= true.obs;
  final allowAttendeeVideo = true.obs;
  final connection = 'connected'.obs; // connected | reconnecting | failed

  // ── participants ──────────────────────────────────────────────────────
  final participants = <int, Participant>{}.obs;
  final pinnedUids   = <int>{}.obs;       // multi-pin
  final spotlightUids= <int>{}.obs;       // spotlight for everyone
  final hideNonVideo = false.obs;
  final activeSpeakerUid = Rxn<int>();
  final selfHidden = false.obs;

  // ── chat / waiting room ───────────────────────────────────────────────
  final chat       = <ChatMessage>[].obs;
  final waiting    = <Participant>[].obs;   // pending admit
  final typing     = <int>{}.obs;

  // ── reactions / hand ──────────────────────────────────────────────────
  final floatingReactions = <(int uid, String emoji, int ts)>[].obs;
  void react(int uid, String emoji) {
    floatingReactions.add((uid, emoji, DateTime.now().millisecondsSinceEpoch));
    rtm.sendReaction(uid, emoji);
    Future.delayed(const Duration(seconds: 10), () {
      floatingReactions.removeWhere((r)=>r.$3 < DateTime.now().millisecondsSinceEpoch-9500);
    });
  }

  // ── breakouts / polls / qa ────────────────────────────────────────────
  final breakouts = <BreakoutRoom>[].obs;
  final polls     = <Poll>[].obs;
  final qa        = <QAItem>[].obs;

  // ── recording / captions ──────────────────────────────────────────────
  final captionsOn = false.obs;
  final captionsLang = 'en'.obs;
  final liveCaption = ''.obs;
  final transcript = <String>[].obs;

  // ── settings ──────────────────────────────────────────────────────────
  final originalSound = false.obs;
  final noiseSuppression = 'auto'.obs; // off | auto | low | med | high
  final hdVideo = false.obs;
  final mirror  = true.obs;
  final touchUp = 0.0.obs;
  final lowLightFix = false.obs;
  final theme = 'dark'.obs;

  // ── host controls ─────────────────────────────────────────────────────
  Future<void> muteAll({bool allowUnmute=true}) async {
    isMuteAllOn.value = true; allowAttendeeUnmute.value = allowUnmute;
    for (final p in participants.values) { p.audioMuted = true; }
    participants.refresh();
    // TODO(engine): broadcast via data-stream so remotes mute themselves
  }
  Future<void> lockMeeting(bool v) async => isLocked.value = v;
  Future<void> admit(int uid) async {
    final p = waiting.firstWhereOrNull((p)=>p.uid==uid); if (p==null) return;
    waiting.remove(p); participants[uid]=p;
  }
  Future<void> denyAll() async => waiting.clear();
  Future<void> removeParticipant(int uid) async { participants.remove(uid); /* TODO(engine): kick */ }
  Future<void> makeCoHost(int uid) async => participants[uid]?.role = ParticipantRole.coHost;
  Future<void> transferHost(int uid) async {
    for (final p in participants.values) {
      if (p.role==ParticipantRole.host) p.role = ParticipantRole.coHost;
    }
    participants[uid]?.role = ParticipantRole.host;
    participants.refresh();
  }

  // ── pinning / spotlight ───────────────────────────────────────────────
  void togglePin(int uid)       { pinnedUids.contains(uid)?pinnedUids.remove(uid):pinnedUids.add(uid); }
  void toggleSpotlight(int uid) { spotlightUids.contains(uid)?spotlightUids.remove(uid):spotlightUids.add(uid); }

  // ── recording ─────────────────────────────────────────────────────────
  Future<void> startCloudRecording() async { await recording.start(meetingId.value, 0); update(); }
  Future<void> pauseRecording()    async { await recording.pause();  update(); }
  Future<void> resumeRecording()   async { await recording.resume(); update(); }
  Future<void> stopRecording()     async { await recording.stop();   update(); }

  // ── captions ──────────────────────────────────────────────────────────
  Future<void> toggleCaptions() async {
    captionsOn.toggle();
    if (captionsOn.value) { await stt.start(channel: meetingId.value);
      stt.onCaption.listen((e){ liveCaption.value = e.text; if (e.isFinal) transcript.add(e.text); });
    } else { await stt.stop(); }
  }
  Future<String> generateSummary() => stt.summarize(transcript);

  // ── breakouts ─────────────────────────────────────────────────────────
  void createBreakouts(int count, {bool auto=true}) {
    breakouts.clear();
    for (var i=0;i<count;i++) breakouts.add(BreakoutRoom(id:'br$i', name:'Room ${i+1}'));
    if (auto) {
      final uids = participants.keys.toList()..shuffle();
      for (var i=0;i<uids.length;i++) breakouts[i%count].participants.add(uids[i]);
    }
    breakouts.refresh();
  }
  void broadcastToBreakouts(String text){ /* TODO(engine): data-stream all rooms */ }
  void closeBreakouts({Duration warning = const Duration(seconds:60)}){
    Future.delayed(warning, ()=>breakouts.clear());
  }

  // ── polls / qa ────────────────────────────────────────────────────────
  void launchPoll(Poll p){ p.launched=true; polls.add(p); }
  void closePoll(String id){ polls.firstWhereOrNull((p)=>p.id==id)?.closed=true; polls.refresh(); }
  void answerPoll(String pollId, int uid, List<String> answer){
    polls.firstWhereOrNull((p)=>p.id==pollId)?.answers[uid]=answer; polls.refresh();
  }
  void submitQuestion(QAItem q){ qa.insert(0,q); }
  void answerQuestion(String id, String text){ qa.firstWhereOrNull((q)=>q.id==id)?..answerText=text; qa.refresh(); }

  // ── token renewal ─────────────────────────────────────────────────────
  Timer? _tokenTimer;
  void scheduleTokenRenewal(DateTime expiresAt) {
    _tokenTimer?.cancel();
    final lead = expiresAt.difference(DateTime.now()) - const Duration(minutes: 2);
    _tokenTimer = Timer(lead.isNegative ? Duration.zero : lead, () async {
      final t = await TokenService.fetchRtcToken(channel: meetingId.value, uid: 0, role: 'publisher');
      // TODO(engine): engine.renewToken(t.token);
      scheduleTokenRenewal(t.expiresAt);
    });
  }

  @override void onClose() { _tokenTimer?.cancel(); rtm.dispose(); stt.dispose(); super.onClose(); }
}
