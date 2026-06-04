// REWRITE — Pipeline / kanban view with horizontal scroll + stage cards.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_process_controller.dart';

class WebProcessView extends GetView<WebProcessController> {
  const WebProcessView({super.key});
  static const String routeName = '/web-service/process';

  static const _pipelines = ['Standard Delivery', 'Rush Lane', 'Onboarding'];
  static const _stages = [
    _Stage('Intake', Color(0xFF60A5FA), [
      _Card('A-104', 'Northwind quarterly brief', 'Just received'),
      _Card('A-118', 'Beta access for partner', 'New'),
    ]),
    _Stage('Triage', Color(0xFF818CF8), [
      _Card('A-100', 'Renew enterprise license', 'Owner · Eli'),
    ]),
    _Stage('In Progress', Color(0xFFFB923C), [
      _Card('A-091', 'Draft Q3 retrospective', 'Owner · Mia'),
      _Card('A-088', 'Update knowledge index', 'Owner · Kenji'),
      _Card('A-085', 'Map dependencies', 'Owner · Anaya'),
    ]),
    _Stage('Review', Color(0xFFFACC15), [
      _Card('A-079', 'Stakeholder digest', 'With Marta'),
    ]),
    _Stage('Done', Color(0xFF22C55E), [
      _Card('A-070', 'Closed onboarding loop', 'Shipped'),
      _Card('A-061', 'Pricing sheet update', 'Shipped'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('service');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF0F141E) : const Color(0xFFF1F4F9);
    final ink = isDark ? Colors.white : const Color(0xFF0F172A);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true, expandedHeight: 260, backgroundColor: bg,
            flexibleSpace: FlexibleSpaceBar(
              background: GlowBackground(
                colors: [accent, const Color(0xFF0EA5E9), const Color(0xFF0F141E)],
                child: WMaxWidth(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Reveal(child: Text('PROCESS · PIPELINE',
                          style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 8),
                      Reveal(delayMs: 100, child: Text('Throughput, without the chaos.',
                          style: TextStyle(color: Colors.white, fontSize: WBreak.isMobile(context) ? 28 : 44, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: WMaxWidth(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
              child: Reveal(
                child: Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        for (final p in _pipelines)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(p),
                              selected: controller.activePipeline.value == p,
                              onSelected: (_) => controller.setPipeline(p),
                              selectedColor: accent,
                              labelStyle: TextStyle(
                                color: controller.activePipeline.value == p ? Colors.white : ink,
                                fontWeight: FontWeight.w700,
                              ),
                              backgroundColor: accent.withValues(alpha: .1),
                              side: BorderSide.none,
                            ),
                          ),
                      ]),
                    )),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: WMaxWidth(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
              child: Row(children: [
                _Stat(label: 'Active', value: '15', accent: accent, isDark: isDark),
                const SizedBox(width: 12),
                _Stat(label: 'SLA', value: '99.2%', accent: accent, isDark: isDark),
                const SizedBox(width: 12),
                _Stat(label: 'Avg cycle', value: '2.3d', accent: accent, isDark: isDark),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 22, 0, 80),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (var i = 0; i < _stages.length; i++) ...[
                    SizedBox(
                      width: 300,
                      child: Reveal(delayMs: 80 * i, child: _StageCol(s: _stages[i], isDark: isDark, ink: ink)),
                    ),
                    if (i < _stages.length - 1) const SizedBox(width: 16),
                  ],
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Stage {
  final String name;
  final Color color;
  final List<_Card> cards;
  const _Stage(this.name, this.color, this.cards);
}

class _Card {
  final String id, title, meta;
  const _Card(this.id, this.title, this.meta);
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color accent;
  final bool isDark;
  const _Stat({required this.label, required this.value, required this.accent, required this.isDark});
  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF182032) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accent.withValues(alpha: .12)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: TextStyle(color: accent, fontSize: 22, fontWeight: FontWeight.w900)),
            Text(label, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
          ]),
        ),
      );
}

class _StageCol extends StatelessWidget {
  final _Stage s;
  final bool isDark;
  final Color ink;
  const _StageCol({required this.s, required this.isDark, required this.ink});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131B2A) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: s.color.withValues(alpha: .25)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(s.name, style: TextStyle(color: ink, fontWeight: FontWeight.w900)),
            const Spacer(),
            Text('${s.cards.length}', style: TextStyle(color: ink.withValues(alpha: .6))),
          ]),
          const SizedBox(height: 12),
          for (final c in s.cards)
            HoverLift(
              radius: const BorderRadius.all(Radius.circular(14)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F1727) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.id, style: TextStyle(color: s.color, fontWeight: FontWeight.w800, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(c.title, style: TextStyle(color: ink, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(c.meta, style: TextStyle(color: ink.withValues(alpha: .6), fontSize: 12)),
                ]),
              ),
            ),
        ]),
      );
}
