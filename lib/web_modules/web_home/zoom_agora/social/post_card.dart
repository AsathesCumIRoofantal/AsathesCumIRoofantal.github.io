import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'social_controller.dart';
import 'post_detail_view.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';

const _kEmojis = ['👍', '❤️', '😂', '😮', '😢', '😡'];

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    final c          = Get.find<SocialController>();
    final postId     = post['id'] as String;
    final author     = post['author_name'] as String? ?? 'Someone';
    final content    = post['content'] as String? ?? '';
    final mediaUrls  = (post['media_urls'] as List?)?.cast<String>() ?? [];
    final mediaTypes = (post['media_types'] as List?)?.cast<String>() ?? [];
    final counts     = (post['reaction_counts'] as Map?)?.cast<String, dynamic>() ?? {};
    final commentCount = post['comment_count'] as int? ?? 0;
    final userReacted  = post['user_reacted'] as String?;
    final ms         = (post['created_at'] as int?) ?? 0;
    final isOwn      = CurrentUser.isSignedIn && post['author_id'] == CurrentUser.id;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: ZoomTheme.card(r: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Header ────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 8, 0),
          child: Row(children: [
            CircleAvatar(radius: 20,
              backgroundColor: ZoomTheme.primary.withOpacity(.2),
              child: Text(author[0].toUpperCase(),
                  style: const TextStyle(color: ZoomTheme.primary, fontWeight: FontWeight.bold))),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(author, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
              Text(_timeAgo(ms), style: ZoomTheme.muted.copyWith(fontSize: 11)),
            ])),
            PopupMenuButton<String>(
              color: ZoomTheme.surface2,
              icon: const Icon(Icons.more_horiz, color: ZoomTheme.textMuted),
              onSelected: (v) {
                if (v == 'delete') c.deletePost(postId);
              },
              itemBuilder: (_) => [
                if (isOwn)
                  const PopupMenuItem(value: 'delete',
                      child: Text('Delete', style: TextStyle(color: Color(0xFFFF5C7A)))),
                const PopupMenuItem(value: 'report',
                    child: Text('Report', style: TextStyle(color: Colors.white))),
              ],
            ),
          ]),
        ),

        // ── Content ───────────────────────────────────────────────────────
        if (content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Text(content,
                style: const TextStyle(color: ZoomTheme.text, fontSize: 14, height: 1.4)),
          ),

        // ── Media grid ────────────────────────────────────────────────────
        if (mediaUrls.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _MediaGrid(urls: mediaUrls, types: mediaTypes),
          ),

        // ── Reaction counts ───────────────────────────────────────────────
        if (counts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
            child: Row(children: counts.entries.map((e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text('${e.key} ${e.value}',
                  style: ZoomTheme.muted.copyWith(fontSize: 12)),
            )).toList()),
          ),

        const Divider(color: ZoomTheme.stroke, height: 16),

        // ── Action bar ────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
          child: Row(children: [
            // Like (hold for all 6 emojis)
            _ReactionButton(
              postId: postId,
              userReacted: userReacted,
              onTap: () => c.toggleReaction(postId, '👍'),
            ),
            _ActionBtn(Icons.chat_bubble_outline, 'Comment ($commentCount)',
              onTap: () {
                c.loadComments(postId);
                Get.to(() => PostDetailView(post: post));
              }),
            _ActionBtn(Icons.share_outlined, 'Share', onTap: () {}),
          ]),
        ),
      ]),
    );
  }

  String _timeAgo(int ms) {
    if (ms == 0) return '';
    final diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(ms));
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${diff.inDays ~/ 7}w ago';
  }
}

class _MediaGrid extends StatelessWidget {
  const _MediaGrid({required this.urls, required this.types});
  final List<String> urls;
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    if (urls.length == 1) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: _MediaItem(url: urls[0], type: types.isNotEmpty ? types[0] : 'image'),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
      itemCount: urls.length > 4 ? 4 : urls.length,
      itemBuilder: (_, i) {
        final isLast = i == 3 && urls.length > 4;
        return Stack(fit: StackFit.expand, children: [
          _MediaItem(url: urls[i], type: types.length > i ? types[i] : 'image'),
          if (isLast)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Text('+${urls.length - 4}',
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ),
        ]);
      },
    );
  }
}

class _MediaItem extends StatelessWidget {
  const _MediaItem({required this.url, required this.type});
  final String url;
  final String type;

  @override
  Widget build(BuildContext context) {
    if (type == 'video' || type == 'reel') {
      return Container(
        color: Colors.black,
        child: const Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48)),
      );
    }
    return Image.network(url, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: ZoomTheme.surface2,
            child: const Icon(Icons.broken_image, color: ZoomTheme.textMuted)));
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn(this.icon, this.label, {required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: ZoomTheme.textMuted),
      label: Text(label, style: ZoomTheme.muted.copyWith(fontSize: 12)),
    ),
  );
}

class _ReactionButton extends StatelessWidget {
  const _ReactionButton({required this.postId, required this.userReacted, required this.onTap});
  final String postId;
  final String? userReacted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SocialController>();
    return Expanded(
      child: GestureDetector(
        onLongPress: () => _showEmojiPicker(context, c),
        child: TextButton.icon(
          onPressed: onTap,
          icon: Text(userReacted ?? '👍', style: const TextStyle(fontSize: 15)),
          label: Text(userReacted != null ? userReacted! : 'Like',
              style: TextStyle(
                color: userReacted != null ? ZoomTheme.primary : ZoomTheme.textMuted,
                fontSize: 12,
              )),
        ),
      ),
    );
  }

  void _showEmojiPicker(BuildContext ctx, SocialController c) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: ZoomTheme.surface2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _kEmojis.map((e) => GestureDetector(
            onTap: () {
              Get.back();
              c.toggleReaction(postId, e);
            },
            child: Text(e, style: const TextStyle(fontSize: 32)),
          )).toList(),
        ),
      ),
    );
  }
}
