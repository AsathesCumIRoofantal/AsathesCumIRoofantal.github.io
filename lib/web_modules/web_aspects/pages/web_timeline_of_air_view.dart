// REWRITE — Zigzag vertical timeline of AIR milestones.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_timeline_of_air_controller.dart';

class WebTimelineOfAirView extends GetView<WebTimelineOfAirController> {
  const WebTimelineOfAirView({super.key});
  static const String routeName = '/web-aspects/timeline-of-air';

  static const _years = ['2022', '2023', '2024', '2025', '2026'];
  static const _events = [
    _Tev('2022', 'Seed of a system', 'A small team writes the first AIR principles in a single doc.', Icons.eco_rounded),
    _Tev('2023', 'First circles', 'Three cohorts test the rituals in real teams. We learn what fails first.', Icons.groups_2_rounded),
    _Tev('2024', 'Tools take shape', 'A pilot app gives the rituals a daily home. Habits stick. We start measuring.', Icons.handyman_rounded),
    _Tev('2025', 'Open the gates', 'AIR opens to operators across regions. The library doubles every quarter.', Icons.public_rounded),
    _Tev('2026', 'Multi-surface AIR', 'Flutter web, desktop, and mobile share one design system. You are reading the result.', Icons.devices_other_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final section = WebNavData.bySlug('aspects');
    final accent = section.primary;
    final bg = isDark ? const Color(0xFF0A1B17) : const Color(0xFFF3FBF7);
    final ink = isDark ? Colors.white : const Color(0xFF0F2A23);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true, expandedHeight: 300, backgroundColor: bg,
            flexibleSpace: FlexibleSpaceBar(
              background: GlowBackground(
                colors: [accent, const Color(0xFF14B8A6), const Color(0xFF0A1B17)],
                child: WMaxWidth(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Reveal(child: Text('TIMELINE OF AIR',
                          style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 8),
                      Reveal(delayMs: 100, child: Text('A story told in five quiet years.',
                          style: TextStyle(color: Colors.white, fontSize: WBreak.isMobile(context) ? 28 : 44, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // year strip
          SliverToBoxAdapter(
            child: WMaxWidth(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (final y in _years)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(y),
                            selected: controller.activeYear.value == y,
                            onSelected: (_) => controller.setYear(y),
                            selectedColor: accent,
                            labelStyle: TextStyle(
                              color: controller.activeYear.value == y ? Colors.white : ink,
                              fontWeight: FontWeight.w800,
                            ),
                            backgroundColor: accent.withValues(alpha: .12),
                            side: BorderSide.none,
                          ),
                        ),
                    ]),
                  )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 18, 0, 100),
            sliver: SliverList.builder(
              itemCount: _events.length,
              itemBuilder: (_, i) => WMaxWidth(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Reveal(delayMs: 80 * i, child: _Row(e: _events[i], leftSide: i.isEven, accent: accent, isDark: isDark, ink: ink, last: i == _events.length - 1)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Tev {
  final String year, title, body;
  final IconData icon;
  const _Tev(this.year, this.title, this.body, this.icon);
}

class _Row extends StatelessWidget {
  final _Tev e;
  final bool leftSide, isDark, last;
  final Color accent, ink;
  const _Row({required this.e, required this.leftSide, required this.accent, required this.isDark, required this.ink, required this.last});
  @override
  Widget build(BuildContext context) {
    final mobile = WBreak.isMobile(context);
    final card = HoverLift(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF12241F) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accent.withValues(alpha: .18)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: accent.withValues(alpha: .15), borderRadius: BorderRadius.circular(12)),
              child: Icon(e.icon, color: accent),
            ),
            const SizedBox(width: 12),
            Text(e.year, style: TextStyle(color: accent, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ]),
          const SizedBox(height: 12),
          Text(e.title, style: TextStyle(color: ink, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(e.body, style: TextStyle(color: ink.withValues(alpha: .75), height: 1.5)),
        ]),
      ),
    );
    final dot = Column(children: [
      Container(width: 16, height: 16,
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: accent.withValues(alpha: .5), blurRadius: 18)])),
      if (!last) Container(width: 2, height: 110, color: accent.withValues(alpha: .25)),
    ]);
    if (mobile) {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.only(top: 6), child: dot),
        const SizedBox(width: 14),
        Expanded(child: card),
      ]);
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: leftSide ? card : const SizedBox()),
      const SizedBox(width: 16),
      Padding(padding: const EdgeInsets.only(top: 12), child: dot),
      const SizedBox(width: 16),
      Expanded(child: !leftSide ? card : const SizedBox()),
    ]);
  }
}
