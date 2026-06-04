enum ParticipantRole { host, coHost, panelist, attendee }
enum PresenceStatus { available, inMeeting, dnd, away }

class Participant {
  final int uid;
  String name;
  String? avatarUrl;
  ParticipantRole role;
  bool audioMuted;
  bool videoOff;
  bool handRaised;
  bool isSpeaking;
  bool isPinned;
  bool isSpotlighted;
  int networkQuality; // 0..6, see Agora QualityType
  String? breakoutRoomId;
  String? reaction; // emoji currently displayed
  PresenceStatus presence;

  Participant({
    required this.uid,
    required this.name,
    this.avatarUrl,
    this.role = ParticipantRole.attendee,
    this.audioMuted = false,
    this.videoOff = false,
    this.handRaised = false,
    this.isSpeaking = false,
    this.isPinned = false,
    this.isSpotlighted = false,
    this.networkQuality = 5,
    this.breakoutRoomId,
    this.reaction,
    this.presence = PresenceStatus.inMeeting,
  });
}
