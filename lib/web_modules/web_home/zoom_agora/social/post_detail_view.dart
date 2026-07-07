import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'social_controller.dart';
import 'post_card.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({super.key, required this.post});
  final Map<String, dynamic> post;

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  final _input     = TextEditingController();
  String? _replyTo; // parent comment id

  @override
  void dispose() { _input.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c      = Get.find<SocialController>();
    final postId = widget.post['id'] as String;

    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      appBar: AppBar(
        backgroundColor: ZoomTheme.surface,
        title: const Text('Post', style: TextStyle(color: ZoomTheme.text)),
        iconTheme: const IconThemeData(color: ZoomTheme.text),
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(child: CustomScrollView(slivers: [
          // The post itself
          SliverToBoxAdapter(child: PostCard(post: widget.post)),
          // Comments header
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
            child: Row(children: [
              Text('Comments', style: ZoomTheme.h3),
              const Spacer(),
              Obx(() => Text('${c.comments.length}',
                  style: ZoomTheme.muted)),
            ]),
          )),
          // Comments list
          Obx(() {
            if (c.isLoadingComments.value && c.comments.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator(color: ZoomTheme.primary)));
            }
            final topLevel = c.comments.where((x) => x['parent_id'] == null).toList();
            return SliverList(delegate: SliverChildBuilderDelegate(
              (_, i) {
                final cm = topLevel[i];
                final replies = c.comments.where((x) => x['parent_id'] == cm['id']).toList();
                return _CommentTile(
                  comment: cm,
                  replies: replies,
                  onReply: (id) => setState(() => _replyTo = id),
                  onDelete: (id) => c.deleteComment(id),
                );
              },
              childCount: topLevel.length,
            ));
          }),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ])),
        // Reply to banner
        if (_replyTo != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            color: ZoomTheme.surface,
            child: Row(children: [
              const Icon(Icons.reply, size: 14, color: ZoomTheme.primary),
              const SizedBox(width: 6),
              Text('Replying to comment', style: ZoomTheme.muted.copyWith(fontSize: 12)),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _replyTo = null),
                child: const Icon(Icons.close, size: 14, color: ZoomTheme.textMuted),
              ),
            ]),
          ),
        // Comment composer
        Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          decoration: const BoxDecoration(
            color: ZoomTheme.surface,
            border: Border(top: BorderSide(color: ZoomTheme.stroke)),
          ),
          child: Row(children: [
            Expanded(child: TextField(
              controller: _input,
              style: const TextStyle(color: ZoomTheme.text),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _submit(c, postId),
              decoration: InputDecoration(
                hintText: 'Write a comment…',
                hintStyle: const TextStyle(color: ZoomTheme.textMuted),
                filled: true, fillColor: ZoomTheme.surface2,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            )),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () => _submit(c, postId),
              style: FilledButton.styleFrom(
                backgroundColor: ZoomTheme.primary,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
              child: const Icon(Icons.send_rounded, size: 18),
            ),
          ]),
        ),
      ]),
    );
  }

  void _submit(SocialController c, String postId) {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    c.addComment(postId: postId, content: text, parentId: _replyTo);
    _input.clear();
    setState(() => _replyTo = null);
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.comment, required this.replies,
    required this.onReply, required this.onDelete,
  });
  final Map<String, dynamic> comment;
  final List<Map<String, dynamic>> replies;
  final void Function(String) onReply;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    final isOwn  = CurrentUser.isSignedIn && comment['author_id'] == CurrentUser.id;
    final author = comment['author_name'] as String? ?? 'User';
    final text   = comment['content']    as String? ?? '';
    final id     = comment['id']         as String;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(radius: 14,
            backgroundColor: ZoomTheme.primary.withOpacity(.15),
            child: Text(author[0].toUpperCase(),
                style: const TextStyle(color: ZoomTheme.primary, fontSize: 11))),
          const SizedBox(width: 8),
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ZoomTheme.surface2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(author, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
              const SizedBox(height: 2),
              Text(text, style: const TextStyle(color: ZoomTheme.text, fontSize: 13)),
            ]),
          )),
          if (isOwn)
            PopupMenuButton<String>(
              color: ZoomTheme.surface2,
              icon: const Icon(Icons.more_vert, color: ZoomTheme.textMuted, size: 16),
              onSelected: (v) { if (v == 'delete') onDelete(id); },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'delete',
                    child: Text('Delete', style: TextStyle(color: Color(0xFFFF5C7A)))),
              ],
            ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 42),
          child: TextButton(
            onPressed: () => onReply(id),
            style: TextButton.styleFrom(
                minimumSize: Size.zero, padding: const EdgeInsets.symmetric(horizontal: 4),
                foregroundColor: ZoomTheme.textMuted),
            child: const Text('Reply', style: TextStyle(fontSize: 11)),
          ),
        ),
        // Nested replies
        if (replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Column(children: replies.map((r) => _CommentTile(
              comment: r, replies: const [],
              onReply: onReply, onDelete: onDelete,
            )).toList()),
          ),
      ]),
    );
  }
}
