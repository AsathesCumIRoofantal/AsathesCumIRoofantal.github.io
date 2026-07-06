import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/participant.dart';
import '../models/chat_message.dart';
import '../models/poll.dart';
import '../models/breakout_room.dart';
import '../models/qa_item.dart';
import '../models/whiteboard_stroke.dart';
import '../zoom_routes.dart';
import '../models/rtc_config.dart';
import '../services/rtc_backend_manager.dart';
import '../services/rtc_engine_interface.dart';
import '../services/remote_control_service.dart';
import '../services/recording_service.dart';
import '../services/stt_service.dart';
import '../services/stats_service.dart';
import '../services/whiteboard_service.dart';
import '../services/token_service.dart';
import '../services/meeting_service.dart';
import '../services/current_user.dart';

/// Layer on top of the RTC engine (Agora or WebRTC, via
/// [RtcBackendManager]). Holds every Zoom-parity state piece. When
/// [connectToLiveMeeting] is called, participants/mute-state/screen-share
/// reflect real [RtcEngineInterface] events instead of the mock simulator.
class ZoomMeetingController extends GetxController {
  // ── services ───────────────────────────────────────────────────────────
  final recording  = RecordingService();
  final stt        = SttService();
  final stats      = StatsService();
  final whiteboard = WhiteboardService();

  // ── live RTC wiring ────────────────────────────────────────────────────
  RtcEngineInterface? engine;
  RemoteControlService? remoteControl;
  int localUid = 0;
  String localName = 'Me';
  String? _meetingRowId; // `meetings.id` — null until connectToLiveMeeting
  String? _mainChannelId; // the top-level meeting channel, for returning from breakouts
  final _meetingService = MeetingService();
  StreamSubscription<RtcEvent>? _engineSub;
  bool get isLive => engine != null;

  /// Call this from the meeting binding once a real [RtcBackendManager] is
  /// available. Joins the channel, then keeps [participants] / mute state /
  /// screen-share in sync with real engine events for the rest of the call.
  /// [meetingRowId] is the `meetings.id` row created by the schedule/join/
  /// instant flow — pass it so this participant's presence is recorded in
  /// `meeting_participants` too, not just over the RTC data channel.
  Future<void> connectToLiveMeeting({
    required RtcBackendManager backendManager,
    required RtcConfig config,
    required String name,
    String? meetingRowId,
    bool joinMuted = false,
    bool joinVideoOff = false,
  }) async {
    localUid = config.uid;
    localName = name;
    meetingId.value = config.channelId;
    _mainChannelId = config.channelId;
    _meetingRowId = meetingRowId;

    engine = backendManager.engine;
    remoteControl = RemoteControlService(engine!)..start();

    _engineSub = engine!.events.listen(_onEngineEvent);

    participants[localUid] = Participant(
      uid: localUid,
      name: name,
      role: ParticipantRole.host,
      audioMuted: joinMuted,
      videoOff: joinVideoOff,
    );

    await engine!.joinChannel(
      channelId: config.channelId,
      token: config.token,
      uid: config.uid,
    );

    // Respect whatever the device-preview screen's mic/camera toggles were
    // set to — previously ignored, so joining always turned both on
    // regardless of what was shown before entering the call.
    if (joinMuted) await engine!.muteLocalAudio(true);
    if (joinVideoOff) await engine!.muteLocalVideo(true);

    if (_meetingRowId != null && CurrentUser.isSignedIn) {
      try {
        await _meetingService.upsertParticipant(
          meetingId: _meetingRowId!,
          userId: CurrentUser.id,
          name: name,
          sessionUid: localUid,
        );
      } catch (_) {
        // Non-fatal — the call itself works over RTC either way; this just
        // means the participant-history row didn't get written.
      }
    }

    // Announce our display name to peers already/about-to-be in the room —
    // the engine only knows numeric uids, names travel over the data
    // channel exactly like chat/control messages do.
    await _broadcastName();
  }

  Future<void> _broadcastName() async {
    if (engine == null) return;
    final payload = jsonEncode({'_name': true, 'uid': localUid, 'name': localName});
    await engine!.sendDataMessage(Uint8List.fromList(utf8.encode(payload)));
  }

