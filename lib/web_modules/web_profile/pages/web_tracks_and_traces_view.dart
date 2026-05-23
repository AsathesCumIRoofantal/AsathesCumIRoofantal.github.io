// REWRITE — Activity ledger with heat ribbon and event timeline.
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_tracks_and_traces_controller.dart';

class WebTracksAndTracesView extends GetView<WebTracksAndTracesController> {
  const WebTracksAndTracesView({super.key});
  static const String routeName = '/web-profile/tracks-and-traces';

  static const _tabs = ['All Logs', 'Sessions', 'Posts', 'Reviews', 'Edits'];
  static const _events = [
    _Evt('09:42', 'Published brief', 'Weekly digest of three cross-team wins.', Icons.upload_rounded, 'Posts'),
    _Evt('09:18', 'Joined session', 'AIR Foundations · Cohort 12 · live discussion.', Icons.groups_rounded, 'Sessions'),
    _Evt('08:30', 'Reviewed proposal', 'Approved with two notes about scope.', Icons.fact_check_rounded, 'Reviews'),
    _Evt('Yesterday', 'Edited library entry', '“Operating Compass v4” → typography refresh.', Icons.edit_rounded, 'Edits'),
    _Evt('Yesterday', 'Saved trace', 'A long-form reflection on calmer decision making.', Icons.bookmark_added_rounded, 'Posts'),
    _Evt('Mon', 'Closed retrospective', '5 themes, 3 actions, 1 owner each.', Icons.task_alt_rounded, 'Sessions'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('profile');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF0C1424) : const Color(0xFFF1F5FB);
    final ink = isDark ? Colors.white : const Color(0xFF0F172A);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: Obx(() {
          final tab = controller.activeTab.value;
          final list = tab == 'All Logs' ? _events : _events.where((e) => e.kind == tab).toList();
          return CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true, expandedHeight: 260, backgroundColor: bg,
              flexibleSpace: FlexibleSpaceBar(
                background: GlowBackground(
                  colors: [accent, const Color(0xFF06B6D4), const Color(0xFF0C1424)],
                  child: WMaxWidth(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Reveal(child: Text('TRACKS · TRACES',
                            style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                        const SizedBox(height: 8),
                        Reveal(delayMs: 100, child: Text('Every move you’ve made, replayable.',
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
                child: Reveal(child: _HeatRibbon(accent: accent, isDark: isDark)),
              ),
            ),
            SliverToBoxAdapter(
              child: WMaxWidth(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    for (final t in _tabs)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text(t),
                          selected: t == tab,
                          onSelected: (_) => controller.setTab(t),
                          selectedColor: accent,
                          labelStyle: TextStyle(
                              color: t == tab ? Colors.white : ink,
                              fontWeight: FontWeight.w700),
                          backgroundColor: accent.withValues(alpha: .12),
                          side: BorderSide.none,
                        ),
                      ),
                  ]),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 80),
              sliver: SliverList.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => WMaxWidth(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Reveal(delayMs: 60 * i, child: _Trace(e: list[i], accent: accent, isDark: isDark, ink: ink, last: i == list.length - 1)),
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}

class _Evt {
  final String time, title, body, kind;
  final IconData icon;
  const _Evt(this.time, this.title, this.body, this.icon, this.kind);
}

class _Trace extends StatelessWidget {
  final _Evt e;
  final Color accent, ink;
  final bool isDark, last;
  const _Trace({required this.e, required this.accent, required this.isDark, required this.ink, required this.last});
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Column(children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(color: accent.withValues(alpha: .15), shape: BoxShape.circle),
              child: Icon(e.icon, color: accent, size: 18),
            ),
            if (!last) Expanded(child: Container(width: 2, color: accent.withValues(alpha: .15))),
          ]),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF101A30) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: accent.withValues(alpha: .1)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(e.time, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 12)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: accent.withValues(alpha: .1), borderRadius: BorderRadius.circular(99)),
                    child: Text(e.kind, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
                ]),
                const SizedBox(height: 6),
                Text(e.title, style: TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 4),
                Text(e.body, style: TextStyle(color: ink.withValues(alpha: .75))),
              ]),
            ),
          ),
        ]),
      );
}

class _HeatRibbon extends StatelessWidget {
  final Color accent;
  final bool isDark;
  const _HeatRibbon({required this.accent, required this.isDark});
  @override
  Widget build(BuildContext context) {
    final rng = math.Random(42);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101A30) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: .12)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Last 12 weeks', style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        LayoutBuilder(builder: (_, c) {
          const rows = 7;
          final cols = 24;
          final size = ((c.maxWidth - (cols - 1) * 4) / cols).clamp(8.0, 16.0);
          return Column(children: [
            for (var r = 0; r < rows; r++)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(children: [
                  for (var k = 0; k < cols; k++) ...[
                    Container(
                      width: size, height: size,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: rng.nextDouble() * 0.9 + 0.06),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    if (k < cols - 1) const SizedBox(width: 4),
                  ],
                ]),
              ),
          ]);
        }),
      ]),
    );
  }
}
