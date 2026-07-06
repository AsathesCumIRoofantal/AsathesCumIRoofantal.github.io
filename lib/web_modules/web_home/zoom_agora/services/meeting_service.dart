import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around the `meetings` / `meeting_participants` tables.
/// Matches the schema exactly: booleans are SMALLINT (0/1), timestamps are
/// BIGINT epoch-seconds (not Postgres `timestamptz`), so every read/write
/// here converts explicitly rather than relying on Dart's `bool`/`DateTime`
/// mapping to just work.
class Meeting {
  final String id;
  final String title;
  final String hostId;
  final String hostName;
  final String channelName;
  final String? passcode;
  final String status; // scheduled | live | ended | cancelled
  final int scheduledAt;

  Meeting({
    required this.id,
    required this.title,
    required this.hostId,
    required this.hostName,
    required this.channelName,
    required this.passcode,
    required this.status,
    required this.scheduledAt,
  });

  factory Meeting.fromRow(Map<String, dynamic> r) => Meeting(
    id: r['id'] as String,
    title: r['title'] as String,
    hostId: r['host_id'] as String,
    hostName: r['host_name'] as String,
    channelName: r['channel_name'] as String,
    passcode: r['passcode'] as String?,
    status: r['status'] as String,
    scheduledAt: (r['scheduled_at'] as num).toInt(),
  );
}

class MeetingService {
  MeetingService({SupabaseClient? client}) : _client = client ?? Supabase.instance.client;
  final SupabaseClient _client;

  static int _nowEpoch() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  static String _generateChannelName() {
    // Zoom-style "xxx-xxxx-xxx" 10-digit id — matches the mock UI's format
    // and is short enough for a human to read aloud/type.
    final rnd = Random.secure();
    String digits(int n) => List.generate(n, (_) => rnd.nextInt(10)).join();
    return '${digits(3)}-${digits(4)}-${digits(3)}';
  }

  /// Creates a meeting row (used by both "instant meeting" and "schedule").
  /// [scheduledAt] defaults to now for instant meetings.
  Future<Meeting> createMeeting({
    required String hostId,
    required String hostName,
    required String title,
    String? passcode,
    DateTime? scheduledAt,
    int maxParticipants = 100,
    bool waitingRoomEnabled = true,
  }) async {
    final channelName = _generateChannelName();
    final row = await _client.from('meetings').insert({
      'title': title,
      'host_id': hostId,
      'host_name': hostName,
      'channel_name': channelName,
      'passcode': passcode,
      'status': 'scheduled',
      'scheduled_at': scheduledAt != null
          ? scheduledAt.millisecondsSinceEpoch ~/ 1000
          : _nowEpoch(),
      'max_participants': maxParticipants,
      'waiting_room_enabled': waitingRoomEnabled ? 1 : 0,
    }).select().single();
    return Meeting.fromRow(row);
  }

  /// Looks a meeting up by its channel_name (what users type as "meeting
  /// ID") OR by row id (for deep links). Returns null if not found,
  /// cancelled, or already ended.
  Future<Meeting?> findJoinable(String channelOrId, {String? passcode}) async {
    final byChannel = await _client
        .from('meetings')
        .select()
        .eq('channel_name', channelOrId)
        .maybeSingle();

    Map<String, dynamic>? row = byChannel;
    if (row == null && _looksLikeUuid(channelOrId)) {
      // Only try the id column if the input is actually UUID-shaped —
      // querying a `uuid` column with an arbitrary typed string (e.g. a
      // mistyped channel id) throws a Postgres error, not a clean "no
      // rows", so we avoid that path entirely otherwise.
      row = await _client.from('meetings').select().eq('id', channelOrId).maybeSingle();
    }
    if (row == null) return null;

    final m = Meeting.fromRow(row);
    if (m.status == 'cancelled' || m.status == 'ended') return null;
    if (m.passcode != null && m.passcode!.isNotEmpty && m.passcode != passcode) {
      throw const MeetingPasscodeException();
    }
    return m;
  }

  static final _uuidRe = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );
  static bool _looksLikeUuid(String s) => _uuidRe.hasMatch(s);

  Future<void> markLive(String meetingId) => _client.from('meetings').update({
    'status': 'live',
    'started_at': _nowEpoch(),
  }).eq('id', meetingId);

  Future<void> markEnded(String meetingId) => _client.from('meetings').update({
    'status': 'ended',
    'ended_at': _nowEpoch(),
  }).eq('id', meetingId);

  /// Upserts the caller's own row in `meeting_participants` on join.
  /// [agoraUid] is reused generically as "the numeric session uid" whether
  /// the call is running on the WebRTC or Agora backend.
  Future<void> upsertParticipant({
    required String meetingId,
    required String userId,
    required String name,
    required int sessionUid,
    String role = 'participant',
  }) => _client.from('meeting_participants').upsert({
    'meeting_id': meetingId,
    'user_id': userId,
    'name': name,
    'role': role,
    'agora_uid': sessionUid,
    'joined_at': _nowEpoch(),
    'left_at': null,
  }, onConflict: 'meeting_id,user_id');

  Future<void> markParticipantLeft({
    required String meetingId,
    required String userId,
  }) => _client.from('meeting_participants').update({
    'left_at': _nowEpoch(),
  }).eq('meeting_id', meetingId).eq('user_id', userId);

  Future<void> updateParticipantState({
    required String meetingId,
    required String userId,
    bool? isMuted,
    bool? isCameraOff,
    bool? isHandRaised,
    bool? isScreenShare,
  }) {
    final patch = <String, dynamic>{};
    if (isMuted != null) patch['is_muted'] = isMuted ? 1 : 0;
    if (isCameraOff != null) patch['is_camera_off'] = isCameraOff ? 1 : 0;
    if (isHandRaised != null) patch['is_hand_raised'] = isHandRaised ? 1 : 0;
    if (isScreenShare != null) patch['is_screen_share'] = isScreenShare ? 1 : 0;
    if (patch.isEmpty) return Future.value();
    return _client
        .from('meeting_participants')
        .update(patch)
        .eq('meeting_id', meetingId)
        .eq('user_id', userId);
  }

  /// Recent meetings this user hosted or attended — powers the "Recent
  /// meetings" list on the join screen (currently hardcoded mock data).
  Future<List<Meeting>> recentFor(String userId, {int limit = 5}) async {
    final rows = await _client
        .from('meetings')
        .select()
        .eq('host_id', userId)
        .order('scheduled_at', ascending: false)
        .limit(limit);
    return (rows as List).map((r) => Meeting.fromRow(r as Map<String, dynamic>)).toList();
  }
}

class MeetingPasscodeException implements Exception {
  const MeetingPasscodeException();
  @override
  String toString() => 'Incorrect passcode';
}
