import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import '../models/participant.dart';
import '../models/chat_message.dart';
import '../models/poll.dart';
import '../models/qa_item.dart';
import '../models/breakout_room.dart';
import '../in_meeting/zoom_meeting_controller.dart';

/// Seeds the meeting with realistic dummy users + drives a lightweight
/// simulation (chat, reactions, captions, network jitter, active speaker)
/// so the UI behaves as if it were live-deployed without any real backend.
class MockMeetingSim {
  MockMeetingSim(this.c);
  final ZoomMeetingController c;
  final _rng = Random();
  Timer? _tick;

  static const _names = <(String,String)>[
    ('Ava Chen','AC'),('Marcus Johnson','MJ'),('Priya Patel','PP'),
    ('Diego Romero','DR'),('Sara Khan','SK'),('Liam O\'Brien','LO'),
    ('Yuki Tanaka','YT'),('Noah Williams','NW'),('Zara Ahmed','ZA'),
    ('Olivia Smith','OS'),
  ];
  static const _palette = <int>[
    0xFFEF4444,0xFFF59E0B,0xFF10B981,0xFF06B6D4,0xFF3B82F6,
    0xFF8B5CF6,0xFFEC4899,0xFFF97316,0xFF14B8A6,0xFF6366F1,
  ];
  static int colorFor(int uid) => _palette[uid.abs() % _palette.length];
  static String initialsFor(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, parts.first.length.clamp(0,2)).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  void seed() {
    c.meetingId.value = '824-731-9056';
    c.participants[0] = Participant(uid:0, name:'You', role: ParticipantRole.host);
    for (var i=0;i<_names.length;i++) {
      final uid = 1001+i;
      c.participants[uid] = Participant(
        uid: uid, name: _names[i].$1,
        role: i==0?ParticipantRole.coHost:(i<3?ParticipantRole.panelist:ParticipantRole.attendee),
        audioMuted: i%3==0, videoOff: i%4==0,
        handRaised: i==2, networkQuality: 4+(i%3),
      );
    }
    c.activeSpeakerUid.value = 1002;
    c.waiting.addAll([
      Participant(uid:9001, name:'Guest · iPhone'),
      Participant(uid:9002, name:'Anonymous Bear'),
    ]);
    final t0 = DateTime.now().subtract(const Duration(minutes:6));
    c.chat.addAll([
      ChatMessage(id:'m1', fromUid:1001, fromName:'Ava Chen', text:'Morning everyone 👋', sentAt:t0),
      ChatMessage(id:'m2', fromUid:1003, fromName:'Priya Patel', text:'Slides are in the drive — link below.', sentAt:t0.add(const Duration(minutes:1))),
      ChatMessage(id:'m3', fromUid:1002, fromName:'Marcus Johnson', text:'Can everyone see my screen share?', sentAt:t0.add(const Duration(minutes:3))),
      ChatMessage(id:'m4', fromUid:1005, fromName:'Sara Khan', text:'Looks great. 🎉', sentAt:t0.add(const Duration(minutes:4))),
    ]);
    c.qa.addAll([
      QAItem(id:'q1', fromUid:1004, fromName:'Diego Romero', question:'Will the recording be shared with the wider team?', upvotes:{1001,1003,1005}),
      QAItem(id:'q2', fromUid:1006, fromName:'Liam O\'Brien', question:'What\'s the timeline for the Q3 milestone?', upvotes:{1002}),
    ]);
    c.polls.add(Poll(
      id:'poll-demo',
      question:'Which release theme should we prioritise next sprint?',
      type: PollType.single, launched:true,
      options:[
        PollOption('a','Performance & polish',6),
        PollOption('b','New onboarding flow',4),
        PollOption('c','Integrations',2),
      ],
    ));
    c.breakouts.addAll([
      BreakoutRoom(id:'b1', name:'Design',       participants:[1001,1005,1009]),
      BreakoutRoom(id:'b2', name:'Engineering',  participants:[1002,1004,1007]),
      BreakoutRoom(id:'b3', name:'Go-to-market', participants:[1003,1006,1008]),
    ]);
    c.stats.cpuAppPct.value = 14; c.stats.cpuTotalPct.value = 38;
    c.stats.txKbps.value = 820;  c.stats.rxKbps.value = 1640;
    c.stats.jitterMs.value = 12; c.stats.packetLossPct.value = 0.3;
    c.stats.lastResolution.value = '1280x720@30';
    c.stats.codec.value = 'H264 · SVC';
    c.liveCaption.value = 'So if we look at the dashboard, the throughput improved by roughly twelve percent.';
  }

  void start() {
    _tick ??= Timer.periodic(const Duration(seconds:3), (_) {
      final uids = c.participants.keys.where((u)=>u!=0).toList();
      if (uids.isEmpty) return;
      c.activeSpeakerUid.value = uids[_rng.nextInt(uids.length)];
      for (final p in c.participants.values) {
        p.isSpeaking = p.uid == c.activeSpeakerUid.value && !p.audioMuted;
      }
      c.participants.refresh();
      if (_rng.nextDouble() < 0.45) {
        const emojis = ['👏','❤️','🎉','😂','👍','🙋'];
        c.react(uids[_rng.nextInt(uids.length)], emojis[_rng.nextInt(emojis.length)]);
      }
      if (_rng.nextDouble() < 0.25) {
        const lines = ['Agreed 👍','Could you share that link again?','Recording started.','Joining from mobile, hi all!','+1 to that idea','I have a follow-up question.'];
        final uid = uids[_rng.nextInt(uids.length)];
        final p = c.participants[uid]!;
        c.chat.add(ChatMessage(id:'sim-${DateTime.now().microsecondsSinceEpoch}',
          fromUid:uid, fromName:p.name, text:lines[_rng.nextInt(lines.length)], sentAt: DateTime.now()));
      }
      c.stats.jitterMs.value = 8 + _rng.nextInt(20);
      c.stats.packetLossPct.value = _rng.nextDouble() * 1.5;
      c.stats.txKbps.value = 700 + _rng.nextInt(400);
      c.stats.rxKbps.value = 1400 + _rng.nextInt(600);
    });
  }

  void stop() { _tick?.cancel(); _tick = null; }
}
