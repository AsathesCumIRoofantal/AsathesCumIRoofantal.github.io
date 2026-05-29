// ============================================================
//  AIR App – Remote Support View  (AnyDesk-inspired UI)
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/remote_support_controller.dart';
import '../../../models/remote_support_model.dart';
import '../../../../core/animations/app_animations.dart';

class RemoteSupportView extends StatelessWidget {
  const RemoteSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(RemoteSupportController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Remote Support',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: ctrl.fetchAll,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Connect Panel ───────────────────────────────
          _ConnectPanel(ctrl: ctrl, theme: theme),

          // ── Tab bar ──────────────────────────────────────
          Obx(() => _TabBar(ctrl: ctrl, theme: theme)),

          // ── Content ──────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (ctrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              switch (ctrl.activeTab.value) {
                case 'sessions':
                  return _SessionList(ctrl: ctrl, theme: theme);
                case 'tickets':
                  return _TicketsPlaceholder(theme: theme);
                default:
                  return _DeviceList(ctrl: ctrl, theme: theme);
              }
            }),
          ),
        ],
      ),
    );
  }
}

// ── Connect Panel ────────────────────────────────────────
class _ConnectPanel extends StatelessWidget {
  final RemoteSupportController ctrl;
  final ThemeData theme;
  const _ConnectPanel({required this.ctrl, required this.theme});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.all(16.r),
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(
          color: theme.colorScheme.primary.withOpacity(0.35),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.monitor_rounded, color: Colors.white, size: 24.r),
            SizedBox(width: 10.w),
            Text(
              'Connect to Device',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: ctrl.deviceCodeCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 4,
                ),
                decoration: InputDecoration(
                  hintText: '123 456 789',
                  hintStyle: TextStyle(color: Colors.white38, letterSpacing: 4),
                  filled: true,
                  fillColor: Colors.white24,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Obx(
              () => ElevatedButton(
                onPressed: ctrl.isPairing.value ? null : ctrl.pairDevice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: theme.colorScheme.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: ctrl.isPairing.value
                    ? SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : Text(
                        'Connect',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    ),
  ).fadeSlideIn();
}

// ── Tab Bar ──────────────────────────────────────────────
class _TabBar extends StatelessWidget {
  final RemoteSupportController ctrl;
  final ThemeData theme;
  const _TabBar({required this.ctrl, required this.theme});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: ['devices', 'sessions', 'tickets'].map((tab) {
        final isActive = ctrl.activeTab.value == tab;
        return Expanded(
          child: GestureDetector(
            onTap: () => ctrl.setTab(tab),
            child: AnimatedContainer(
              duration: AppAnimations.fast,
              margin: EdgeInsets.all(4.r),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: isActive
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                tab[0].toUpperCase() + tab.substring(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : theme.hintColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

// ── Device List ──────────────────────────────────────────
class _DeviceList extends StatelessWidget {
  final RemoteSupportController ctrl;
  final ThemeData theme;
  const _DeviceList({required this.ctrl, required this.theme});

  @override
  Widget build(BuildContext context) {
    if (ctrl.devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.devices_other_rounded,
              size: 64.r,
              color: theme.hintColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'No devices paired',
              style: TextStyle(color: theme.hintColor, fontSize: 16.sp),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: ctrl.devices.length,
      itemBuilder: (_, i) =>
          _DeviceCard(device: ctrl.devices[i], ctrl: ctrl, index: i),
    );
  }
}

// ── Device Card ──────────────────────────────────────────
class _DeviceCard extends StatelessWidget {
  final RemoteDevice device;
  final RemoteSupportController ctrl;
  final int index;
  const _DeviceCard({
    required this.device,
    required this.ctrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOnline = device.status == DeviceStatus.online;
    final isBusy = device.status == DeviceStatus.busy;
    final stColor = isOnline
        ? Colors.green
        : isBusy
        ? Colors.orange
        : Colors.grey;
    final stLabel =
        device.status.name[0].toUpperCase() + device.status.name.substring(1);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: stColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _platformIcon(device.platform),
                    color: stColor,
                    size: 24.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.deviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: BoxDecoration(
                              color: stColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            stLabel,
                            style: TextStyle(
                              color: stColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            device.platform,
                            style: TextStyle(
                              color: theme.hintColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    device.deviceCode,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.file_copy_outlined, size: 16),
                  label: const Text('File Transfer'),
                  onPressed: () => Get.snackbar(
                    'File Transfer',
                    'File transfer UI coming in Phase 6',
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                SizedBox(width: 8.w),
                const Spacer(),
                FilledButton.icon(
                  icon: const Icon(Icons.screen_share_rounded, size: 16),
                  label: const Text('Remote Control'),
                  onPressed: isOnline
                      ? () => ctrl.requestSession(device.id)
                      : null,
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).fadeSlideIn(delay: index * 60);
  }

  IconData _platformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Icons.android_rounded;
      case 'ios':
        return Icons.phone_iphone_rounded;
      case 'desktop':
        return Icons.desktop_windows_rounded;
      default:
        return Icons.devices_rounded;
    }
  }
}

// ── Session List ─────────────────────────────────────────
class _SessionList extends StatelessWidget {
  final RemoteSupportController ctrl;
  final ThemeData theme;
  const _SessionList({required this.ctrl, required this.theme});

  @override
  Widget build(BuildContext context) {
    if (ctrl.sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 64.r, color: theme.hintColor),
            SizedBox(height: 16.h),
            Text(
              'No sessions yet',
              style: TextStyle(color: theme.hintColor, fontSize: 16.sp),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: ctrl.sessions.length,
      itemBuilder: (_, i) => _SessionCard(
        session: ctrl.sessions[i],
        ctrl: ctrl,
        theme: theme,
        index: i,
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final RemoteSupportSession session;
  final RemoteSupportController ctrl;
  final ThemeData theme;
  final int index;
  const _SessionCard({
    required this.session,
    required this.ctrl,
    required this.theme,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = session.status == RemoteSessionStatus.active;
    final isPending = session.status == RemoteSessionStatus.pending;
    final stColor = isActive
        ? Colors.green
        : isPending
        ? Colors.orange
        : Colors.grey;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: stColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: BoxDecoration(
                    color: stColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  session.status.name[0].toUpperCase() +
                      session.status.name.substring(1),
                  style: TextStyle(
                    color: stColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '#${session.id.substring(4, 10)}',
                  style: TextStyle(color: theme.hintColor, fontSize: 11.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              session.targetDeviceName,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Requester: ${session.requesterName}',
              style: TextStyle(color: theme.hintColor, fontSize: 12.sp),
            ),
            if (session.sessionLogs.isNotEmpty) ...[
              SizedBox(height: 8.h),
              ...session.sessionLogs
                  .take(2)
                  .map(
                    (log) => Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 14.r,
                            color: theme.hintColor,
                          ),
                          Text(
                            log,
                            style: TextStyle(
                              color: theme.hintColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
            if (isPending || isActive) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isPending) ...[
                    OutlinedButton(
                      onPressed: () => ctrl.endSession(session.id),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Decline'),
                    ),
                    SizedBox(width: 8.w),
                    FilledButton(
                      onPressed: () => ctrl.approveSession(session.id),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Approve'),
                    ),
                  ] else if (isActive)
                    FilledButton.icon(
                      icon: const Icon(Icons.stop_circle_outlined, size: 16),
                      label: const Text('End Session'),
                      onPressed: () => ctrl.endSession(session.id),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    ).fadeSlideIn(delay: index * 50);
  }
}

// ── Tickets Placeholder ──────────────────────────────────
class _TicketsPlaceholder extends StatelessWidget {
  final ThemeData theme;
  const _TicketsPlaceholder({required this.theme});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.confirmation_number_outlined,
          size: 64.r,
          color: theme.hintColor,
        ),
        SizedBox(height: 16.h),
        Text(
          'Support Tickets',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Text(
          'Coming in Phase 6 – Remote Support Module',
          style: TextStyle(color: theme.hintColor, fontSize: 14.sp),
        ),
        SizedBox(height: 24.h),
        FilledButton.icon(
          icon: const Icon(Icons.add_rounded),
          label: const Text('New Ticket'),
          onPressed: () => Get.snackbar(
            'Tickets',
            'Ticket system will be available in Phase 6',
            snackPosition: SnackPosition.BOTTOM,
          ),
        ),
      ],
    ),
  );
}
