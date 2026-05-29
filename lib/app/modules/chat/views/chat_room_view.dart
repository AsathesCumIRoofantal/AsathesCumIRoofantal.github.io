// ============================================================
//  AIR App – Chat Room View  (WhatsApp-inspired bubbles)
// ============================================================
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controllers/chat_room_controller.dart';
import '../../../models/chat_message_model.dart';
import '../../../models/chat_room_model.dart';
import '../../../services/auth_service_new.dart';

class ChatRoomView extends StatelessWidget {
  final ChatRoomModel room;
  const ChatRoomView({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.put(ChatRoomController(room: room));
    final theme = Theme.of(context);
    final myId  = AirAuthService.to.currentUser.value?.userId ?? 'me';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: BackButton(),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(room.name[0].toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp,
                    color: theme.colorScheme.onPrimaryContainer)),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room.name,
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                  Obx(() => ctrl.isTyping.value
                    ? Text('typing…',
                        style: TextStyle(fontSize: 11.sp, color: theme.colorScheme.primary))
                    : Text('tap for info',
                        style: TextStyle(fontSize: 11.sp, color: theme.hintColor))),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // ── Message list ────────────────────────────────
          Expanded(
            child: Obx(() {
              if (ctrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: ctrl.scrollController,
                reverse:    true,
                padding:    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                itemCount:  ctrl.messages.length,
                itemBuilder: (ctx, i) {
                  final msg   = ctrl.messages[i];
                  final isMine = msg.senderId == myId;
                  return _MessageBubble(msg: msg, isMine: isMine)
                      .animate().fadeIn(duration: 200.ms).slideX(
                        begin: isMine ? 0.05 : -0.05, duration: 200.ms,
                        curve: Curves.easeOut,
                      );
                },
              );
            }),
          ),
          // ── Reply preview ────────────────────────────────
          Obx(() {
            if (ctrl.replyTo.value == null) return const SizedBox.shrink();
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color:        theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(width: 3.w, height: 40.h,
                    color: theme.colorScheme.primary),
                  SizedBox(width: 8.w),
                  Expanded(child: Text(ctrl.replyTo.value!.content ?? '[Media]',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp))),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: ctrl.cancelReply,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            );
          }),
          // ── Input bar ───────────────────────────────────
          _InputBar(ctrl: ctrl, theme: theme),
        ],
      ),
    );
  }
}

// ── Message Bubble ───────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final ChatMessageModel msg;
  final bool isMine;
  const _MessageBubble({required this.msg, required this.isMine});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = isMine
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final fg = isMine
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {}, // reaction / reply picker
        child: Container(
          constraints: BoxConstraints(maxWidth: 280.w),
          margin: EdgeInsets.symmetric(vertical: 3.h),
          padding: msg.type == MessageType.image
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: msg.type == MessageType.image ? Colors.transparent : bg,
            borderRadius: BorderRadius.only(
              topLeft:     Radius.circular(isMine ? 16.r : 4.r),
              topRight:    Radius.circular(isMine ? 4.r  : 16.r),
              bottomLeft:  Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (msg.type == MessageType.image && msg.mediaUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: msg.mediaUrl!,
                    width: 220.w, fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 160.h, width: 220.w, color: Colors.grey.shade800),
                    errorWidget: (_, __, ___) => const Icon(Icons.broken_image_rounded),
                  ),
                )
              else if (msg.type == MessageType.text)
                Text(msg.content ?? '', style: TextStyle(color: fg, fontSize: 14.sp)),

              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(msg.createdAt), allowFromNow: true),
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: fg.withOpacity(0.6)),
                  ),
                  if (isMine) ...[
                    SizedBox(width: 4.w),
                    Icon(_statusIcon(msg.status),
                        size: 14.r,
                        color: msg.status == MessageStatus.seen
                            ? Colors.blue
                            : fg.withOpacity(0.6)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _statusIcon(MessageStatus s) {
    switch (s) {
      case MessageStatus.sending:   return Icons.access_time_rounded;
      case MessageStatus.sent:      return Icons.check_rounded;
      case MessageStatus.delivered: return Icons.done_all_rounded;
      case MessageStatus.seen:      return Icons.done_all_rounded;
      case MessageStatus.failed:    return Icons.error_outline_rounded;
    }
  }
}

// ── Input Bar ────────────────────────────────────────────
class _InputBar extends StatelessWidget {
  final ChatRoomController ctrl;
  final ThemeData theme;
  const _InputBar({required this.ctrl, required this.theme});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: () {},
            color: theme.hintColor,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:        theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ctrl.textController,
                      maxLines:   5,
                      minLines:   1,
                      decoration: InputDecoration(
                        hintText:       'Type a message…',
                        border:         InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      ),
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file_rounded),
                    onPressed: () {},
                    color: theme.hintColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {},
                    color: theme.hintColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Obx(() => FloatingActionButton.small(
            onPressed: ctrl.isSending.value ? null : ctrl.sendTextMessage,
            backgroundColor: theme.colorScheme.primary,
            child: ctrl.isSending.value
                ? SizedBox(width: 20.r, height: 20.r,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.send_rounded, color: Colors.white),
          )),
        ],
      ),
    ),
  );
}
