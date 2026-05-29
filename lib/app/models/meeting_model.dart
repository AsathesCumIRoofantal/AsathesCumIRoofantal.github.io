// ============================================================
//  AIR App – Meeting Model
// ============================================================
enum MeetingStatus { scheduled, live, ended, cancelled }
enum ParticipantRole { host, coHost, participant }

class MeetingParticipant {
  final String          userId;
  final String          name;
  final String?         avatarUrl;
  final ParticipantRole role;
  final bool            isMuted;
  final bool            isCameraOff;
  final bool            isHandRaised;
  final bool            isScreenSharing;
  final int?            agoraUid;

  const MeetingParticipant({
    required this.userId,
    required this.name,
    this.avatarUrl,
    this.role          = ParticipantRole.participant,
    this.isMuted       = false,
    this.isCameraOff   = false,
    this.isHandRaised  = false,
    this.isScreenSharing = false,
    this.agoraUid,
  });
}

class MeetingModel {
  final String               id;
  final String               title;
  final String               hostId;
  final String               hostName;
  final String               channelName;
  final String?              passcode;
  final String?              description;
  final MeetingStatus        status;
  final List<MeetingParticipant> participants;
  final int                  scheduledAt;   // epoch
  final int?                 startedAt;
  final int?                 endedAt;
  final bool                 isRecording;
  final bool                 waitingRoomEnabled;
  final int                  maxParticipants;
  final int                  createdAt;
  final int                  updatedAt;

  const MeetingModel({
    required this.id,
    required this.title,
    required this.hostId,
    required this.hostName,
    required this.channelName,
    this.passcode,
    this.description,
    this.status          = MeetingStatus.scheduled,
    this.participants    = const [],
    required this.scheduledAt,
    this.startedAt,
    this.endedAt,
    this.isRecording     = false,
    this.waitingRoomEnabled = true,
    this.maxParticipants = 100,
    required this.createdAt,
    required this.updatedAt,
  });
}

// ── Dummy Meetings ──────────────────────────────────────────
class DummyMeetings {
  static final List<MeetingModel> meetings = [
    MeetingModel(
      id: 'mtg_001', title: 'Team Standup', hostId: 'usr_001',
      hostName: 'Admin', channelName: 'standup_ch_001',
      status: MeetingStatus.scheduled,
      scheduledAt: DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    ),
    MeetingModel(
      id: 'mtg_002', title: 'Product Review', hostId: 'usr_001',
      hostName: 'Admin', channelName: 'product_review_002',
      status: MeetingStatus.live,
      scheduledAt: DateTime.now().subtract(const Duration(minutes: 10)).millisecondsSinceEpoch,
      startedAt:   DateTime.now().subtract(const Duration(minutes: 10)).millisecondsSinceEpoch,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      participants: [
        MeetingParticipant(userId: 'usr_001', name: 'Admin', role: ParticipantRole.host),
        MeetingParticipant(userId: 'usr_002', name: 'User B', isMuted: true),
        MeetingParticipant(userId: 'usr_003', name: 'User C', isCameraOff: true),
      ],
    ),
  ];
}
