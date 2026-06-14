import 'dart:async';
import 'dart:convert';

/// Stub WebSocket-based signaling service for WebRTC SDP/ICE exchange.
/// Replace the endpoint with your own signaling server (Firebase, Socket.io, etc.).
class SignalingService {
  final String serverUrl;
  final String roomId;

  SignalingService({required this.serverUrl, required this.roomId});

  // ── Event streams ─────────────────────────────────────────────────────

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
  Stream<String> get onPeerJoined => _peerJoinedCtrl.stream;
  Stream<String> get onPeerLeft => _peerLeftCtrl.stream;

  bool _connected = false;
  bool get isConnected => _connected;

  // ── Connect ───────────────────────────────────────────────────────────

  /// Opens a WebSocket connection to the signaling server.
  /// TODO(backend): Replace with your actual WebSocket / Firebase Realtime DB connection.
  Future<void> connect() async {
    // Simulated connection for now — replace with:
    // _ws = await WebSocket.connect('$serverUrl/ws?room=$roomId');
    // _ws.listen(_onMessage);
    _connected = true;
  }

  // ── Send ──────────────────────────────────────────────────────────────

  Future<void> sendOffer(String peerId, Map<String, dynamic> sdp) async {
    _send({'type': 'offer', 'to': peerId, 'sdp': sdp});
  }

  Future<void> sendAnswer(String peerId, Map<String, dynamic> sdp) async {
    _send({'type': 'answer', 'to': peerId, 'sdp': sdp});
  }

  Future<void> sendCandidate(
    String peerId,
    Map<String, dynamic> candidate,
  ) async {
    _send({'type': 'candidate', 'to': peerId, 'candidate': candidate});
  }

  Future<void> sendJoin() async {
    _send({'type': 'join', 'room': roomId});
  }

  Future<void> sendLeave() async {
    _send({'type': 'leave', 'room': roomId});
  }

  void _send(Map<String, dynamic> msg) {
    if (!_connected) return;
    final encoded = jsonEncode(msg);
    // TODO(backend): _ws.add(encoded);
    // For now, log:
    // debugPrint('Signaling → $encoded');
    // _ = encoded; // suppress unused warning
  }

  // ── Receive ───────────────────────────────────────────────────────────

  /// Call this when a raw message arrives from the signaling WebSocket.
  void handleMessage(String raw) {
    try {
      final msg = jsonDecode(raw) as Map<String, dynamic>;
      final type = msg['type'] as String?;
      final from = msg['from'] as String? ?? '';

      switch (type) {
        case 'offer':
          _offerCtrl.add((from, msg['sdp'] as Map<String, dynamic>));
          break;
        case 'answer':
          _answerCtrl.add((from, msg['sdp'] as Map<String, dynamic>));
          break;
        case 'candidate':
          _candidateCtrl.add((from, msg['candidate'] as Map<String, dynamic>));
          break;
        case 'peer_joined':
          _peerJoinedCtrl.add(from);
          break;
        case 'peer_left':
          _peerLeftCtrl.add(from);
          break;
      }
    } catch (_) {}
  }

  // ── Dispose ───────────────────────────────────────────────────────────

  Future<void> dispose() async {
    _connected = false;
    await _offerCtrl.close();
    await _answerCtrl.close();
    await _candidateCtrl.close();
    await _peerJoinedCtrl.close();
    await _peerLeftCtrl.close();
  }
}
