import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'community_controller.dart';
import 'community_room_view.dart';
import 'community_new_view.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';
import '../mock/mock_data.dart';

class CommunityHomeView extends StatelessWidget {
  const CommunityHomeView({super.key});
  static const routeName = '/zoom/community';

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CommunityController>(() => CommunityController());
    final c = Get.find<CommunityController>();
    final wide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ZoomTheme.primary,
        child: const Icon(Icons.edit_rounded, color: Colors.white),
        onPressed: () => Get.to(() => const CommunityNewView()),
      ),
      body: SafeArea(
        child: wide
          ? Row(children: [
              SizedBox(width: 340, child: _RoomList()),
              Container(width: 1, color: ZoomTheme.stroke),
              Expanded(child: Obx(() => c.activeRoomId.value == null
                ? _EmptyState()
                : CommunityRoomView(roomId: c.activeRoomId.value!))),
            ])
          : Obx(() => c.activeRoomId.value == null
              ? _RoomList()
              : CommunityRoomView(roomId: c.activeRoomId.value!)),
      ),
    );
  }
}

class _RoomList extends GetView<CommunityController> {
  @override
  Widget build(BuildContext context) => Column(children: [
    // Header
    Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ZoomTheme.stroke))),
      child: Row(children: [
        Text('Community', style: ZoomTheme.h3),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: ZoomTheme.textMuted, size: 20),
          onPressed: controller.loadRooms,
        ),
      ]),
    ),
    // Search bar
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        style: const TextStyle(color: ZoomTheme.text),
        decoration: InputDecoration(
          hintText: 'Search rooms…',
          hintStyle: const TextStyle(color: ZoomTheme.textMuted),
          prefixIcon: const Icon(Icons.search, color: ZoomTheme.textMuted, size: 18),
          filled: true, fillColor: ZoomTheme.surface2,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          isDense: true,
        ),
      ),
    ),
    Expanded(
      child: Obx(() {
        if (controller.isLoadingRooms.value) {
          return const Center(
              child: CircularProgressIndicator(color: ZoomTheme.primary));
        }
        if (controller.rooms.isEmpty) {
          return Center(
              child: Text('No conversations yet.\nTap + to start one.',
                  textAlign: TextAlign.center, style: ZoomTheme.muted));
        }
        return ListView.builder(
          itemCount: controller.rooms.length,
          itemBuilder: (ctx, i) => _RoomTile(room: controller.rooms[i]),
        );
      }),
    ),
  ]);
}

class _RoomTile extends GetView<CommunityController> {
  const _RoomTile({required this.room});
  final Map<String, dynamic> room;

  @override
  Widget build(BuildContext context) {
    final name    = room['name'] as String? ?? 'Room';
    final preview = room['last_message_preview'] as String? ?? 'No messages yet';
    final ms      = (room['last_message_at'] as int?) ?? 0;
    final time    = ms == 0 ? '' : _timeAgo(DateTime.fromMillisecondsSinceEpoch(ms));
    final roomId  = room['id'] as String;
    final type    = room['type'] as String? ?? 'individual';

    return Obx(() => InkWell(
      onTap: () => controller.openRoom(roomId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: controller.activeRoomId.value == roomId
            ? ZoomTheme.primary.withOpacity(.10)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(children: [
          Stack(children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: ZoomTheme.primary.withOpacity(.2),
              child: Icon(
                type == 'group'
                    ? Icons.group_rounded
                    : type == 'broadcast'
                        ? Icons.campaign_rounded
                        : Icons.person_rounded,
                color: ZoomTheme.primary, size: 22,
              ),
            ),
          ]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(name,
                  style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis)),
              Text(time, style: ZoomTheme.muted.copyWith(fontSize: 11)),
            ]),
            const SizedBox(height: 2),
            Text(preview,
                style: ZoomTheme.muted.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis),
          ])),
        ]),
      ),
    ));
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.chat_bubble_outline_rounded,
          color: ZoomTheme.textMuted, size: 64),
      const SizedBox(height: 16),
      Text('Select a conversation', style: ZoomTheme.h3),
      const SizedBox(height: 8),
      Text('Or tap + to start a new one', style: ZoomTheme.muted),
    ]),
  );
}
