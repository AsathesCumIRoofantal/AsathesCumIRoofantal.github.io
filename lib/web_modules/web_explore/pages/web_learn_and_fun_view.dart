// REWRITE — Playful bento grid of learning capsules.
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_learn_and_fun_controller.dart';

class WebLearnAndFunView extends GetView<WebLearnAndFunController> {
  const WebLearnAndFunView({super.key});
  static const String routeName = '/web-explore/learn-and-fun';

  static const _capsules = [
    _Cap(
      'Mini Lab',
      'Run a 60-second experiment to test a tiny hypothesis.',
      Icons.science_rounded,
      Color(0xFFFF6B6B),
      2,
    ),
    _Cap(
      'Story Mode',
      'A 4-card narrative that teaches a single idea.',
      Icons.auto_stories_rounded,
      Color(0xFF8B5CF6),
      1,
    ),
    _Cap(
      'Puzzle',
      'Drag, drop, and discover the pattern.',
      Icons.extension_rounded,
      Color(0xFF06B6D4),
      1,
    ),
    _Cap(
      'Daily Spark',
      'A tiny question that wakes up curiosity.',
      Icons.lightbulb_rounded,
      Color(0xFFFACC15),
      1,
    ),
    _Cap(
      'Sketchpad',
      'Visual scratchpad with playful constraints.',
      Icons.brush_rounded,
      Color(0xFFEC4899),
      2,
    ),
    _Cap(
      'Trivia Tower',
      'Stack right answers, dodge wrong ones.',
      Icons.casino_rounded,
      Color(0xFF22C55E),
      1,
    ),
    _Cap(
      'Sound Walk',
      'Audio prompts that pace your reading.',
      Icons.graphic_eq_rounded,
      Color(0xFFF97316),
      1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('explore');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF111027) : const Color(0xFFFFFBF2);
    final ink = isDark ? Colors.white : const Color(0xFF1C1C2E);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GlowBackground(
                colors: [
                  accent,
                  const Color(0xFFEC4899),
                  const Color(0xFF8B5CF6),
                ],
                child: WMaxWidth(
                  padding: const EdgeInsets.fromLTRB(24, 80, 24, 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Reveal(
                        child: _Bouncing(
                          child: const _Sticker('LEARN · FUN · REPEAT'),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Reveal(
                        delayMs: 120,
                        child: Text(
                          'Curiosity, but with snacks.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: WBreak.isMobile(context) ? 32 : 56,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Reveal(
                        delayMs: 240,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Text(
                            'Bite-sized learning capsules. Tap one. Stay 90 seconds. Leave smarter (or at least lighter).',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: .9),
                              fontSize: 17,
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
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
              sliver: SliverToBoxAdapter(
                child: WMaxWidth(
                  child: LayoutBuilder(
                    builder: (_, c) {
                      final cols = c.maxWidth > 980
                          ? 4
                          : c.maxWidth > 640
                          ? 3
                          : 2;
                      final unit = (c.maxWidth - (cols - 1) * 16) / cols;
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (var i = 0; i < _capsules.length; i++)
                            SizedBox(
                              width:
                                  unit * (_capsules[i].size.clamp(1, cols)) +
                                  (_capsules[i].size - 1) * 16,
                              height: 200.0 + (i.isEven ? 30 : 0),
                              child: Reveal(
                                delayMs: 80 * i,
                                child: HoverLift(
                                  child: _CapTile(
                                    c: _capsules[i],
                                    ink: ink,
                                    isDark: isDark,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: _chatGptsFavorSection(context, controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chatGptsFavorSection(
  BuildContext context,
  WebLearnAndFunController controller,
) {
  return Obx(() {
    if (controller.isLoadingConsent.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🌟 ChatGPT's Favour",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        Text(
          "Handpicked explorations for curious minds.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (_, constraints) {
            final isDesktop = constraints.maxWidth > 1000;

            final isTablet = constraints.maxWidth > 650;

            final crossAxisCount = isDesktop
                ? 4
                : isTablet
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.chatGptsFavor.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (_, index) {
                final item = controller.chatGptsFavor[index];

                return Card(
                  elevation: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Icon(item.icon, size: 34),

                          const SizedBox(height: 12),

                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),

                          const SizedBox(height: 8),

                          Expanded(
                            child: Text(
                              item.description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  });
}

class _Cap {
  final String title, blurb;
  final IconData icon;
  final Color color;
  final int size;
  const _Cap(this.title, this.blurb, this.icon, this.color, this.size);
}

class _CapTile extends StatelessWidget {
  final _Cap c;
  final Color ink;
  final bool isDark;
  const _CapTile({required this.c, required this.ink, required this.isDark});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          c.color.withValues(alpha: .95),
          c.color.withValues(alpha: .65),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -10,
          bottom: -10,
          child: Icon(
            c.icon,
            size: 110,
            color: Colors.white.withValues(alpha: .15),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(c.icon, color: Colors.white),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  c.blurb,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class _Sticker extends StatelessWidget {
  final String text;
  const _Sticker(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(99),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .15),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        letterSpacing: 2,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

class _Bouncing extends StatefulWidget {
  final Widget child;
  const _Bouncing({required this.child});
  @override
  State<_Bouncing> createState() => _BouncingState();
}

class _BouncingState extends State<_Bouncing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (_, child) => Transform.translate(
      offset: Offset(0, math.sin(_c.value * math.pi * 2) * 4),
      child: child,
    ),
    child: widget.child,
  );
}
