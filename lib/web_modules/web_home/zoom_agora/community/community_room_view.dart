import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:get/get.dart';
import 'community_controller.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';
import '../services/r2_upload_service.dart';

class CommunityRoomView extends StatefulWidget {
  const CommunityRoomView({super.key, required this.roomId});
  final String roomId;

  @override
  State<CommunityRoomView> createState() => _CommunityRoomViewState();
}

class _CommunityRoomViewState extends State<CommunityRoomView> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  String? _replyToId;
  String? _replyPreview;
  String? _editingMsgId;
  bool _uploading = false;
  bool _showEmojiPicker = false;

  late final CommunityController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<CommunityController>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scroll.hasClients) {
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    if (_editingMsgId != null) {
      _c.editMessage(_editingMsgId!, text);
      _editingMsgId = null;
    } else {
      _c.sendMessage(text, replyToId: _replyToId);
    }
    _input.clear();
    setState(() {
      _replyToId = null;
      _replyPreview = null;
      _editingMsgId = null;
    });
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  Future<void> _pickAndSendFile() async {
    if (_uploading) return;
    final roomId = widget.roomId;
    setState(() => _uploading = true);
    try {
      final result = await FilePicker.pickFiles();
      if (result == null || result.isEmpty) return;
      final f = result.single;
      final bytes = await f.readAsBytes();

      final filename = f.name;

      final contentType = _getContentType(filename);
      final upload = await R2UploadService().uploadFile(
        roomId: roomId,
        filename: filename,
        bytes: bytes,
        contentType: contentType,
      );

      await _c.sendMessage(
        '',
        type: 'file',
        mediaUrl: upload.url,
        mediaName: filename,
        mediaSize: bytes.lengthInBytes,
        replyToId: _replyToId,
      );

      setState(() {
        _replyToId = null;
        _replyPreview = null;
      });
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } catch (e) {
      Get.snackbar('Upload failed', e.toString());
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  String _getContentType(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
      case 'docx':
        return 'application/msword';
      case 'xls':
      case 'xlsx':
        return 'application/vnd.ms-excel';
      case 'ppt':
      case 'pptx':
        return 'application/vnd.ms-powerpoint';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'zip':
        return 'application/zip';
      default:
        return 'application/octet-stream';
    }
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      appBar: AppBar(
        backgroundColor: ZoomTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: ZoomTheme.text),
          onPressed: () => _c.activeRoomId.value = null,
        ),
        title: Obx(() {
          final room = _c.rooms.firstWhereOrNull(
            (r) => r['id'] == widget.roomId,
          );
          return Text(room?['name'] as String? ?? 'Chat', style: ZoomTheme.h3);
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_rounded, color: ZoomTheme.primary),
            onPressed: () {
              /* Launch meeting with room members */
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: ZoomTheme.textMuted),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: Obx(() {
              if (_c.isLoadingMsgs.value && _c.messages.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: ZoomTheme.primary),
                );
              }
              return ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: _c.messages.length,
                itemBuilder: (_, i) {
                  final msg = _c.messages[i];
                  final isMe = msg['sender_id'] == CurrentUser.id;
                  return _MessageBubble(
                    msg: msg,
                    isMe: isMe,
                    onReply: (id, preview) => setState(() {
                      _replyToId = id;
                      _replyPreview = preview;
                    }),
                    onEdit: (id, text) {
                      setState(() {
                        _editingMsgId = id;
                      });
                      _input.text = text;
                      _input.selection = TextSelection.fromPosition(
                        TextPosition(offset: text.length),
                      );
                    },
                    onDelete: (id) => _c.deleteMessage(id),
                    onHistory: (id) async {
                      final hist = await _c.messageHistory(id);
                      Get.bottomSheet(_HistorySheet(history: hist));
                    },
                  );
                },
              );
            }),
          ),
          // Reply / edit banner
          if (_replyPreview != null)
            _ReplyBanner(
              preview: _replyPreview!,
              onCancel: () => setState(() {
                _replyToId = null;
                _replyPreview = null;
              }),
            ),
          if (_editingMsgId != null)
            _ReplyBanner(
              preview: 'Editing message…',
              isEdit: true,
              onCancel: () => setState(() {
                _editingMsgId = null;
                _input.clear();
              }),
            ),
          // Composer
          _Composer(
            controller: _input,
            onSend: _send,
            onAttach: _pickAndSendFile,
            onEmojiToggle: () =>
                setState(() => _showEmojiPicker = !_showEmojiPicker),
            uploading: _uploading,
            showEmojiPicker: _showEmojiPicker,
          ),
          // Emoji picker
          if (_showEmojiPicker)
            Container(
              height: 280,
              color: ZoomTheme.surface2,
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  _input.text += emoji.emoji;
                  _input.selection = TextSelection.fromPosition(
                    TextPosition(offset: _input.text.length),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Message bubble ──────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.msg,
    required this.isMe,
    required this.onReply,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
  });
  final Map<String, dynamic> msg;
  final bool isMe;
  final void Function(String id, String preview) onReply;
  final void Function(String id, String text) onEdit;
  final void Function(String id) onDelete;
  final void Function(String id) onHistory;

  @override
  Widget build(BuildContext context) {
    final deleted = (msg['is_deleted'] as int? ?? 0) == 1;
    final edited = (msg['is_edited'] as int? ?? 0) == 1;
    final text = msg['content'] as String? ?? '';
    final name = msg['sender_name'] as String? ?? 'User';
    final ms = (msg['created_at'] as int?) ?? 0;
    final time = ms == 0
        ? ''
        : _fmtTime(DateTime.fromMillisecondsSinceEpoch(ms));

    return GestureDetector(
      onLongPress: deleted ? null : () => _showMenu(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) ...[
              CircleAvatar(
                radius: 14,
                backgroundColor: ZoomTheme.primary.withValues(alpha: 0.2),
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                    color: ZoomTheme.primary,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        name,
                        style: ZoomTheme.muted.copyWith(fontSize: 11),
                      ),
                    ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: deleted
                          ? ZoomTheme.surface2
                          : isMe
                          ? ZoomTheme.primary
                          : ZoomTheme.surface2,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(14),
                        topRight: const Radius.circular(14),
                        bottomLeft: Radius.circular(isMe ? 14 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 14),
                      ),
                    ),
                    child: deleted
                        ? Text(
                            'This message was deleted',
                            style: ZoomTheme.muted.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Text(
                            text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.35,
                            ),
                          ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(time, style: ZoomTheme.muted.copyWith(fontSize: 10)),
                      if (edited) ...[
                        const SizedBox(width: 4),
                        Text(
                          'edited',
                          style: ZoomTheme.muted.copyWith(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final id = msg['id'] as String;
    final text = msg['content'] as String? ?? '';
    showModalBottomSheet(
      context: context,
      backgroundColor: ZoomTheme.surface2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.reply, color: Colors.white),
            title: const Text('Reply', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.back();
              onReply(
                id,
                text.length > 40 ? '${text.substring(0, 40)}…' : text,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy, color: Colors.white),
            title: const Text('Copy', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.back();
              Clipboard.setData(ClipboardData(text: text));
            },
          ),
          if (isMe) ...[
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text('Edit', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                onEdit(id, text);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white),
              title: const Text(
                'View history',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                onHistory(id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Color(0xFFFF5C7A),
              ),
              title: const Text(
                'Delete',
                style: TextStyle(color: Color(0xFFFF5C7A)),
              ),
              onTap: () {
                Get.back();
                onDelete(id);
              },
            ),
          ],
        ],
      ),
    );
  }

  String _fmtTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

// ── Reply/Edit banner ────────────────────────────────────────────────────────
class _ReplyBanner extends StatelessWidget {
  const _ReplyBanner({
    required this.preview,
    required this.onCancel,
    this.isEdit = false,
  });
  final String preview;
  final VoidCallback onCancel;
  final bool isEdit;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    color: ZoomTheme.surface,
    child: Row(
      children: [
        Container(
          width: 3,
          height: 32,
          color: ZoomTheme.primary,
          margin: const EdgeInsets.only(right: 10),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? 'Editing' : 'Replying to',
                style: const TextStyle(
                  color: ZoomTheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                preview,
                style: ZoomTheme.muted.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: ZoomTheme.textMuted, size: 18),
          onPressed: onCancel,
        ),
      ],
    ),
  );
}

