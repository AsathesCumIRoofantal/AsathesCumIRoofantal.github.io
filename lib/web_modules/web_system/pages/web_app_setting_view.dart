import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_app_setting_controller.dart';

class WebAppSettingView extends GetView<WebAppSettingController> {
  const WebAppSettingView({super.key});

  static const String routeName = '/web-system/app-setting';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF6366F1); // Indigo from System
    final isDesktop = WBreak.isDesktop(context);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFEEF2FF),
        body: Row(
          children: [
            // Settings Navigation (Desktop)
            if (isDesktop)
              Container(
                width: 280,
                decoration: BoxDecoration(
                  color: isDark ? WColors.cardDark : Colors.white,
                  border: Border(
                    right: BorderSide(
                      color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_rounded, color: primary),
                            onPressed: () => Get.back(),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildNavTile('General', Icons.tune, true, primary, isDark),
                    _buildNavTile('Account', Icons.person_outline, false, primary, isDark),
                    _buildNavTile('Notifications', Icons.notifications_none, false, primary, isDark),
                    _buildNavTile('Appearance', Icons.palette_outlined, false, primary, isDark),
                    _buildNavTile('Privacy', Icons.lock_outline, false, primary, isDark),
                  ],
                ),
              ),

            // Settings Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (!isDesktop)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_rounded, color: primary),
                              onPressed: () => Get.back(),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: EdgeInsets.all(isDesktop ? 64 : 24),
                    sliver: SliverToBoxAdapter(
                      child: WMaxWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'General Preferences',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : Colors.black87,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Manage your workspace configuration and system behaviors.',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 48),

                            // Section: Notifications
                            _buildSectionHeader('Communications', Icons.chat_bubble_outline, primary, isDark),
                            const SizedBox(height: 24),
                            _buildSettingCard(
                              title: 'Push Notifications',
                              subtitle: 'Receive instant alerts for mentions and assignments.',
                              icon: Icons.notifications_active_outlined,
                              value: controller.pushNotifications,
                              onToggle: controller.togglePushNotifications,
                              primary: primary,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 16),
                            _buildSettingCard(
                              title: 'Email Digest',
                              subtitle: 'Get a weekly summary of workspace activities.',
                              icon: Icons.email_outlined,
                              value: controller.emailUpdates,
                              onToggle: controller.toggleEmailUpdates,
                              primary: primary,
                              isDark: isDark,
                            ),

                            const SizedBox(height: 48),

                            // Section: System
                            _buildSectionHeader('System & Data', Icons.memory, primary, isDark),
                            const SizedBox(height: 24),
                            _buildSettingCard(
                              title: 'Background Sync',
                              subtitle: 'Keep workspaces updated automatically in the background.',
                              icon: Icons.sync,
                              value: controller.autoSync,
                              onToggle: controller.toggleAutoSync,
                              primary: primary,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 16),
                            _buildSettingCard(
                              title: 'Data Saver Mode',
                              subtitle: 'Reduce media quality to save bandwidth on cellular networks.',
                              icon: Icons.data_usage,
                              value: controller.dataSaver,
                              onToggle: controller.toggleDataSaver,
                              primary: primary,
                              isDark: isDark,
                            ),

                            const SizedBox(height: 48),

                            // Section: Advanced
                            _buildSectionHeader('Developer Settings', Icons.code, Colors.redAccent, isDark),
                            const SizedBox(height: 24),
                            _buildSettingCard(
                              title: 'Advanced Mode',
                              subtitle: 'Expose hidden technical details and raw logs in the UI.',
                              icon: Icons.terminal,
                              value: controller.advancedMode,
                              onToggle: controller.toggleAdvancedMode,
                              primary: Colors.redAccent,
                              isDark: isDark,
                            ),
                            
                            const SizedBox(height: 64),
                            
                            // Save Action
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  ),
                                  child: Text('Reset to Default', style: TextStyle(color: isDark ? Colors.white54 : Colors.black54)),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile(String title, IconData icon, bool isActive, Color primary, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? primary : (isDark ? Colors.white54 : Colors.black54)),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? primary : (isDark ? Colors.white70 : Colors.black87),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {},
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Divider(
            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required RxBool value,
    required VoidCallback onToggle,
    required Color primary,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Obx(() => CupertinoSwitch(
            value: value.value,
            onChanged: (v) => onToggle(),
            activeColor: primary,
          )),
        ],
      ),
    );
  }
}
