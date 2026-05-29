// ============================================================
//  AIR App – Main Dashboard / Shell  (adaptive nav)
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../chat/views/chat_list_view.dart';
import '../../meetings/views/meeting_list_view.dart';
import '../../remote_support/views/remote_support_view.dart';
import '../../settings/views/settings_view.dart';
import '../../../../core/responsive/responsive_helper.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../services/auth_service_new.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // ── Nav destinations ─────────────────────────────────
  static const _pages = [
    _HomeSummaryPage(),
    ChatListView(),
    MeetingListView(),
    RemoteSupportView(),
    SettingsView(),
  ];

  static const _navItems = [
    _NavItem(Icons.home_rounded,          Icons.home_outlined,          'Home'),
    _NavItem(Icons.chat_rounded,          Icons.chat_outlined,          'Chats'),
    _NavItem(Icons.video_call_rounded,    Icons.video_call_outlined,    'Meetings'),
    _NavItem(Icons.screen_share_rounded,  Icons.screen_share_outlined,  'Remote'),
    _NavItem(Icons.settings_rounded,      Icons.settings_outlined,      'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(DashboardController());
    return Responsive.useBottomNav(context)
        ? _MobileShell(ctrl: ctrl)
        : _DesktopShell(ctrl: ctrl);
  }
}

// ── Mobile / Tablet Portrait shell ───────────────────────
class _MobileShell extends StatelessWidget {
  final DashboardController ctrl;
  const _MobileShell({required this.ctrl});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Obx(() => IndexedStack(
      index: ctrl.selectedIndex.value,
      children: DashboardView._pages,
    )),
    bottomNavigationBar: Obx(() => NavigationBar(
      selectedIndex: ctrl.selectedIndex.value,
      onDestinationSelected: ctrl.navigate,
      destinations: DashboardView._navItems.map((item) =>
        NavigationDestination(
          icon:          Icon(item.iconOff),
          selectedIcon:  Icon(item.iconOn),
          label:         item.label,
        ),
      ).toList(),
    )),
  );
}

// ── Desktop / Tablet Landscape shell ─────────────────────
class _DesktopShell extends StatelessWidget {
  final DashboardController ctrl;
  const _DesktopShell({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Obx(() => NavigationRail(
            selectedIndex: ctrl.selectedIndex.value,
            onDestinationSelected: ctrl.navigate,
            extended: Responsive.isDesktop(context),
            minWidth: 72,
            minExtendedWidth: 220,
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(children: [
                Container(
                  width: 40.r, height: 40.r,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.air_rounded, color: Colors.white, size: 24.r),
                ),
                if (Responsive.isDesktop(context)) ...[
                  SizedBox(height: 6.h),
                  Text('AIR-Space',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp)),
                ],
              ]),
            ),
            destinations: DashboardView._navItems.map((item) =>
              NavigationRailDestination(
                icon:          Icon(item.iconOff),
                selectedIcon:  Icon(item.iconOn),
                label:         Text(item.label),
              ),
            ).toList(),
          )),
          const VerticalDivider(thickness: 1, width: 1),
          // Page content
          Expanded(
            child: Obx(() => IndexedStack(
              index: ctrl.selectedIndex.value,
              children: DashboardView._pages,
            )),
          ),
        ],
      ),
    );
  }
}

// ── Nav Item ─────────────────────────────────────────────
class _NavItem {
  final IconData iconOn, iconOff;
  final String   label;
  const _NavItem(this.iconOn, this.iconOff, this.label);
}

