// ============================================================
//  AIR App – Remote Support Controller  (AnyDesk-inspired)
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/remote_support_model.dart';
import '../../../services/auth_service_new.dart';
import '../../../services/remote_support_service.dart';

class RemoteSupportController extends GetxController {
  static RemoteSupportController get to => Get.find();

  final RxList<RemoteDevice>           devices  = <RemoteDevice>[].obs;
  final RxList<RemoteSupportSession>   sessions = <RemoteSupportSession>[].obs;
  final RxBool  isLoading    = false.obs;
  final RxBool  isPairing    = false.obs;
  final RxString activeTab   = 'devices'.obs; // devices | sessions | tickets
  final deviceCodeCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  @override
  void onClose() {
    deviceCodeCtrl.dispose();
    super.onClose();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      devices.value  = await RemoteSupportService.to.getDevices();
      sessions.value = await RemoteSupportService.to.getSessions();
    } finally {
      isLoading.value = false;
    }
  }

  // ── Pair a new device ─────────────────────────────────
  Future<void> pairDevice() async {
    final code = deviceCodeCtrl.text.trim();
    if (code.isEmpty) return;
    isPairing.value = true;
    try {
      final success = await RemoteSupportService.to.pairDevice(code);
      if (success) {
        deviceCodeCtrl.clear();
        Get.snackbar('Device Paired ✅',
            'Device connected successfully. It will appear in your list shortly.',
            snackPosition: SnackPosition.BOTTOM);
        await fetchAll();
      } else {
        Get.snackbar('Invalid Code ❌',
            'Could not pair device. Check the 9-digit code and try again.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      }
    } finally {
      isPairing.value = false;
    }
  }

  // ── Request remote session ────────────────────────────
  Future<void> requestSession(String deviceId) async {
    final user = AirAuthService.to.currentUser.value;
    if (user == null) return;
    isLoading.value = true;
    try {
      final session = await RemoteSupportService.to.requestSession(
        targetDeviceId: deviceId,
        requesterId:    user.userId,
        requesterName:  user.name,
      );
      if (session != null) {
        sessions.insert(0, session);
        Get.snackbar('Session Requested 📡',
            'Waiting for device owner to approve…',
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Approve / Decline ─────────────────────────────────
  Future<void> approveSession(String sessionId) async {
    await RemoteSupportService.to.approveSession(sessionId);
    Get.snackbar('Session Approved ✅', 'Remote session is now active.',
        snackPosition: SnackPosition.BOTTOM);
    await fetchAll();
  }

  Future<void> endSession(String sessionId) async {
    await RemoteSupportService.to.endSession(sessionId);
    Get.snackbar('Session Ended', 'Remote session has been terminated.',
        snackPosition: SnackPosition.BOTTOM);
    await fetchAll();
  }

  void setTab(String tab) => activeTab.value = tab;

  List<RemoteDevice> get onlineDevices =>
      devices.where((d) => d.status == DeviceStatus.online).toList();

  List<RemoteSupportSession> get activeSessions =>
      sessions.where((s) => s.status == RemoteSessionStatus.active).toList();
}