// ── Composer ─────────────────────────────────────────────────────────────────
class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.onSend,
    required this.onAttach,
    required this.onEmojiToggle,
    required this.uploading,
    required this.showEmojiPicker,
  });
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final VoidCallback onEmojiToggle;
  final bool uploading;
  final bool showEmojiPicker;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
    decoration: const BoxDecoration(
      color: ZoomTheme.surface,
      border: Border(top: BorderSide(color: ZoomTheme.stroke)),
    ),
    child: Row(
      children: [
        IconButton(
          icon: Icon(
            uploading ? Icons.cloud_upload : Icons.attach_file,
            color: uploading ? ZoomTheme.primary : ZoomTheme.textMuted,
          ),
          onPressed: uploading ? null : onAttach,
        ),
        IconButton(
          icon: Icon(
            Icons.emoji_emotions_outlined,
            color: showEmojiPicker ? ZoomTheme.primary : ZoomTheme.textMuted,
          ),
          onPressed: onEmojiToggle,
        ),
        IconButton(
          icon: const Icon(Icons.mic_none_rounded, color: ZoomTheme.textMuted),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: ZoomTheme.text),
            textInputAction: TextInputAction.send,
            maxLines: 4,
            minLines: 1,
            onSubmitted: (_) => onSend(),
            decoration: InputDecoration(
              hintText: 'Message…',
              hintStyle: const TextStyle(color: ZoomTheme.textMuted),
              filled: true,
              fillColor: ZoomTheme.surface2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: onSend,
          style: FilledButton.styleFrom(
            backgroundColor: ZoomTheme.primary,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Icons.send_rounded, size: 18),
        ),
      ],
    ),
  );
}

// ── Edit history sheet ────────────────────────────────────────────────────────
class _HistorySheet extends StatelessWidget {
  const _HistorySheet({required this.history});
  final List<Map<String, dynamic>> history;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: ZoomTheme.surface2,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Edit history', style: ZoomTheme.h3),
        const SizedBox(height: 12),
        if (history.isEmpty)
          Text('No edits yet.', style: ZoomTheme.muted)
        else
          ...history.map(
            (h) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h['old_content'] as String? ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _fmtTs(h['edited_at'] as int? ?? 0),
                    style: ZoomTheme.muted.copyWith(fontSize: 11),
                  ),
                  const Divider(color: ZoomTheme.stroke),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
      ],
    ),
  );

  String _fmtTs(int ms) {
    if (ms == 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
