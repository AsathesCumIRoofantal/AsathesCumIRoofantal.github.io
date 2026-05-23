// REWRITE — Rich reflective reading view.
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_wisdom_internal_controller.dart';

class WebWisdomInternalView extends GetView<WebWisdomInternalController> {
  const WebWisdomInternalView({super.key});
  static const String routeName = '/web-wisdom/wisdom';

  static const _chapters = [
    _Chapter(
      'I',
      'On Stillness',
      'Wisdom begins when the noise of opinion stops competing with the rhythm of attention. A page can carry stillness.',
      Icons.self_improvement_rounded,
    ),
    _Chapter(
      'II',
      'On Decision',
      'A good decision is rarely the loudest one. AIR teaches: pause, observe the field, then act with calibrated force.',
      Icons.balance_rounded,
    ),
    _Chapter(
      'III',
      'On Continuity',
      'Wisdom held alone fades. Wisdom written, indexed and re-read becomes infrastructure for everyone who follows.',
      Icons.all_inclusive_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('wisdom');
    final bg = isDark ? const Color(0xFF0E0B1F) : const Color(0xFFFAF7F0);
    final ink = isDark ? Colors.white : const Color(0xFF1B1330);

    return WebShell(
      currentRoute: routeName,
      child: Obx(
        () => Scaffold(
          backgroundColor: bg,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 360,
                pinned: true,
                stretch: true,
                backgroundColor: bg,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: GlowBackground(
                    colors: [
                      section.primary,
                      section.primary.withValues(alpha: .55),
                      const Color(0xFF2A1450),
                    ],
                    child: Center(
                      child: WMaxWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Reveal(
                              child: Text(
                                'A QUIET READING ROOM',
                                style: TextStyle(
                                  letterSpacing: 4,
                                  color: Colors.white.withValues(alpha: .8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Reveal(
                              delayMs: 120,
                              child: Text(
                                'Wisdom, in three movements.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: WBreak.isMobile(context) ? 32 : 56,
                                  fontWeight: FontWeight.w800,
                                  height: 1.05,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Reveal(
                              delayMs: 240,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 640,
                                ),
                                child: Text(
                                  'A long-form surface built with Flutter slivers. Calm typography, paced motion, persistent chapter index.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: .85),
                                    fontSize: 16,
                                    height: 1.55,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // chapter rail
              SliverPersistentHeader(
                pinned: true,
                delegate: _ChapterRail(
                  currentPage: controller.currentPage.value,
                  chapters: _chapters,
                  onTap: controller.setPage,
                  accent: section.primary,
                  bg: bg,
                  ink: ink,
                ),
              ),

              // chapters
              ..._chapters.asMap().entries.expand((e) sync* {
                final i = e.key;
                final ch = e.value;
                yield SliverToBoxAdapter(
                  child: VisibilityDetectorStub(
                    onVisible: () => controller.setPage(i),
                    child: WMaxWidth(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 48,
                      ),
                      child: Reveal(
                        delayMs: 60,
                        child: _ChapterBlock(
                          chapter: ch,
                          accent: section.primary,
                          ink: ink,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(
                child: WMaxWidth(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 96),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          section.primary.withValues(alpha: .12),
                          section.primary.withValues(alpha: .02),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: section.primary.withValues(alpha: .25),
                      ),
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          Icon(Icons.menu_book_rounded, color: section.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'You are reading chapter ${controller.currentPage.value + 1} of ${_chapters.length}. Progress persists via GetX state.',
                              style: TextStyle(
                                color: ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chapter {
  final String roman, title, body;
  final IconData icon;
  const _Chapter(this.roman, this.title, this.body, this.icon);
}

class _ChapterBlock extends StatelessWidget {
  final _Chapter chapter;
  final Color accent, ink;
  const _ChapterBlock({
    required this.chapter,
    required this.accent,
    required this.ink,
  });
  @override
  Widget build(BuildContext context) {
    final mobile = WBreak.isMobile(context);
    final left = SizedBox(
      width: mobile ? double.infinity : 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [accent, accent.withValues(alpha: .6)],
              ),
            ),
            child: Center(
              child: Text(
                chapter.roman,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Icon(chapter.icon, color: accent, size: 32),
        ],
      ),
    );
    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chapter.title,
          style: TextStyle(
            color: ink,
            fontSize: mobile ? 28 : 40,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          chapter.body,
          style: TextStyle(
            color: ink.withValues(alpha: .75),
            fontSize: 18,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final tag in ['practice', 'reflect', 'apply'])
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: accent.withValues(alpha: .3)),
                ),
                child: Text(
                  tag,
                  style: TextStyle(color: accent, fontWeight: FontWeight.w700),
                ),
              ),
          ],
        ),
      ],
    );
    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [left, const SizedBox(height: 24), right],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              const SizedBox(width: 32),
              Expanded(child: right),
            ],
          );
  }
}

class _ChapterRail extends SliverPersistentHeaderDelegate {
  final int currentPage;
  final List<_Chapter> chapters;
  final Color accent, bg, ink;
  final ValueChanged<int> onTap;

  _ChapterRail({
    required this.currentPage,
    required this.chapters,
    required this.accent,
    required this.bg,
    required this.ink,
    required this.onTap,
  });

  @override
  double get maxExtent => 88;
  @override
  double get minExtent => 88;

  @override
  bool shouldRebuild(covariant _ChapterRail oldDelegate) {
    return oldDelegate.currentPage != currentPage ||
        oldDelegate.chapters != chapters ||
        oldDelegate.accent != accent ||
        oldDelegate.bg != bg ||
        oldDelegate.ink != ink;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: bg.withValues(alpha: .95),
      child: SizedBox.expand(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemCount: chapters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, i) {
            final selected = currentPage == i;

            return GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected ? accent : accent.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      chapters[i].roman,
                      style: TextStyle(
                        color: selected ? Colors.white : accent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      chapters[i].title,
                      style: TextStyle(
                        color: selected ? Colors.white : ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Minimal hand-rolled "visible" trigger (no extra dependency).
class VisibilityDetectorStub extends StatefulWidget {
  final Widget child;
  final VoidCallback onVisible;
  const VisibilityDetectorStub({
    super.key,
    required this.child,
    required this.onVisible,
  });
  @override
  State<VisibilityDetectorStub> createState() => _VisibilityDetectorStubState();
}

class _VisibilityDetectorStubState extends State<VisibilityDetectorStub> {
  bool _fired = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_fired || !mounted) return;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) return;
      final pos = box.localToGlobal(Offset.zero).dy;
      final h = MediaQuery.of(context).size.height;
      if (pos < h * .6) {
        _fired = true;
        widget.onVisible();
      }
    });
    return widget.child;
  }
}
