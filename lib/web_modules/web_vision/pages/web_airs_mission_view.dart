import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_airs_mission_controller.dart';

class WebAirsMissionView extends GetView<WebAirsMissionController> {
  static const routeName = '/web-vision/airs-mission';
  const WebAirsMissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFFBEB),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebAirsMissionController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _spinCtrl;
  late AnimationController _entryCtrl;
  late Animation<double> _scaleAnim;

  static const _pillars = [
    ('Empower Minds', 'Equip every member with tools, knowledge, and confidence to navigate life purposefully.', Icons.psychology_rounded, Color(0xFFD4AF37)),
    ('Build Community', 'Foster a network of trust, reciprocity, and shared growth across all spaces.', Icons.people_alt_rounded, Color(0xFFEA580C)),
    ('Innovate Honestly', 'Champion technologies and systems that serve human dignity, not only efficiency.', Icons.lightbulb_rounded, Color(0xFF059669)),
    ('Sustain Progress', 'Ensure every gain is durable — anchored in ethics, environment, and equity.', Icons.eco_rounded, Color(0xFF0284C7)),
  ];

  static const _commitments = [
    'Never compromise member dignity for institutional growth',
    'Maintain radical transparency about decisions and data',
    'Prioritise long-term wellbeing over short-term metrics',
    'Welcome dissent and course-correct with humility',
    'Resource the under-resourced before scaling the already-served',
  ];

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
    _scaleAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() { _spinCtrl.dispose(); _entryCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 360,
          pinned: true,
          backgroundColor: const Color(0xFF78350F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("AIR's Mission", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
            background: AnimatedBuilder(
              animation: _spinCtrl,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1C1917), Color(0xFF78350F), Color(0xFFD4AF37)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  // Spinning ring
                  Positioned(right: 30, top: 30,
                    child: Transform.rotate(
                      angle: _spinCtrl.value * math.pi * 2,
                      child: Container(
                        width: 160, height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.04), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFD4AF37).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                          child: const Text('Mission · Priorities · Commitments', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 12),
                        const Text("AIR's\nMission", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, height: 1.2)),
                        const SizedBox(height: 10),
                        Text('Statements, priorities, and non-negotiable commitments that define AIR.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13, height: 1.4)),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),

        // Mission statement big
        SliverToBoxAdapter(
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF1C1917), Color(0xFF292524)]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(children: [
                  const Icon(Icons.format_quote_rounded, color: Color(0xFFD4AF37), size: 32),
                  const SizedBox(height: 14),
                  const Text(
                    'To build a shared space where every person can find purpose, grow capabilities, and contribute meaningfully to the world around them — without leaving anyone behind.',
                    style: TextStyle(color: Colors.white, fontSize: 15, height: 1.7, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text('— AIR Organisation', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.w800, fontSize: 13)),
                ]),
              ),
            ),
          ),
        ),

        // Pillars
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Mission Pillars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 340, childAspectRatio: 1.1, crossAxisSpacing: 12, mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i >= _pillars.length) return null;
                final p = _pillars[i];
                return Obx(() {
                  final active = widget.ctrl.activePillar.value == i;
                  return GestureDetector(
                    onTap: () => widget.ctrl.activePillar.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: active ? p.$4 : (widget.isDark ? WColors.cardDark : Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: p.$4.withValues(alpha: active ? 0 : 0.25)),
                        boxShadow: active ? [BoxShadow(color: p.$4.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 6))] : [],
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Icon(p.$3, color: active ? Colors.white : p.$4, size: 28),
                        const Spacer(),
                        Text(p.$1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: active ? Colors.white : (widget.isDark ? Colors.white : const Color(0xFF0F172A)))),
                        const SizedBox(height: 6),
                        Text(p.$2, style: TextStyle(fontSize: 12, height: 1.4, color: active ? Colors.white.withValues(alpha: 0.85) : (widget.isDark ? Colors.white54 : Colors.black45)), maxLines: 3, overflow: TextOverflow.ellipsis),
                      ]),
                    ),
                  );
                });
              },
              childCount: _pillars.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Non-negotiables
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF78350F), Color(0xFFD4AF37)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Non-Negotiables', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                const SizedBox(height: 14),
                ..._commitments.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(Icons.check_circle_rounded, size: 16, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(child: Text(c, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, height: 1.4))),
                  ]),
                )),
              ]),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
