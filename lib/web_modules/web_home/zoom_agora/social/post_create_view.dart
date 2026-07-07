import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'social_controller.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';

class PostCreateView extends StatefulWidget {
  const PostCreateView({super.key});
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  final _content = TextEditingController();
  String _audience = 'public';
  bool _posting = false;

  @override
  void dispose() { _content.dispose(); super.dispose(); }

  Future<void> _post() async {
    if (_posting) return;
    if (_content.text.trim().isEmpty) {
      Get.snackbar('Empty post', 'Write something first.');
      return;
    }
    setState(() => _posting = true);
    try {
      await Get.find<SocialController>().createPost(content: _content.text);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ZoomTheme.bg,
    appBar: AppBar(
      backgroundColor: ZoomTheme.surface,
      title: const Text('Create post', style: TextStyle(color: ZoomTheme.text)),
      iconTheme: const IconThemeData(color: ZoomTheme.text),
      elevation: 0,
      actions: [
        TextButton(
          onPressed: _posting ? null : _post,
          child: Text(_posting ? 'Posting…' : 'Post',
              style: TextStyle(
                color: _posting ? ZoomTheme.textMuted : ZoomTheme.primary,
                fontWeight: FontWeight.w700, fontSize: 15,
              )),
        ),
      ],
    ),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      // Author row
      Row(children: [
        CircleAvatar(
          radius: 22, backgroundColor: ZoomTheme.primary.withOpacity(.2),
          child: Text(
            CurrentUser.isSignedIn ? CurrentUser.name[0].toUpperCase() : 'G',
            style: const TextStyle(color: ZoomTheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(CurrentUser.isSignedIn ? CurrentUser.name : 'Guest',
              style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
          // Audience picker
          GestureDetector(
            onTap: () => _pickAudience(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: ZoomTheme.primary.withOpacity(.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(_audienceIcon, size: 12, color: ZoomTheme.primary),
                const SizedBox(width: 4),
                Text(_audienceLabel,
                    style: const TextStyle(color: ZoomTheme.primary, fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, size: 14, color: ZoomTheme.primary),
              ]),
            ),
          ),
        ]),
      ]),
      const SizedBox(height: 16),
      // Content field
      TextField(
        controller: _content,
        autofocus: true,
        maxLines: null,
        minLines: 5,
        style: const TextStyle(color: ZoomTheme.text, fontSize: 16),
        decoration: const InputDecoration(
          hintText: "What's on your mind?",
          hintStyle: TextStyle(color: ZoomTheme.textMuted, fontSize: 16),
          border: InputBorder.none,
        ),
      ),
      const SizedBox(height: 16),
      // Media actions row
      Container(
        padding: const EdgeInsets.all(12),
        decoration: ZoomTheme.card(r: 12),
        child: Row(children: [
          const Text('Add to your post', style: TextStyle(color: ZoomTheme.text, fontWeight: FontWeight.w600)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.photo_outlined,  color: Colors.green),  onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.red),  onPressed: () {}),
          IconButton(icon: const Icon(Icons.location_on_outlined, color: Colors.blue), onPressed: () {}),
          IconButton(icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.amber), onPressed: () {}),
        ]),
      ),
    ]),
  );

  IconData get _audienceIcon => switch (_audience) {
    'public'  => Icons.public,
    'private' => Icons.lock_outline,
    _         => Icons.group_outlined,
  };

  String get _audienceLabel => switch (_audience) {
    'public'  => 'Public',
    'private' => 'Only me',
    _         => 'Community',
  };

  void _pickAudience(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ZoomTheme.surface2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Wrap(children: [
        ListTile(leading: const Icon(Icons.public, color: Colors.white),
          title: const Text('Public', style: TextStyle(color: Colors.white)),
          onTap: () { setState(() => _audience = 'public'); Get.back(); }),
        ListTile(leading: const Icon(Icons.group_outlined, color: Colors.white),
          title: const Text('Community', style: TextStyle(color: Colors.white)),
          onTap: () { setState(() => _audience = 'community'); Get.back(); }),
        ListTile(leading: const Icon(Icons.lock_outline, color: Colors.white),
          title: const Text('Only me', style: TextStyle(color: Colors.white)),
          onTap: () { setState(() => _audience = 'private'); Get.back(); }),
      ]),
    );
  }
}