  void _onEngineEvent(RtcEvent e) {
    switch (e.type) {
      case RtcEventType.userJoined:
        if (e.uid == null) return;
        participants.putIfAbsent(
          e.uid!,
          () => Participant(uid: e.uid!, name: 'Participant ${e.uid}'),
        );
        // Re-send our name whenever someone new joins so they see us too.
        _broadcastName();
        break;
      case RtcEventType.userLeft:
        if (e.uid != null) participants.remove(e.uid);
        break;
      case RtcEventType.userMuteAudio:
        if (e.uid != null) participants[e.uid]?.audioMuted = e.data['muted'] == true;
        participants.refresh();
        break;
      case RtcEventType.userMuteVideo:
        if (e.uid != null) participants[e.uid]?.videoOff = e.data['muted'] == true;
        participants.refresh();
        break;
      case RtcEventType.screenShareStarted:
        final uid = e.uid ?? localUid;
        for (final p in participants.values) { p.isScreenSharing = false; }
        participants[uid]?.isScreenSharing = true;
        participants.refresh();
        break;
      case RtcEventType.screenShareStopped:
        final uid = e.uid ?? localUid;
        participants[uid]?.isScreenSharing = false;
        participants.refresh();
        break;
      case RtcEventType.connectionStateChanged:
        connection.value = (e.data['state']?.toString().contains('Failed') ?? false)
            ? 'reconnecting' : 'connected';
        break;
      case RtcEventType.statsUpdated:
        _applyStats(e.data);
        break;
      case RtcEventType.dataMessageReceived:
        _handleAppData(e);
        break;
      default:
        break;
    }
  }

  int? _lastTxBytes, _lastRxBytes;
  DateTime? _lastStatsAt;

  /// Converts the engine's cumulative byte counters into the kbps figures
  /// the stats panel actually displays, since the raw event only reports
  /// running totals (simpler for the engine to compute, cheaper to emit).
  void _applyStats(Map<String, dynamic> data) {
    final now = DateTime.now();
    final tx = data['txBytesTotal'] as int? ?? 0;
    final rx = data['rxBytesTotal'] as int? ?? 0;

    if (_lastStatsAt != null && _lastTxBytes != null && _lastRxBytes != null) {
      final seconds = now.difference(_lastStatsAt!).inMilliseconds / 1000.0;
      if (seconds > 0) {
        stats.txKbps.value = (((tx - _lastTxBytes!) * 8 / 1000) / seconds).round();
        stats.rxKbps.value = (((rx - _lastRxBytes!) * 8 / 1000) / seconds).round();
      }
    }
    _lastTxBytes = tx;
    _lastRxBytes = rx;
    _lastStatsAt = now;

    stats.packetLossPct.value = (data['packetLossPct'] as num?)?.toDouble() ?? 0.0;
    stats.lastResolution.value = data['resolution'] as String? ?? stats.lastResolution.value;
    stats.codec.value = data['codec'] as String? ?? stats.codec.value;
  }

