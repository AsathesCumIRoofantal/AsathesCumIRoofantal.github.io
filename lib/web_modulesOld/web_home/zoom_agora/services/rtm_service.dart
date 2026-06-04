import 'dart:async';
import '../models/chat_message.dart';

/// Thin wrapper around Agora RTM (or any messaging backend).
/// Replace internals with `agora_rtm` package calls.
class RtmService {
  final _msgCtrl = StreamController<ChatMessage>.broadcast();
  final _typingCtrl = StreamController<int>.broadcast();          // uid
  final _reactionCtrl = StreamController<(int uid, String emoji)>.broadcast();
  final _handCtrl = StreamController<(int uid, bool raised)>.broadcast();

  Stream<ChatMessage> get onMessage => _msgCtrl.stream;
  Stream<int>          get onTyping  => _typingCtrl.stream;
  Stream<(int,String)> get onReaction=> _reactionCtrl.stream;
  Stream<(int,bool)>   get onHand    => _handCtrl.stream;

  Future<void> login(String uid, String token) async {
    // TODO(backend): AgoraRtmClient.login(token, uid)
  }
  Future<void> joinChannel(String channelId) async { /* TODO */ }

  Future<void> sendMessage(ChatMessage m) async {
    // TODO(backend): send via RTM, then echo locally
    _msgCtrl.add(m);
  }
  Future<void> sendTyping(int uid) async => _typingCtrl.add(uid);
  Future<void> sendReaction(int uid, String emoji) async => _reactionCtrl.add((uid, emoji));
  Future<void> sendHand(int uid, bool raised) async => _handCtrl.add((uid, raised));

  Future<void> dispose() async {
    await _msgCtrl.close(); await _typingCtrl.close();
    await _reactionCtrl.close(); await _handCtrl.close();
  }
}
