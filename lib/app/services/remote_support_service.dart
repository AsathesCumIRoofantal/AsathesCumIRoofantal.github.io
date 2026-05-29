// ============================================================
//  AIR App – Remote Support Service
// ============================================================
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../models/remote_support_model.dart';

class RemoteSupportService extends GetxService {
  static RemoteSupportService get to => Get.find();

  final _devices  = DummyRemoteSupport.devices;
  final _sessions = DummyRemoteSupport.sessions;

  Future<List<RemoteDevice>> getDevices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _devices;
  }

  Future<List<RemoteSupportSession>> getSessions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _sessions;
  }

  Future<RemoteSupportSession?> requestSession({
    required String targetDeviceId,
    required String requesterId,
    required String requesterName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final now = DateTime.now().millisecondsSinceEpoch;
    final device = _devices.firstWhereOrNull((d) => d.id == targetDeviceId);
    if (device == null) return null;
    final session = RemoteSupportSession(
      id:               'ses_${now}_new',
      requesterId:      requesterId,
      requesterName:    requesterName,
      targetDeviceId:   targetDeviceId,
      targetDeviceName: device.deviceName,
      status:           RemoteSessionStatus.pending,
      createdAt:        now,
    );
    _sessions.insert(0, session);
    return session;
  }

  Future<bool> approveSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true; // Dummy always approves
  }

  Future<bool> endSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> pairDevice(String deviceCode) async {
    await Future.delayed(const Duration(seconds: 2));
    // Dummy: validate 9-digit code format
    final clean = deviceCode.replaceAll(' ', '');
    return clean.length == 9;
  }
}
