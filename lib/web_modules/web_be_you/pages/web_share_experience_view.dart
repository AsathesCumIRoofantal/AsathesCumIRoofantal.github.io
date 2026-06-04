// REWRITE — Story-sharing surface with composer + animated feed.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_share_experience_controller.dart';

class WebShareExperienceView extends GetView<WebShareExperienceController> {
  const WebShareExperienceView({super.key});
  static const String routeName = '/web-be-you/share-experience';

  static const _stories = [
    _Story('Anaya', 'Trainer · Mumbai', 'Closed my biggest skill gap by teaching it. The class learns; so do I.', 18, 4, Color(0xFFEC4899)),
    _Story('Lior', 'Operator · Tel Aviv', 'Replaced 3 meetings with 1 written brief and a 10-min Q&A. Saved 4 hours a week.', 42, 9, Color(0xFF8B5CF6)),
    _Story('Marta', 'Designer · Lisbon', 'Sketching before talking. Suddenly the team agrees faster.', 27, 6, Color(0xFFF59E0B)),
    _Story('Kenji', 'Engineer · Osaka', 'A small daily ritual: write what tripped me. Read it Fridays.', 15, 3, Color(0xFF10B981)),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('be_you');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF14101F) : const Color(0xFFFFF7F9);
    final ink = isDark ? Colors.white : const Color(0xFF1B1330);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true, expandedHeight: 280, backgroundColor: bg,
            flexibleSpace: FlexibleSpaceBar(
              background: GlowBackground(
                colors: [accent, const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
                child: WMaxWidth(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Reveal(child: Text('YOUR PAGE, YOUR VOICE',
                          style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 12),
                      Reveal(delayMs: 100, child: Text('Share what you actually learned.',
                          style: TextStyle(color: Colors.white, fontSize: WBreak.isMobile(context) ? 28 : 46, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // composer
          SliverToBoxAdapter(
            child: WMaxWidth(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
              child: Reveal(child: _Composer(controller: controller, accent: accent, isDark: isDark, ink: ink)),
            ),
          ),
          // feed
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 80),
            sliver: SliverList.builder(
              itemCount: _stories.length,
              itemBuilder: (_, i) => WMaxWidth(
                padding: const EdgeInsets.only(bottom: 16),
                child: Reveal(delayMs: 80 * i, child: HoverLift(child: _StoryCard(s: _stories[i], isDark: isDark, ink: ink))),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Story {
  final String name, role, body;
  final int likes, comments;
  final Color color;
  const _Story(this.name, this.role, this.body, this.likes, this.comments, this.color);
}

class _Composer extends StatelessWidget {
  final WebShareExperienceController controller;
  final Color accent, ink;
  final bool isDark;
  const _Composer({required this.controller, required this.accent, required this.isDark, required this.ink});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D182C) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: accent.withValues(alpha: .2)),
          boxShadow: [BoxShadow(color: accent.withValues(alpha: .08), blurRadius: 30, offset: const Offset(0, 12))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 22, backgroundColor: accent.withValues(alpha: .2),
                child: Icon(Icons.person_rounded, color: accent)),
            const SizedBox(width: 12),
            Text('Share an experience…', style: TextStyle(fontWeight: FontWeight.w700, color: ink)),
          ]),
          const SizedBox(height: 14),
          TextField(
            maxLines: 4, minLines: 2,
            onChanged: controller.updatePostText,
            style: TextStyle(color: ink),
            decoration: InputDecoration(
              hintText: 'What did you try, learn, or change this week?',
              filled: true,
              fillColor: isDark ? const Color(0xFF14101F) : const Color(0xFFFAF8FB),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            for (final c in [Icons.image_rounded, Icons.tag_rounded, Icons.mood_rounded])
              Padding(padding: const EdgeInsets.only(right: 10), child: Icon(c, color: accent)),
            const Spacer(),
            Obx(() => Text('${controller.postText.value.length} chars', style: TextStyle(color: ink.withValues(alpha: .5)))),
            const SizedBox(width: 12),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: accent, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14)),
              onPressed: () {},
              child: const Text('Publish'),
            ),
          ]),
        ]),
      );
}

class _StoryCard extends StatelessWidget {
  final _Story s;
  final bool isDark;
  final Color ink;
  const _StoryCard({required this.s, required this.isDark, required this.ink});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D182C) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [s.color, s.color.withValues(alpha: .6)])),
              child: Center(child: Text(s.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.name, style: TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 16)),
              Text(s.role, style: TextStyle(color: ink.withValues(alpha: .6), fontSize: 12)),
            ]),
          ]),
          const SizedBox(height: 14),
          Text(s.body, style: TextStyle(color: ink.withValues(alpha: .9), fontSize: 16, height: 1.55)),
          const SizedBox(height: 16),
          Row(children: [
            Icon(Icons.favorite_border_rounded, color: s.color, size: 18),
            const SizedBox(width: 4),
            Text('${s.likes}', style: TextStyle(color: ink.withValues(alpha: .7), fontWeight: FontWeight.w600)),
            const SizedBox(width: 18),
            Icon(Icons.mode_comment_outlined, color: s.color, size: 18),
            const SizedBox(width: 4),
            Text('${s.comments}', style: TextStyle(color: ink.withValues(alpha: .7), fontWeight: FontWeight.w600)),
            const Spacer(),
            Icon(Icons.bookmark_border_rounded, color: ink.withValues(alpha: .6)),
          ]),
        ]),
      );
}
