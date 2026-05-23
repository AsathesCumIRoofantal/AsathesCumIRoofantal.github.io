// ============================================================
// web_modules/web_explore_page.dart
// Route: /web-explore  →  WebExplorePage
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_web_layout.dart';

class WebExplorePage extends StatefulWidget {
  const WebExplorePage({super.key});

  static const String routeName = '/web-explore';

  @override
  State<WebExplorePage> createState() => _WebExplorePageState();
}

class _WebExplorePageState extends State<WebExplorePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  static final _tracks = [
    _Track(
      icon: Icons.lightbulb_outline,
      title: 'Learn & Fun',
      tag: 'Interactive',
      level: 'Beginner',
      desc:
          'Playful, engaging modules that turn curiosity into capability. '
          'Learn by doing — quizzes, micro-challenges, and discovery games.',
      color: WColors.amber,
      lessons: 24,
    ),
    _Track(
      icon: Icons.menu_book_outlined,
      title: 'Learn Docs',
      tag: 'Reference',
      level: 'All Levels',
      desc:
          'Category-organised documentation. Every topic in All-Space has '
          'a structured doc entry — find any concept in seconds.',
      color: WColors.indigo,
      lessons: 80,
    ),
    _Track(
      icon: Icons.school_outlined,
      title: 'Higher Studies',
      tag: 'Academic',
      level: 'Advanced',
      desc:
          'University-grade exploration of AIR\'s deepest concepts — '
          'from space mathematics to organisational philosophy.',
      color: WColors.teal,
      lessons: 36,
    ),
    _Track(
      icon: Icons.local_hospital_rounded,
      title: 'Doctorate',
      tag: 'Research',
      level: 'Expert',
      desc:
          'Original research methodology, thesis scaffolding, and '
          'peer-reviewed submission within the AIR knowledge network.',
      color: WColors.violet,
      lessons: 12,
    ),
    _Track(
      icon: Icons.heat_pump_rounded,
      title: 'Life Hacks',
      tag: 'Practical',
      level: 'Everyday',
      desc:
          'Distilled shortcuts and time-tested techniques that make '
          'daily life inside All-Space dramatically more efficient.',
      color: WColors.rose,
      lessons: 42,
    ),
    _Track(
      icon: Icons.question_answer_rounded,
      title: 'Ask Anything',
      tag: 'Q&A',
      level: 'All Levels',
      desc:
          'Post any question to the AIR community. Expert moderators '
          'surface the best answers and build a living FAQ.',
      color: WColors.emerald,
      lessons: 0,
    ),
  ];

  List<_Track> get _filtered => _search.isEmpty
      ? _tracks
      : _tracks
            .where(
              (t) =>
                  t.title.toLowerCase().contains(_search.toLowerCase()) ||
                  t.desc.toLowerCase().contains(_search.toLowerCase()),
            )
            .toList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'EXPLORE  ·  LEARN', color: WColors.amber),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero
            WHeroBanner(
              title: 'Explore. Study. Grow.',
              subtitle:
                  'From bite-sized life hacks to full doctorate research — '
                  'the Alifiyas learning ecosystem has a path for every mind.',
              colorA: const Color(0xFFB45309),
              colorB: const Color(0xFFD97706),
              icon: Icons.explore_rounded,
            ),

            const SizedBox(height: 32),

            // Search bar
            WMaxWidth(
              child: TextField(
                onChanged: (v) => setState(() => _search = v),
                decoration: InputDecoration(
                  hintText: 'Search learning tracks…',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: isDark ? WColors.cardDark : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Track grid
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WSectionHeader(
                    eyebrow: 'Learning Tracks',
                    title: 'Choose your path',
                    accent: WColors.amber,
                  ),
                  const SizedBox(height: 24),
                  if (_filtered.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          'No tracks match "$_search"',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    WGrid(
                      children: _filtered
                          .map((t) => _TrackCard(t: t, isDark: isDark))
                          .toList(),
                    ),
                ],
              ),
            ),

            // Progress panel
            const SizedBox(height: 40),
            Container(
              color: isDark ? const Color(0xFF1C1917) : const Color(0xFFFFFBEB),
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WSectionHeader(
                      eyebrow: 'Your Journey',
                      title: 'Progress at a Glance',
                      accent: WColors.amber,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: WStatChip(
                            value: '7',
                            label: 'Modules\nCompleted',
                            color: WColors.amber,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: WStatChip(
                            value: '3',
                            label: 'In\nProgress',
                            color: WColors.teal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: WStatChip(
                            value: '94',
                            label: 'Items\nBookmarked',
                            color: WColors.violet,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ── Data & widgets ────────────────────────────────────────────
class _Track {
  final IconData icon;
  final String title;
  final String tag;
  final String level;
  final String desc;
  final Color color;
  final int lessons;
  const _Track({
    required this.icon,
    required this.title,
    required this.tag,
    required this.level,
    required this.desc,
    required this.color,
    required this.lessons,
  });
}

class _TrackCard extends StatelessWidget {
  final _Track t;
  final bool isDark;
  const _TrackCard({required this.t, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (t.title == 'Learn & Fun') {
          // Get.toNamed('/web-explore/learn-and-fun');
          //return;
        } else if (t.title == 'Life Hacks') {
          Get.toNamed('/web-explore/life-hacks');
          return;
        } else {
          Get.toNamed(
            '/web-explore/module',
            arguments: {
              'title': t.title,
              'tag': t.tag,
              'level': t.level,
              'desc': t.desc,
              'color': t.color,
              'lessons': t.lessons,
            },
          );
          return;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : WColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: t.color.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: t.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(t.icon, color: t.color, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WBadge(label: t.tag, color: t.color),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              t.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              t.desc,
              style: TextStyle(
                fontSize: 13,
                height: 1.55,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.signal_cellular_alt_rounded,
                  size: 14,
                  color: isDark ? Colors.white38 : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  t.level,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.grey,
                  ),
                ),
                if (t.lessons > 0) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.layers_rounded,
                    size: 14,
                    color: isDark ? Colors.white38 : Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${t.lessons} lessons',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.grey,
                    ),
                  ),
                ],
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: t.color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Open →',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
