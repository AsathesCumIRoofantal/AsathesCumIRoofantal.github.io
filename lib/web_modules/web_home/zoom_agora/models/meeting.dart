class Meeting {
  final String id;          // 11-digit Zoom-style id
  final String title;
  final String hostUid;
  final DateTime startAt;
  final Duration? duration;
  final String? passcode;
  final bool waitingRoom;
  final bool muteOnEntry;
  final bool recordOnStart;
  final List<String> coHosts;
  final bool isWebinar;
  Meeting({
    required this.id,
    required this.title,
    required this.hostUid,
    required this.startAt,
    this.duration,
    this.passcode,
    this.waitingRoom = true,
    this.muteOnEntry = true,
    this.recordOnStart = false,
    this.coHosts = const [],
    this.isWebinar = false,
  });
  String get shareLink => 'https://meet.example.com/j/$id${passcode!=null?'?pwd=$passcode':''}';
}
