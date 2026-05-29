// ============================================================
//  AIR App – Chat List View  (WhatsApp-inspired)
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controllers/chat_list_controller.dart';
import '../../../models/chat_room_model.dart';
import '../../chat/views/chat_room_view.dart';
import '../../../../core/animations/app_animations.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ChatListController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) => [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Chats', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)),
            actions: [
              // ── Search toggle ──────────────────────────
              IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _FilterBarDelegate(ctrl: ctrl, theme: theme),
          ),
        ],
        body: Obx(() {
          if (ctrl.isLoading.value) return _buildSkeleton();
          if (ctrl.filtered.isEmpty) return _buildEmpty(theme);
          return RefreshIndicator(
            onRefresh: ctrl.fetchRooms,
            child: ListView.separated(
              padding: EdgeInsets.only(top: 4.h, bottom: 80.h),
              itemCount: ctrl.filtered.length,
              separatorBuilder: (_, __) => Divider(
                height: 1, indent: 72.w, endIndent: 16.w,
                color: theme.dividerColor.withOpacity(0.5),
              ),
              itemBuilder: (ctx, i) =>
                  _ChatTile(room: ctrl.filtered[i], index: i).fadeSlideIn(delay: i * 30),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat_rounded),
        tooltip: 'New Chat',
      ),
    );
  }

  Widget _buildSkeleton() => ListView.builder(
    itemCount: 8,
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor:  Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: ListTile(
        leading: CircleAvatar(radius: 24.r, backgroundColor: Colors.grey),
        title:   Container(height: 14.h, width: 120.w, color: Colors.grey),
        subtitle: Container(height: 12.h, width: 200.w, color: Colors.grey),
      ),
    ),
  );

  Widget _buildEmpty(ThemeData theme) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.chat_bubble_outline_rounded, size: 64.r, color: theme.hintColor),
        SizedBox(height: 16.h),
        Text('No chats yet', style: TextStyle(color: theme.hintColor, fontSize: 16.sp)),
      ],
    ),
  );
}

// ── Filter Bar ───────────────────────────────────────────
class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  final ChatListController ctrl;
  final ThemeData theme;
  const _FilterBarDelegate({required this.ctrl, required this.theme});

  @override double get minExtent => 48;
  @override double get maxExtent => 48;
  @override bool shouldRebuild(_) => false;

  @override
  Widget build(BuildContext ctx, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Obx(() => Row(
        children: ['all', 'unread', 'groups'].map((f) {
          final active = ctrl.activeFilter.value == f;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label:    Text(f[0].toUpperCase() + f.substring(1)),
              selected: active,
              onSelected: (_) => ctrl.setFilter(f),
            ),
          );
        }).toList(),
      )),
    );
  }
}

// ── Chat Tile ────────────────────────────────────────────
class _ChatTile extends StatelessWidget {
  final ChatRoomModel room;
  final int index;
  const _ChatTile({required this.room, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius:          24.r,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              room.name.substring(0, 1).toUpperCase(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,
                color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
          if (room.type == ChatRoomType.group)
            Positioned(
              bottom: -2, right: -2,
              child: Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color:  theme.scaffoldBackgroundColor,
                  shape:  BoxShape.circle,
                ),
                child: Icon(Icons.group_rounded, size: 14.r, color: theme.colorScheme.primary),
              ),
            ),
          if (room.isPinned)
            Positioned(
              top: -4, right: -4,
              child: Icon(Icons.push_pin_rounded, size: 12.r, color: theme.colorScheme.secondary),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(room.name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              overflow: TextOverflow.ellipsis),
          ),
          if (room.lastMessageAt != null)
            Text(
              timeago.format(DateTime.fromMillisecondsSinceEpoch(room.lastMessageAt!)),
              style: TextStyle(
                fontSize: 11.sp,
                color: room.unreadCount > 0 ? theme.colorScheme.primary : theme.hintColor,
              ),
            ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              room.lastMessagePreview ?? '',
              style: TextStyle(fontSize: 13.sp, color: theme.hintColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (room.unreadCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color:  theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${room.unreadCount}',
                style: TextStyle(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
      onTap: () => Get.to(() => ChatRoomView(room: room),
          transition: Transition.rightToLeft),
    );
  }
}
