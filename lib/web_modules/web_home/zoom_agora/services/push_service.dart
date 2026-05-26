/// FCM + APNs wrapper.
class PushService {
  Future<void> init() async { /* TODO: firebase_messaging.requestPermission(), getToken() */ }
  Future<void> notifyInvite({required String toToken, required String meetingId}) async {}
  Future<void> notifyChatMention({required String toToken, required String fromName, required String preview}) async {}
}