// ── Home Summary Page ────────────────────────────────────
class _HomeSummaryPage extends StatelessWidget {
  const _HomeSummaryPage();

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.find<DashboardController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ctrl.fetchDashboardData,
          child: CustomScrollView(
            slivers: [
              // ── Header ─────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Obx(() => Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ctrl.greeting,
                                style: TextStyle(color: theme.hintColor, fontSize: 14.sp)),
                            Text(ctrl.userName,
                                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius:          22.r,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: Text(ctrl.userName[0].toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp,
                                    color: theme.colorScheme.onPrimaryContainer)),
                          ),
                          Obx(() {
                            final count = ctrl.unreadMessages.value;
                            if (count == 0) return const SizedBox.shrink();
                            return Positioned(
                              top: -2, right: -2,
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text('$count',
                                    style: TextStyle(color: Colors.white, fontSize: 9.sp,
                                        fontWeight: FontWeight.w700)),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  )).fadeSlideIn(),
                ),
              ),

              // ── Stats cards ────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() => Row(children: [
                    Expanded(child: _StatCard(
                        label: 'Chats', value: ctrl.totalChats.value,
                        icon: Icons.chat_rounded, color: theme.colorScheme.primary)),
                    SizedBox(width: 12.w),
                    Expanded(child: _StatCard(
                        label: 'Unread', value: ctrl.unreadMessages.value,
                        icon: Icons.mark_chat_unread_rounded, color: Colors.orange)),
                    SizedBox(width: 12.w),
                    Expanded(child: _StatCard(
                        label: 'Live', value: ctrl.activeMeetings.value,
                        icon: Icons.videocam_rounded, color: Colors.green)),
                    SizedBox(width: 12.w),
                    Expanded(child: _StatCard(
                        label: 'Online', value: ctrl.onlineDevices.value,
                        icon: Icons.monitor_rounded, color: Colors.purple)),
                  ])).fadeSlideIn(delay: 100),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── Upcoming meetings ──────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle('Upcoming Meetings', onSeeAll: () => Get.find<DashboardController>().navigate(2)),
                      SizedBox(height: 12.h),
                      Obx(() => ctrl.upcomingMeetings.isEmpty
                          ? _EmptyState(icon: Icons.videocam_off_rounded, label: 'No meetings scheduled')
                          : Column(children: ctrl.upcomingMeetings.map((m) =>
                              _MeetingMiniCard(meeting: m, theme: theme)).toList())),
                    ],
                  ),
                ).fadeSlideIn(delay: 200),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // ── Recent chats ───────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle('Recent Chats', onSeeAll: () => Get.find<DashboardController>().navigate(1)),
                      SizedBox(height: 12.h),
                      Obx(() => ctrl.recentChats.isEmpty
                          ? _EmptyState(icon: Icons.chat_bubble_outline_rounded, label: 'No chats yet')
                          : Column(children: ctrl.recentChats.take(4).map((r) =>
                              _ChatMiniTile(room: r, theme: theme)).toList())),
                    ],
                  ),
                ).fadeSlideIn(delay: 300),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 32.h)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Stat Card ────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label; final int value;
  final IconData icon; final Color color;
  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
    decoration: BoxDecoration(
      color:        color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16.r),
      border:       Border.all(color: color.withOpacity(0.2)),
    ),
    child: Column(children: [
      Icon(icon, color: color, size: 22.r),
      SizedBox(height: 6.h),
      Text('$value', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp, color: color)),
      Text(label,    style: TextStyle(fontSize: 10.sp, color: color.withOpacity(0.8))),
    ]),
  );
}

class _SectionTitle extends StatelessWidget {
  final String label;
  final VoidCallback? onSeeAll;
  const _SectionTitle(this.label, {this.onSeeAll});

  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(label,
        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700))),
    if (onSeeAll != null)
      TextButton(onPressed: onSeeAll, child: const Text('See all')),
  ]);
}

class _EmptyState extends StatelessWidget {
  final IconData icon; final String label;
  const _EmptyState({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(24.r),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16.r)),
    child: Center(child: Column(children: [
      Icon(icon, size: 32.r, color: Theme.of(context).hintColor),
      SizedBox(height: 8.h),
      Text(label, style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14.sp)),
    ])),
  );
}

class _MeetingMiniCard extends StatelessWidget {
  final meeting; final ThemeData theme;
  const _MeetingMiniCard({required this.meeting, required this.theme});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
    ),
    child: Row(children: [
      Container(width: 4.w, height: 40.h,
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2.r))),
      SizedBox(width: 12.w),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(meeting.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
        Text(meeting.hostName, style: TextStyle(color: theme.hintColor, fontSize: 12.sp)),
      ])),
      Icon(Icons.chevron_right_rounded, color: theme.hintColor),
    ]),
  );
}

class _ChatMiniTile extends StatelessWidget {
  final room; final ThemeData theme;
  const _ChatMiniTile({required this.room, required this.theme});

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2.h),
    leading: CircleAvatar(
      radius: 20.r,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Text(room.name[0].toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp,
              color: theme.colorScheme.onPrimaryContainer)),
    ),
    title:    Text(room.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
    subtitle: Text(room.lastMessagePreview ?? '', overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12.sp, color: theme.hintColor)),
    trailing: room.unreadCount > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(10.r)),
            child: Text('${room.unreadCount}',
                style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700)))
        : null,
    onTap: () => Get.find<DashboardController>().navigate(1),
  );
}
