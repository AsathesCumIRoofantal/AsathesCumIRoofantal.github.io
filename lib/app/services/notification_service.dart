// ============================================================
//  AIR App – Notification Service  (FCM + local)
// ============================================================
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  static NotificationService get to => Get.find();

  final RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initLocalNotifications();
    if (!kIsWeb) _initFCM();
  }

  Future<void> _initLocalNotifications() async {
    // flutter_local_notifications setup
    // TODO: configure channels for chat, meetings, remote-support
    debugPrint('📢 LocalNotifications initialised');
  }

  Future<void> _initFCM() async {
    // TODO: firebase_messaging setup
    // FirebaseMessaging.instance.requestPermission()
    // FirebaseMessaging.onMessage.listen(_handleForegroundMessage)
    debugPrint('🔔 FCM initialised');
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String?  payload,
    String   channelId = 'default',
  }) async {
    debugPrint('🔔 Notification: $title – $body');
    unreadCount.value++;
  }

  Future<void> clearAll() async {
    unreadCount.value = 0;
  }

  Future<String?> getFCMToken() async {
    // Real: return FirebaseMessaging.instance.getToken();
    return 'dummy_fcm_token_${DateTime.now().millisecondsSinceEpoch}';
  }
}
