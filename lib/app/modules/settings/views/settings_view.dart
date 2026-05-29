// ============================================================
//  AIR App – Settings View
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../../../../core/animations/app_animations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.put(SettingsController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [

          // ── Appearance ──────────────────────────────────
          _Section('Appearance', children: [
            Obx(() => _RadioTile(
              title: 'Theme',
              subtitle: ctrl.themeMode.value[0].toUpperCase() + ctrl.themeMode.value.substring(1),
              icon: Icons.palette_rounded,
              onTap: () => _showThemePicker(context, ctrl),
            )),
          ]).fadeSlideIn(delay: 0),

          // ── Notifications ────────────────────────────────
          _Section('Notifications', children: [
            Obx(() => _SwitchTile(
              title:    'Push Notifications',
              subtitle: 'Chats, calls and meetings',
              icon:     Icons.notifications_rounded,
              value:    ctrl.notificationsOn.value,
              onChanged: (_) => ctrl.toggleNotifications(),
            )),
          ]).fadeSlideIn(delay: 60),

          // ── Security ─────────────────────────────────────
          _Section('Security', children: [
            Obx(() => _SwitchTile(
              title:    'Biometric Unlock',
              subtitle: 'Use fingerprint or face ID',
              icon:     Icons.fingerprint_rounded,
              value:    ctrl.biometricEnabled.value,
              onChanged: (_) => ctrl.toggleBiometric(),
            )),
            _Tile(title: 'Change Password',     icon: Icons.lock_rounded,     onTap: () {}),
            _Tile(title: 'Active Sessions',     icon: Icons.devices_rounded,  onTap: () {}),
            _Tile(title: 'Privacy Settings',    icon: Icons.privacy_tip_rounded, onTap: () {}),
          ]).fadeSlideIn(delay: 120),

          // ── Video Engine ──────────────────────────────────
          _Section('Video Engine', children: [
            Obx(() => _SwitchTile(
              title:    'Use Agora RTC',
              subtitle: ctrl.isAgoraEngine.value
                  ? 'Active: Agora RTC Engine'
                  : 'Active: Flutter WebRTC Engine',
              icon:     Icons.videocam_rounded,
              value:    ctrl.isAgoraEngine.value,
              onChanged: (_) => ctrl.toggleEngine(),
            )),
          ]).fadeSlideIn(delay: 180),

          // ── Storage ──────────────────────────────────────
          _Section('Storage & Data', children: [
            _Tile(title: 'Clear Cache',   icon: Icons.cleaning_services_rounded, onTap: ctrl.clearCache),
            _Tile(title: 'Media Storage', icon: Icons.folder_rounded,            onTap: () {}),
            _Tile(title: 'Export Data',   icon: Icons.download_rounded,          onTap: () {}),
          ]).fadeSlideIn(delay: 240),

          // ── About ────────────────────────────────────────
          _Section('About', children: [
            _Tile(title: 'App Info',      icon: Icons.info_outline_rounded,     onTap: ctrl.showAppInfo),
            _Tile(title: 'Help & Support',icon: Icons.help_outline_rounded,     onTap: () {}),
            _Tile(title: 'Terms of Service', icon: Icons.article_outlined,      onTap: () {}),
            _Tile(title: 'Privacy Policy',   icon: Icons.privacy_tip_outlined,  onTap: () {}),
          ]).fadeSlideIn(delay: 300),

          // ── Logout ───────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: FilledButton.icon(
              icon:  const Icon(Icons.logout_rounded),
              label: const Text('Log Out'),
              onPressed: ctrl.logout,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize:     Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
              ),
            ),
          ).fadeSlideIn(delay: 360),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  void _showThemePicker(BuildContext ctx, SettingsController ctrl) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color:        Theme.of(ctx).colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Choose Theme', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 16.h),
          ...['system', 'light', 'dark'].map((mode) => RadioListTile<String>(
            value:    mode,
            groupValue: ctrl.themeMode.value,
            title:    Text(mode[0].toUpperCase() + mode.substring(1)),
            onChanged: (v) { if (v != null) { ctrl.setTheme(v); Get.back(); } },
          )),
        ])),
      ),
    );
  }
}

// ── Section Widget ────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section(this.title, {required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 4.w, top: 16.h, bottom: 8.h),
        child: Text(title,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary, letterSpacing: 0.5)),
      ),
      Container(
        decoration: BoxDecoration(
          color:        theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border:       Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Column(children: children
            .asMap().entries.map((e) => Column(children: [
          e.value,
          if (e.key < children.length - 1)
            Divider(height: 1, indent: 56.w, endIndent: 16.w,
                color: theme.dividerColor.withOpacity(0.5)),
        ])).expand((w) => [w]).toList()),
      ),
      SizedBox(height: 4.h),
    ]);
  }
}

class _Tile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  const _Tile({required this.title, this.subtitle = '', required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading:  Icon(icon, color: theme.colorScheme.primary),
      title:    Text(title, style: TextStyle(fontSize: 14.sp)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: TextStyle(fontSize: 12.sp, color: theme.hintColor)) : null,
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap:    onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({required this.title, this.subtitle = '', required this.icon,
      required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchListTile(
      secondary:       Icon(icon, color: theme.colorScheme.primary),
      title:           Text(title, style: TextStyle(fontSize: 14.sp)),
      subtitle:        subtitle.isNotEmpty
          ? Text(subtitle, style: TextStyle(fontSize: 12.sp, color: theme.hintColor)) : null,
      value:           value,
      onChanged:       onChanged,
      contentPadding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _RadioTile({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading:  Icon(icon, color: theme.colorScheme.primary),
      title:    Text(title,    style: TextStyle(fontSize: 14.sp)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12.sp, color: theme.hintColor)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap:    onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}
