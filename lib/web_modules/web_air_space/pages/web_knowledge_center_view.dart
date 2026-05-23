// REWRITE — Rich knowledge library with search, filters, masonry.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_knowledge_center_controller.dart';

class WebKnowledgeCenterView extends GetView<WebKnowledgeCenterController> {
  const WebKnowledgeCenterView({super.key});
  static const String routeName = '/web-air-space/knowledge-center';

  static const _cats = [
    'All Assets', 'Research', 'Playbooks', 'Datasets', 'Briefs', 'Templates'
  ];
  static const _assets = [
    _Asset('Operating Compass v4', 'Playbooks', 'Aligning decisions to AIR rhythms.', 280, Icons.explore_rounded),
    _Asset('Field Survey 2026', 'Research', 'What 3,200 operators reported this quarter.', 420, Icons.science_rounded),
    _Asset('Stakeholder Brief', 'Briefs', 'A short, repeatable update template that travels well.', 180, Icons.article_rounded),
    _Asset('Pricing Lookup Table', 'Datasets', 'Region × Tier × Channel pricing in one CSV.', 240, Icons.table_chart_rounded),
    _Asset('Onboarding Flight Plan', 'Templates', '14 days from invite to first contribution.', 320, Icons.rocket_launch_rounded),
    _Asset('Safety Reflex Manual', 'Playbooks', 'Decision drills for incident first responders.', 360, Icons.health_and_safety_rounded),
    _Asset('Glossary of AIR Terms', 'Research', 'Plain-language definitions, curated and versioned.', 200, Icons.translate_rounded),
    _Asset('KPI Cockpit Spec', 'Briefs', 'A reference design for org dashboards.', 260, Icons.speed_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('air_space');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF0B132B) : const Color(0xFFF4F6FB);
    final ink = isDark ? Colors.white : const Color(0xFF0F172A);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: Obx(() {
          final q = controller.activeCategory.value;
          final filtered = q == 'All Assets'
              ? _assets
              : _assets.where((a) => a.tag == q).toList();
          return CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 320,
              backgroundColor: bg,
              flexibleSpace: FlexibleSpaceBar(
                background: GlowBackground(
                  colors: [accent, accent.withValues(alpha: .55), const Color(0xFF0B132B)],
                  child: WMaxWidth(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Reveal(child: Text('KNOWLEDGE CENTER',
                            style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                        const SizedBox(height: 10),
                        Reveal(delayMs: 100, child: Text('The library that thinks with you.',
                            style: TextStyle(color: Colors.white, fontSize: WBreak.isMobile(context) ? 28 : 46, fontWeight: FontWeight.w800))),
                        const SizedBox(height: 18),
                        Reveal(
                          delayMs: 220,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(99),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 20, offset: const Offset(0, 8))],
                            ),
                            child: Row(children: [
                              Icon(Icons.search_rounded, color: accent),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  onChanged: controller.setCategory,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search papers, reports, datasets…',
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: WMaxWidth(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Wrap(spacing: 10, runSpacing: 10, children: [
                  for (final c in _cats)
                    _Chip(label: c, active: c == q, color: accent,
                        onTap: () => controller.setCategory(c)),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: WMaxWidth(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: [
                  _Metric(label: 'Indexed', value: 128, accent: accent, ink: ink),
                  const SizedBox(width: 16),
                  _Metric(label: 'Collections', value: 24, accent: accent, ink: ink),
                  const SizedBox(width: 16),
                  _Metric(label: 'Signal', value: 5, accent: accent, ink: ink, suffix: '/5'),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 80),
              sliver: SliverToBoxAdapter(
                child: WMaxWidth(
                  child: LayoutBuilder(builder: (_, c) {
                    final cols = c.maxWidth > 1000 ? 3 : c.maxWidth > 640 ? 2 : 1;
                    return Wrap(
                      spacing: 18, runSpacing: 18,
                      children: [
                        for (var i = 0; i < filtered.length; i++)
                          SizedBox(
                            width: (c.maxWidth - (cols - 1) * 18) / cols,
                            child: Reveal(
                              delayMs: 60 * i,
                              child: HoverLift(
                                child: _AssetCard(a: filtered[i], accent: accent, isDark: isDark),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}

class _Asset {
  final String title, tag, blurb;
  final int reads;
  final IconData icon;
  const _Asset(this.title, this.tag, this.blurb, this.reads, this.icon);
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.active, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: active ? color : color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(99),
          child: InkWell(
            borderRadius: BorderRadius.circular(99),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(label, style: TextStyle(color: active ? Colors.white : color, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      );
}

class _Metric extends StatelessWidget {
  final String label;
  final num value;
  final Color accent, ink;
  final String suffix;
  const _Metric({required this.label, required this.value, required this.accent, required this.ink, this.suffix = ''});
  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF131A35) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withValues(alpha: .15)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CountUp(value, suffix: suffix, style: TextStyle(color: ink, fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: ink.withValues(alpha: .6))),
          ]),
        ),
      );
}

class _AssetCard extends StatelessWidget {
  final _Asset a;
  final Color accent;
  final bool isDark;
  const _AssetCard({required this.a, required this.accent, required this.isDark});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131A35) : Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: accent.withValues(alpha: .12), borderRadius: BorderRadius.circular(12)),
              child: Icon(a.icon, color: accent),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: accent.withValues(alpha: .12), borderRadius: BorderRadius.circular(99)),
              child: Text(a.tag, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 12)),
            ),
          ]),
          const SizedBox(height: 16),
          Text(a.title, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 19, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(a.blurb, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, height: 1.5)),
          const SizedBox(height: 16),
          Row(children: [
            Icon(Icons.menu_book_rounded, size: 16, color: accent),
            const SizedBox(width: 6),
            Text('${a.reads} reads', style: TextStyle(color: accent, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text('Open →', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          ]),
        ]),
      );
}
