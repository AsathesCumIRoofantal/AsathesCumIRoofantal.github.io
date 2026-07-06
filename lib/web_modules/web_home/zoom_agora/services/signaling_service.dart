import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase Realtime-based signaling for WebRTC SDP/ICE exchange.
///
/// Why Supabase Realtime instead of a custom WebSocket server:
///  - It's a Broadcast channel: ephemeral pub/sub, nothing is written to
///    Postgres, so no schema change was needed and there's no row growth.
///  - Presence gives us free "who's in the room" tracking (join/leave)
///    without polling `meeting_participants`.
///  - It runs on Supabase's free tier — no separate signaling server to
///    host, patch, or pay for.
///
/// One channel per meeting: `meeting:<channelId>` (matches
/// `meetings.channel_name` in the schema). Every client subscribes to the
/// same channel and filters messages addressed to it via the `to` field.
class SignalingService {
  SignalingService({
    required this.roomId,
    required this.localPeerId,
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  /// The meeting's channel_name (see `meetings` table).
  final String roomId;

  /// Stable id for this participant's session — we use `uid.toString()`.
  final String localPeerId;

  final SupabaseClient _client;
  RealtimeChannel? _channel;

  bool _connected = false;
  bool get isConnected => _connected;

  // ── Event streams (same public surface as before) ───────────────────────

  final _offerCtrl =
      StreamController<(String peerId, Map<String, dynamic> sdp)>.broadcast();
  final _answerCtrl =
      StreamController<(String peerId, Map<String, dynamic> sdp)>.broadcast();
  final _candidateCtrl =
      StreamController<
        (String peerId, Map<String, dynamic> candidate)
      >.broadcast();
  final _peerJoinedCtrl = StreamController<String>.broadcast();
  final _peerLeftCtrl = StreamController<String>.broadcast();

  Stream<(String, Map<String, dynamic>)> get onOffer => _offerCtrl.stream;
  Stream<(String, Map<String, dynamic>)> get onAnswer => _answerCtrl.stream;
  Stream<(String, Map<String, dynamic>)> get onCandidate =>
      _candidateCtrl.stream;

  /// Fires once for every peer currently in (or joining) the room —
  /// including peers who were already present before we subscribed.
  /// (Supabase Presence replays existing members as "join" events to a
  /// freshly-subscribed client, so this single stream covers both cases.)
  Stream<String> get onPeerJoined => _peerJoinedCtrl.stream;
  Stream<String> get onPeerLeft => _peerLeftCtrl.stream;

  // ── Connect ───────────────────────────────────────────────────────────

  Future<void> connect() async {
    if (_connected) return;
    final completer = Completer<void>();

    _channel = _client.channel(
      'meeting:$roomId',
      opts: const RealtimeChannelConfig(self: false),
    );

    _channel!
      ..onBroadcast(event: 'signal', callback: _handleSignal)
      ..onPresenceJoin(_handlePresenceJoin)
      ..onPresenceLeave(_handlePresenceLeave)
      ..subscribe((status, error) async {
        if (status == RealtimeSubscribeStatus.subscribed) {
          await _channel!.track({
            'peer_id': localPeerId,
            'joined_at': DateTime.now().toIso8601String(),
          });
          _connected = true;
          if (!completer.isCompleted) completer.complete();
        } else if (status == RealtimeSubscribeStatus.channelError ||
            status == RealtimeSubscribeStatus.timedOut) {
          if (!completer.isCompleted) {
            completer.completeError(error ?? Exception('Signaling channel failed to subscribe'));
          }
        }
      });

    return completer.future;
  }

  void _handlePresenceJoin(RealtimePresenceJoinPayload payload) {
    for (final p in payload.newPresences) {
      final peerId = p.payload['peer_id'] as String?;
      if (peerId == null || peerId == localPeerId) continue;
      _peerJoinedCtrl.add(peerId);
    }
  }

  void _handlePresenceLeave(RealtimePresenceLeavePayload payload) {
    for (final p in payload.leftPresences) {
      final peerId = p.payload['peer_id'] as String?;
      if (peerId == null || peerId == localPeerId) continue;
      _peerLeftCtrl.add(peerId);
    }
  }

  // ── Send ──────────────────────────────────────────────────────────────

  Future<void> sendOffer(String peerId, Map<String, dynamic> sdp) =>
      _send({'type': 'offer', 'to': peerId, 'from': localPeerId, 'sdp': sdp});

  Future<void> sendAnswer(String peerId, Map<String, dynamic> sdp) =>
      _send({'type': 'answer', 'to': peerId, 'from': localPeerId, 'sdp': sdp});

  Future<void> sendCandidate(String peerId, Map<String, dynamic> candidate) =>
      _send({
        'type': 'candidate',
        'to': peerId,
        'from': localPeerId,
        'candidate': candidate,
      });

  Future<void> _send(Map<String, dynamic> msg) async {
    if (!_connected || _channel == null) return;
    await _channel!.sendBroadcastMessage(event: 'signal', payload: msg);
  }

  // ── Receive ───────────────────────────────────────────────────────────

  void _handleSignal(Map<String, dynamic> payload, [dynamic _]) {
    final to = payload['to'] as String?;
    if (to != null && to != localPeerId) return; // not addressed to us
    final from = payload['from'] as String? ?? '';
    if (from.isEmpty || from == localPeerId) return;

    switch (payload['type'] as String?) {
      case 'offer':
        _offerCtrl.add((from, Map<String, dynamic>.from(payload['sdp'] as Map)));
        break;
      case 'answer':
        _answerCtrl.add((from, Map<String, dynamic>.from(payload['sdp'] as Map)));
        break;
      case 'candidate':
        _candidateCtrl.add((from, Map<String, dynamic>.from(payload['candidate'] as Map)));
        break;
    }
  }

  // ── Dispose ───────────────────────────────────────────────────────────

  Future<void> dispose() async {
    _connected = false;
    if (_channel != null) {
      await _client.removeChannel(_channel!);
      _channel = null;
    }
    await _offerCtrl.close();
    await _answerCtrl.close();
    await _candidateCtrl.close();
    await _peerJoinedCtrl.close();
    await _peerLeftCtrl.close();
  }
}
