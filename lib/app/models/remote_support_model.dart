// ============================================================
//  AIR App – Remote Support Model  (AnyDesk-like)
// ============================================================
enum RemoteSessionStatus { pending, active, ended, rejected }
enum DeviceStatus        { online, offline, busy }

class RemoteDevice {
  final String       id;
  final String       deviceName;
  final String       deviceCode;    // 9-digit pairing code
  final String       platform;      // android / ios / web / desktop
  final DeviceStatus status;
  final String?      assignedToUserId;
  final int          lastSeenAt;    // epoch
  final int          createdAt;

  const RemoteDevice({
    required this.id,
    required this.deviceName,
    required this.deviceCode,
    required this.platform,
    this.status           = DeviceStatus.offline,
    this.assignedToUserId,
    required this.lastSeenAt,
    required this.createdAt,
  });
}

class RemoteSupportSession {
  final String              id;
  final String              requesterId;
  final String              requesterName;
  final String              targetDeviceId;
  final String              targetDeviceName;
  final RemoteSessionStatus status;
  final bool                isFileTransferEnabled;
  final bool                isControlEnabled;
  final List<String>        sessionLogs;
  final int                 createdAt;
  final int?                startedAt;
  final int?                endedAt;

  const RemoteSupportSession({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.targetDeviceId,
    required this.targetDeviceName,
    this.status                 = RemoteSessionStatus.pending,
    this.isFileTransferEnabled  = true,
    this.isControlEnabled       = false,
    this.sessionLogs            = const [],
    required this.createdAt,
    this.startedAt,
    this.endedAt,
  });
}

// ── Dummy Data ─────────────────────────────────────────────
class DummyRemoteSupport {
  static final List<RemoteDevice> devices = [
    RemoteDevice(id: 'dev_001', deviceName: 'Office PC – Room 3', deviceCode: '123 456 789',
      platform: 'desktop', status: DeviceStatus.online,
      lastSeenAt: DateTime.now().millisecondsSinceEpoch, createdAt: DateTime.now().millisecondsSinceEpoch),
    RemoteDevice(id: 'dev_002', deviceName: 'Manager Tablet', deviceCode: '987 654 321',
      platform: 'android', status: DeviceStatus.offline,
      lastSeenAt: DateTime.now().subtract(const Duration(hours: 2)).millisecondsSinceEpoch,
      createdAt: DateTime.now().millisecondsSinceEpoch),
    RemoteDevice(id: 'dev_003', deviceName: 'Server Node A', deviceCode: '456 123 789',
      platform: 'desktop', status: DeviceStatus.busy,
      lastSeenAt: DateTime.now().millisecondsSinceEpoch, createdAt: DateTime.now().millisecondsSinceEpoch),
  ];

  static final List<RemoteSupportSession> sessions = [
    RemoteSupportSession(
      id: 'ses_001', requesterId: 'usr_001', requesterName: 'Admin',
      targetDeviceId: 'dev_001', targetDeviceName: 'Office PC – Room 3',
      status: RemoteSessionStatus.active, isControlEnabled: true,
      sessionLogs: ['Session started', 'File access requested', 'Control enabled'],
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)).millisecondsSinceEpoch,
      startedAt: DateTime.now().subtract(const Duration(minutes: 20)).millisecondsSinceEpoch,
    ),
  ];
}
