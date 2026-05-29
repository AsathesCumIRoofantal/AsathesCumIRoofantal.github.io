// ============================================================
//  AIR App – Meeting List View  (Zoom-inspired pre-meeting UI)
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/meeting_list_controller.dart';
import '../../../models/meeting_model.dart';
import 'meeting_room_view.dart';
import '../../../../core/animations/app_animations.dart';

class MeetingListView extends StatelessWidget {
  const MeetingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.put(MeetingListController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Meetings', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // ── Quick actions ───────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                _QuickAction(
                  icon: Icons.video_call_rounded, label: 'New\nMeeting',
                  color: theme.colorScheme.primary, onTap: () {},
                ),
                SizedBox(width: 12.w),
                _QuickAction(
                  icon: Icons.input_rounded, label: 'Join\nMeeting',
                  color: theme.colorScheme.secondary, onTap: () {},
                ),
                SizedBox(width: 12.w),
                _QuickAction(
                  icon: Icons.calendar_month_rounded, label: 'Schedule',
                  color: theme.colorScheme.tertiary, onTap: () {},
                ),
                SizedBox(width: 12.w),
                _QuickAction(
                  icon: Icons.screen_share_rounded, label: 'Share\nScreen',
                  color: Colors.orange, onTap: () {},
                ),
              ].map((w) => Expanded(child: w)).toList(),
            ),
          ),
          // ── Tab bar ──────────────────────────────────────
          Obx(() => Row(
            children: ['upcoming', 'live', 'ended'].map((tab) {
              final isActive = ctrl.activeTab.value == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => ctrl.setTab(tab),
                  child: AnimatedContainer(
                    duration: AppAnimations.fast,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: isActive ? theme.colorScheme.primary : Colors.transparent,
                        width: 2.h,
                      )),
                    ),
                    child: Text(
                      tab[0].toUpperCase() + tab.substring(1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:   13.sp,
                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                        color:      isActive ? theme.colorScheme.primary : theme.hintColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          // ── Meeting list ─────────────────────────────────
          Expanded(
            child: Obx(() {
              if (ctrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = ctrl.filtered;
              if (items.isEmpty) {
                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.videocam_off_rounded, size: 64.r, color: theme.hintColor),
                    SizedBox(height: 16.h),
                    Text('No ${ctrl.activeTab.value} meetings',
                        style: TextStyle(color: theme.hintColor, fontSize: 16.sp)),
                  ]),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: items.length,
                itemBuilder: (ctx, i) => _MeetingCard(meeting: items[i], index: i),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Quick Action Button ──────────────────────────────────
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color:        color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16.r),
        border:       Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.r),
          SizedBox(height: 6.h),
          Text(label, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.sp, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

// ── Meeting Card ─────────────────────────────────────────
class _MeetingCard extends StatelessWidget {
  final MeetingModel meeting;
  final int index;
  const _MeetingCard({required this.meeting, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final isLive  = meeting.status == MeetingStatus.live;
    final timeStr = DateFormat('EEE, MMM d • hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(meeting.scheduledAt));

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color:        theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isLive
              ? Colors.green.withOpacity(0.4)
              : theme.dividerColor.withOpacity(0.3),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isLive)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    margin:  EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(8.r)),
                    child: Row(children: [
                      Container(width: 6.r, height: 6.r,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                      SizedBox(width: 4.w),
                      Text('LIVE', style: TextStyle(color: Colors.white,
                          fontSize: 10.sp, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                Expanded(
                  child: Text(meeting.title,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                ),
                Icon(Icons.more_vert_rounded, size: 20.r, color: theme.hintColor),
              ],
            ),
            SizedBox(height: 8.h),
            Row(children: [
              Icon(Icons.access_time_rounded, size: 14.r, color: theme.hintColor),
              SizedBox(width: 4.w),
              Text(timeStr, style: TextStyle(fontSize: 12.sp, color: theme.hintColor)),
            ]),
            SizedBox(height: 4.h),
            Row(children: [
              Icon(Icons.person_rounded, size: 14.r, color: theme.hintColor),
              SizedBox(width: 4.w),
              Text('Host: ${meeting.hostName}',
                  style: TextStyle(fontSize: 12.sp, color: theme.hintColor)),
              const Spacer(),
              Text('${meeting.participants.length} joined',
                  style: TextStyle(fontSize: 12.sp, color: theme.hintColor)),
            ]),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isLive)
                  OutlinedButton.icon(
                    icon: const Icon(Icons.edit_calendar_rounded, size: 16),
                    label: const Text('Edit'),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        visualDensity: VisualDensity.compact),
                  ),
                SizedBox(width: 8.w),
                FilledButton.icon(
                  icon: Icon(isLive ? Icons.video_call_rounded : Icons.play_arrow_rounded, size: 16),
                  label: Text(isLive ? 'Join Now' : 'Start'),
                  onPressed: () => Get.to(() => MeetingRoomView(meeting: meeting),
                      transition: Transition.fadeIn),
                  style: FilledButton.styleFrom(
                    backgroundColor: isLive ? Colors.green : null,
                    visualDensity:   VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).fadeSlideIn(delay: index * 50);
  }
}