  void _handleAppData(RtcEvent e) {
    final bytes = e.data['bytes'] as Uint8List?;
    if (bytes == null) return;
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map) return;
      if (decoded['_name'] == true) {
        final uid = decoded['uid'] as int?;
        final name = decoded['name'] as String?;
        if (uid == null || name == null) return;
        final existing = participants[uid];
        if (existing != null) {
          existing.name = name;
        } else {
          participants[uid] = Participant(uid: uid, name: name);
        }
        participants.refresh();
        return;
      }
      if (decoded['_app'] == true) {
        _handleAppEnvelope(
          decoded['kind'] as String?,
          decoded['payload'] is Map ? Map<String, dynamic>.from(decoded['payload'] as Map) : null,
        );
      }
    } catch (_) {
      // Not JSON for us (e.g. a remote-control byte packet) — ignore;
      // RemoteControlService has its own listener on the same stream.
    }
  }

  /// Every synced feature (chat, reactions, hand-raise, typing, polls,
  /// Q&A, whiteboard) rides this one data channel behind a `kind` tag —
  /// no extra signaling infrastructure needed beyond what's already
  /// wired for remote control and name announcement.
  Future<void> _sendApp(String kind, Map<String, dynamic> payload) async {
    if (engine == null) return; // demo mode — nothing to sync to
    final msg = jsonEncode({'_app': true, 'kind': kind, 'payload': payload});
    await engine!.sendDataMessage(Uint8List.fromList(utf8.encode(msg)));
  }

  /// Same envelope, but to exactly one peer — used for breakout-room
  /// assignment, where only the assigned participant should act on it.
  Future<void> _sendAppTo(int uid, String kind, Map<String, dynamic> payload) async {
    if (engine == null) return;
    final msg = jsonEncode({'_app': true, 'kind': kind, 'payload': payload});
    await engine!.sendDataMessageTo(uid, Uint8List.fromList(utf8.encode(msg)));
  }

  void _handleAppEnvelope(String? kind, Map<String, dynamic>? payload) {
    if (kind == null || payload == null) return;
    switch (kind) {
      case 'chat':
        chat.add(ChatMessage.fromJson(payload));
        break;
      case 'reaction':
        react(payload['uid'] as int, payload['emoji'] as String, broadcast: false);
        break;
      case 'hand':
        final uid = payload['uid'] as int;
        participants[uid]?.handRaised = payload['raised'] as bool;
        participants.refresh();
        break;
      case 'typing':
        final uid = payload['uid'] as int;
        typing.add(uid);
        Future.delayed(const Duration(seconds: 3), () => typing.remove(uid));
        break;
      case 'wb_stroke':
        whiteboardStrokes.add(WhiteboardStroke.fromJson(payload));
        break;
      case 'wb_clear':
        whiteboardStrokes.clear();
        break;
      case 'poll_launch':
        polls.add(Poll.fromJson(payload));
        break;
      case 'poll_close':
        closePoll(payload['id'] as String, broadcast: false);
        break;
      case 'poll_answer':
        answerPoll(
          payload['pollId'] as String,
          payload['uid'] as int,
          List<String>.from(payload['answer'] as List),
          broadcast: false,
        );
        break;
      case 'qa_submit':
        qa.insert(0, QAItem.fromJson(payload));
        break;
      case 'qa_answer':
        answerQuestion(payload['id'] as String, payload['text'] as String, broadcast: false);
        break;
      case 'qa_upvote':
        toggleUpvoteQuestion(payload['id'] as String, broadcast: false);
        break;
      case 'caption':
        final uid = payload['uid'] as int;
        final text = payload['text'] as String? ?? '';
        final speaker = uid == localUid ? localName : (participants[uid]?.name ?? 'Someone');
        liveCaption.value = '$speaker: $text';
        if (payload['final'] == true && text.trim().isNotEmpty) {
          transcript.add('$speaker: $text');
        }
        break;
      case 'breakout_assign':
        final channelId = payload['channelId'] as String?;
        final roomId = payload['roomId'] as String?;
        if (channelId != null && roomId != null) _joinBreakoutChannel(channelId, roomId);
        break;
      case 'breakout_end':
        _returnToMainRoom();
        break;
      case 'kick':
        Get.snackbar('Removed', 'The host removed you from the meeting.');
        leaveLiveMeeting().then((_) => Get.offAllNamed(ZoomRoutes.home));
        break;
    }
  }

  /// Flips the local mic. Safe to call in demo mode too — with no [engine]
  /// attached, this just flips the local flag like the mock sim always did.
  Future<void> toggleLocalAudio() async {
    final me = participants[localUid];
    final newMuted = !(me?.audioMuted ?? false);
    me?.audioMuted = newMuted;
    participants.refresh();
    await engine?.muteLocalAudio(newMuted);
  }

  Future<void> toggleLocalVideo() async {
    final me = participants[localUid];
    final newOff = !(me?.videoOff ?? false);
    me?.videoOff = newOff;
    participants.refresh();
    await engine?.muteLocalVideo(newOff);
  }

  /// Starts/stops screen share via the engine. [participants]' isScreenSharing
  /// flag updates itself from the resulting engine event, not from here.
  Future<void> toggleScreenShare() async {
    final sharing = participants[localUid]?.isScreenSharing ?? false;
    if (engine == null) {
      // Demo mode: no engine to drive the track swap — just flip the flag.
      participants[localUid]?.isScreenSharing = !sharing;
      for (final p in participants.values) {
        if (p.uid != localUid) p.isScreenSharing = false;
      }
      participants.refresh();
      return;
    }
    if (sharing) {
      await engine!.stopScreenShare();
    } else {
      await engine!.startScreenShare();
    }
  }

  Future<void> leaveLiveMeeting() async {
    if (_meetingRowId != null && CurrentUser.isSignedIn) {
      try {
        await _meetingService.markParticipantLeft(
          meetingId: _meetingRowId!,
          userId: CurrentUser.id,
        );
        if (participants[localUid]?.role == ParticipantRole.host) {
          await _meetingService.markEnded(_meetingRowId!);
        }
      } catch (_) {
        // Non-fatal — don't block leaving the call on a DB write failing.
      }
    }
    await _engineSub?.cancel();
    remoteControl?.dispose();
    await engine?.leaveChannel();
  }

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
  void react(int uid, String emoji, {bool broadcast = true}) {
    floatingReactions.add((uid, emoji, DateTime.now().millisecondsSinceEpoch));
    Future.delayed(const Duration(seconds: 10), () {
      floatingReactions.removeWhere((r)=>r.$3 < DateTime.now().millisecondsSinceEpoch-9500);
    });
    if (broadcast) _sendApp('reaction', {'uid': uid, 'emoji': emoji});
  }

  /// Toggles the local user's raised-hand state and lets everyone else
  /// know — there's no host-side mic to hold in a mesh call, so "raise
  /// hand" is purely a signal, same as it is in Zoom itself.
  Future<void> toggleHandRaise() async {
    final me = participants[localUid];
    if (me == null) return;
    me.handRaised = !me.handRaised;
    participants.refresh();
    await _sendApp('hand', {'uid': localUid, 'raised': me.handRaised});
  }

  DateTime _lastTypingSent = DateTime.fromMillisecondsSinceEpoch(0);
  /// Call on every keystroke in the chat composer — throttled so it
  /// doesn't spam the data channel on every character.
  Future<void> notifyTyping() async {
    final now = DateTime.now();
    if (now.difference(_lastTypingSent) < const Duration(seconds: 2)) return;
    _lastTypingSent = now;
    await _sendApp('typing', {'uid': localUid});
  }

  /// Builds the message, adds it locally, and broadcasts it — chat used
  /// to just add to the local list and call a no-op RTM stub, which
  /// meant remote participants never actually saw it.
  Future<void> sendChatMessage(String text, {ChatScope scope = ChatScope.everyone}) async {
    if (text.trim().isEmpty) return;
    final m = ChatMessage(
      id: '${localUid}_${DateTime.now().microsecondsSinceEpoch}',
      fromUid: localUid,
      fromName: localName,
      text: text.trim(),
      sentAt: DateTime.now(),
      scope: scope,
    );
    chat.add(m);
    await _sendApp('chat', m.toJson());
  }

  // ── whiteboard ───────────────────────────────────────────────────────
  final whiteboardStrokes = <WhiteboardStroke>[].obs;
  void addWhiteboardStroke(WhiteboardStroke s, {bool broadcast = true}) {
    whiteboardStrokes.add(s);
    if (broadcast) _sendApp('wb_stroke', s.toJson());
  }
  void clearWhiteboard({bool broadcast = true}) {
    whiteboardStrokes.clear();
    if (broadcast) _sendApp('wb_clear', {});
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
    if (engine == null) return;
    // Mesh has no server sitting on anyone's mic, so "mute all" is really
    // "ask everyone else to mute themselves" — each remote client's own
    // engine instance receives this and calls muteLocalAudio on itself.
    for (final uid in participants.keys) {
      if (uid == localUid) {
        await engine!.muteLocalAudio(true);
      } else {
        await engine!.muteRemoteAudio(uid, true);
      }
    }
  }
  Future<void> lockMeeting(bool v) async => isLocked.value = v;
  Future<void> admit(int uid) async {
    final p = waiting.firstWhereOrNull((p)=>p.uid==uid); if (p==null) return;
    waiting.remove(p); participants[uid]=p;
  }
  Future<void> denyAll() async => waiting.clear();
  Future<void> removeParticipant(int uid) async {
    participants.remove(uid);
    if (uid == localUid || engine == null) return;
    // Same honest constraint as muteRemoteAudio: nothing sits between
    // peers in a mesh call, so "remove" is a request the target's own
    // device acts on — not something the host can force from outside.
    await _sendAppTo(uid, 'kick', {});
  }
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
  StreamSubscription? _captionSub;
  Future<void> toggleCaptions() async {
    captionsOn.toggle();
    if (captionsOn.value) {
      await stt.start(channel: meetingId.value, uid: localUid);
      _captionSub = stt.onCaption.listen((e) {
        final speaker = e.uid == localUid ? localName : (participants[e.uid]?.name ?? 'Someone');
        liveCaption.value = '$speaker: ${e.text}';
        if (e.isFinal && e.text.trim().isNotEmpty) {
          transcript.add('$speaker: ${e.text}');
        }
        // Broadcast so everyone else who has captions on sees this too —
        // on-device STT can only hear this device's own mic (see
        // SttService's doc comment), so this is what makes captions
        // show up for the *other* participants at all.
        _sendApp('caption', {'uid': e.uid, 'text': e.text, 'final': e.isFinal});
      });
    } else {
      await stt.stop();
      await _captionSub?.cancel();
      _captionSub = null;
    }
  }
  Future<String> generateSummary() => stt.summarize(transcript);

  // ── breakouts ─────────────────────────────────────────────────────────
  // Each breakout room IS a separate mesh WebRTC channel — there's no
  // media server to "sub-room" people on, so moving someone to a
  // breakout means their device actually leaves the main channel and
  // joins `<mainChannelId>_br<N>`, then rejoins the main channel when
  // the breakout closes. The host assigns rooms and tells each
  // participant which one directly (data channel, addressed to just
  // that uid) — only the assigned device acts on it.
  final currentBreakoutRoomId = RxnString();

  void createBreakouts(int count, {bool auto=true}) {
    breakouts.clear();
    for (var i=0;i<count;i++) breakouts.add(BreakoutRoom(id:'br$i', name:'Room ${i+1}'));
    if (auto) {
      final uids = participants.keys.toList()..shuffle();
      for (var i=0;i<uids.length;i++) breakouts[i%count].participants.add(uids[i]);
      _dispatchBreakoutAssignments();
    }
    breakouts.refresh();
  }

  /// Call after manually dragging participants into rooms in the UI
  /// (auto-assign already calls this itself).
  void dispatchBreakoutAssignments() => _dispatchBreakoutAssignments();

  void _dispatchBreakoutAssignments() {
    if (_mainChannelId == null) return;
    for (final room in breakouts) {
      final roomChannelId = '${_mainChannelId}_${room.id}';
      for (final uid in room.participants) {
        if (uid == localUid) {
          _joinBreakoutChannel(roomChannelId, room.id);
        } else {
          _sendAppTo(uid, 'breakout_assign', {'channelId': roomChannelId, 'roomId': room.id});
        }
      }
    }
  }

  Future<void> _joinBreakoutChannel(String channelId, String roomId) async {
    if (engine == null) return;
    currentBreakoutRoomId.value = roomId;
    await engine!.leaveChannel();
    participants.clear();
    participants[localUid] = Participant(uid: localUid, name: localName, role: ParticipantRole.attendee);
    meetingId.value = channelId;
    await engine!.joinChannel(channelId: channelId, token: '', uid: localUid);
    await _broadcastName();
  }

  /// Broadcasts a "come back to the main room" message to everyone
  /// currently assigned to a breakout, then moves the local device back
  /// too if it's the one that's in a breakout right now.
  void closeBreakouts({Duration warning = const Duration(seconds:60)}) {
    for (final room in breakouts) {
      for (final uid in room.participants) {
        if (uid != localUid) _sendAppTo(uid, 'breakout_end', {});
      }
    }
    Future.delayed(warning, () async {
      if (currentBreakoutRoomId.value != null) await _returnToMainRoom();
      breakouts.clear();
    });
  }

  Future<void> _returnToMainRoom() async {
    if (engine == null || _mainChannelId == null) return;
    currentBreakoutRoomId.value = null;
    await engine!.leaveChannel();
    participants.clear();
    participants[localUid] = Participant(uid: localUid, name: localName, role: ParticipantRole.attendee);
    meetingId.value = _mainChannelId!;
    await engine!.joinChannel(channelId: _mainChannelId!, token: '', uid: localUid);
    await _broadcastName();
  }

  /// Host-to-everyone-in-breakouts announcement. Real send to each
  /// breakout channel isn't wired yet — the host's own engine can only
  /// be joined to one channel at a time (same as everyone else), so a
  /// true instant cross-channel broadcast needs either the host briefly
  /// hopping into each breakout channel or a lightweight side-channel
  /// alongside the WebRTC signaling. Flagging rather than faking it.
  void broadcastToBreakouts(String text) {
    debugPrint('broadcastToBreakouts: not wired yet — see the comment above this method.');
  }

  // ── polls / qa ────────────────────────────────────────────────────────
  void launchPoll(Poll p) {
    p.launched = true;
    polls.add(p);
    _sendApp('poll_launch', p.toJson());
  }
  void closePoll(String id, {bool broadcast = true}) {
    polls.firstWhereOrNull((p)=>p.id==id)?.closed=true;
    polls.refresh();
    if (broadcast) _sendApp('poll_close', {'id': id});
  }
  void answerPoll(String pollId, int uid, List<String> answer, {bool broadcast = true}) {
    final poll = polls.firstWhereOrNull((p)=>p.id==pollId);
    if (poll == null) return;
    poll.answers[uid] = answer;
    _recomputePollVotes(poll);
    polls.refresh();
    if (broadcast) _sendApp('poll_answer', {'pollId': pollId, 'uid': uid, 'answer': answer});
  }
  void _recomputePollVotes(Poll poll) {
    for (final o in poll.options) { o.votes = 0; }
    for (final answer in poll.answers.values) {
      for (final optId in answer) {
        poll.options.firstWhereOrNull((o) => o.id == optId)?.votes++;
      }
    }
  }
  void submitQuestion(QAItem q) {
    qa.insert(0,q);
    _sendApp('qa_submit', q.toJson());
  }
  void answerQuestion(String id, String text, {bool broadcast = true}) {
    qa.firstWhereOrNull((q)=>q.id==id)?.answerText = text;
    qa.refresh();
    if (broadcast) _sendApp('qa_answer', {'id': id, 'text': text});
  }
  void toggleUpvoteQuestion(String id, {bool broadcast = true}) {
    final q = qa.firstWhereOrNull((q)=>q.id==id);
    if (q == null) return;
    if (!q.upvotes.add(localUid)) q.upvotes.remove(localUid); // toggle off if already upvoted
    qa.refresh();
    if (broadcast) _sendApp('qa_upvote', {'id': id, 'uid': localUid});
  }

  // ── token renewal ─────────────────────────────────────────────────────
  // Agora-only concern (Agora channel tokens expire and need refreshing).
  // Never called on the WebRTC path — Supabase Realtime channels used for
  // signaling don't expire the same way — so this is dormant unless you
  // switch RtcConfig.backend back to RtcBackend.agora.
  Timer? _tokenTimer;
  void scheduleTokenRenewal(DateTime expiresAt) {
    _tokenTimer?.cancel();
    final lead = expiresAt.difference(DateTime.now()) - const Duration(minutes: 2);
    _tokenTimer = Timer(lead.isNegative ? Duration.zero : lead, () async {
      final t = await TokenService.fetchRtcToken(channel: meetingId.value, uid: 0, role: 'publisher');
      // Agora-only: engine.renewToken(t.token) on the Agora engine impl.
      scheduleTokenRenewal(t.expiresAt);
    });
  }

  @override void onClose() {
    _tokenTimer?.cancel();
    _captionSub?.cancel();
    if (engine?.isJoined ?? false) {
      // Fire-and-forget: controller is being torn down (backgrounded/popped
      // without pressing Leave) — still try to record departure & free the
      // camera/mic instead of leaving a stale "in meeting" row behind.
      leaveLiveMeeting();
    } else {
      _engineSub?.cancel();
      remoteControl?.dispose();
    }
    stt.dispose();
    super.onClose();
  }
}
