import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../models/chat_message.dart';
import '../widgets/zoom_theme.dart';
import '../mock/mock_data.dart';
import 'zoom_meeting_controller.dart';
import '../services/r2_upload_service.dart';

/// Polished chat with grouped bubbles, timestamps, scope chips, and quick reactions.
class ChatPanel extends GetView<ZoomMeetingController> {
  const ChatPanel({super.key});

  @override
  Widget build(BuildContext c) {
    final input = TextEditingController();
    final scope = ChatScope.everyone.obs;
    final replyTo = Rxn<ChatMessage>();

    return Column(
      children: [
        _Header(),
        Expanded(
          child: Obx(() {
            final msgs = controller.chat.toList();
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: msgs.length,
              itemBuilder: (_, i) => _Bubble(
                m: msgs[i],
                isMe: msgs[i].fromUid == controller.localUid,
                onReply: () => replyTo.value = msgs[i],
              ),
            );
          }),
        ),
        Obx(() {
          final r = replyTo.value;
          if (r == null) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: ZoomTheme.surface2,
              border: Border(top: BorderSide(color: ZoomTheme.stroke)),
            ),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 34,
                  color: ZoomTheme.primary,
                  margin: const EdgeInsets.only(right: 10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Replying to ${r.fromUid == controller.localUid ? 'You' : r.fromName}',
                        style: const TextStyle(
                          color: ZoomTheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        r.text,
                        style: ZoomTheme.muted.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: ZoomTheme.textMuted,
                  ),
                  onPressed: () => replyTo.value = null,
                ),
              ],
            ),
          );
        }),
        _Composer(
          input: input,
          scope: scope,
          onChanged: controller.notifyTyping,
          onSend: () {
            controller.sendChatMessage(
              input.text,
              scope: scope.value,
              replyToId: replyTo.value?.id,
            );
            input.clear();
            replyTo.value = null;
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.fromLTRB(16, 14, 8, 12),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: ZoomTheme.stroke)),
    ),
    child: Row(
      children: [
        Text('Chat', style: ZoomTheme.h3),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: ZoomTheme.surface2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Everyone',
            style: TextStyle(color: ZoomTheme.textMuted, fontSize: 11),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: ZoomTheme.textMuted, size: 18),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: ZoomTheme.textMuted,
            size: 18,
          ),
        ),
      ],
    ),
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.m, required this.isMe, required this.onReply});
  final ChatMessage m;
  final bool isMe;
  final VoidCallback onReply;
  String _time(DateTime d) {
    final h = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$h:$mm';
  }

  @override
  Widget build(BuildContext c) {
    final color = MockMeetingSim.colorFor(m.fromUid);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe)
            InitialsAvatar(name: m.fromName, colorHex: color, size: 32),
          if (!isMe) const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isMe ? 'You' : m.fromName,
                      style: ZoomTheme.body.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _time(m.sentAt),
                      style: ZoomTheme.muted.copyWith(fontSize: 11),
                    ),
                    if (m.scope == ChatScope.direct) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: ZoomTheme.warn.withOpacity(.18),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'DM',
                          style: TextStyle(
                            color: ZoomTheme.warn,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? ZoomTheme.primary : ZoomTheme.surface2,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(isMe ? 14 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 14),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (m.attachments.isNotEmpty)
                        ...m.attachments.map(
                          (u) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.attach_file,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      u,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (m.text.isNotEmpty)
                        Text(
                          m.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.35,
                          ),
                        ),
                    ],
                  ),
                ),
                if (!isMe)
                  TextButton(
                    onPressed: onReply,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      foregroundColor: ZoomTheme.textMuted,
                    ),
                    child: const Text('Reply', style: TextStyle(fontSize: 11)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.input,
    required this.scope,
    required this.onSend,
    this.onChanged,
  });
  final TextEditingController input;
  final Rx<ChatScope> scope;
  final VoidCallback onSend;
  final VoidCallback? onChanged;
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: ZoomTheme.stroke)),
    ),
    child: Column(
      children: [
        Obx(
          () => Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'To:',
                  style: TextStyle(color: ZoomTheme.textMuted, fontSize: 12),
                ),
              ),
              for (final s in ChatScope.values)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(s.name, style: const TextStyle(fontSize: 11)),
                    selected: scope.value == s,
                    onSelected: (_) => scope.value = s,
                    backgroundColor: ZoomTheme.surface2,
                    selectedColor: ZoomTheme.primary,
                    labelStyle: TextStyle(
                      color: scope.value == s
                          ? Colors.white
                          : ZoomTheme.textMuted,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final controller = Get.find<ZoomMeetingController>();
                final result = await FilePicker.platform.pickFiles(
                  withData: true,
                );
                if (result == null || result.files.isEmpty) return;
                final f = result.files.single;
                if (f.bytes == null) return;
                final up = await R2UploadService().uploadFile(
                  roomId: controller.meetingId.value,
                  filename: f.name,
                  bytes: f.bytes!,
                  contentType:
                      f.readStream?.toString() ?? 'application/octet-stream',
                );
                await controller.sendChatMessage(
                  '',
                  scope: scope.value,
                  attachments: [up.url],
                );
              },
              icon: const Icon(Icons.attach_file, color: ZoomTheme.textMuted),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: c,
                  backgroundColor: ZoomTheme.surface2,
                  builder: (_) => SizedBox(
                    height: 320,
                    child: EmojiPicker(
                      onEmojiSelected: (_, e) {
                        input.text += e.emoji;
                        input.selection = TextSelection.fromPosition(
                          TextPosition(offset: input.text.length),
                        );
                      },
                      config: const Config(
                        bottomActionBarConfig: BottomActionBarConfig(
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                color: ZoomTheme.textMuted,
              ),
            ),
            Expanded(
              child: TextField(
                controller: input,
                style: const TextStyle(color: ZoomTheme.text),
                textInputAction: TextInputAction.send,
                onChanged: (_) => onChanged?.call(),
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'Message everyone…',
                  hintStyle: const TextStyle(color: ZoomTheme.textMuted),
                  filled: true,
                  fillColor: ZoomTheme.surface2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: onSend,
              style: FilledButton.styleFrom(
                backgroundColor: ZoomTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
              child: const Icon(Icons.send, size: 18),
            ),
          ],
        ),
      ],
    ),
  );
}
