// ============================================================
//  AIR App – Root Binding  (all core services injected here)
// ============================================================
import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/permissions/permission_handler.dart';
import '../../core/storage/local_storage.dart';
import '../../core/storage/secure_storage.dart';
import '../services/auth_service_new.dart';
import '../services/chat_service.dart';
import '../services/meeting_service.dart';
import '../services/notification_service.dart';
import '../services/remote_support_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // ── Core infrastructure ──────────────────────────────
    Get.put(LocalStorage(),      permanent: true);
    Get.put(SecureStorage(),     permanent: true);
    Get.put(ApiClient(),         permanent: true);
    Get.put(PermissionService(), permanent: true);

    // ── App services (lazy – only init when first used) ──
    Get.lazyPut<AirAuthService>(()         => AirAuthService(),        fenix: true);
    Get.lazyPut<ChatService>(()            => ChatService(),            fenix: true);
    Get.lazyPut<MeetingService>(()         => MeetingService(),         fenix: true);
    Get.lazyPut<RemoteSupportService>(()   => RemoteSupportService(),   fenix: true);
    Get.lazyPut<NotificationService>(()    => NotificationService(),    fenix: true);
  }
}
