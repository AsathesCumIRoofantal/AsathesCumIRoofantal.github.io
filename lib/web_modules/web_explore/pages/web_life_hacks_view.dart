import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_life_hacks_controller.dart';

class WebLifeHacksView extends GetView<WebLifeHacksController> {
  static const routeName = '/web-explore/life-hacks';
  const WebLifeHacksView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF7ED),
        body: _Body(isDark: isDark, controller: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebLifeHacksController controller;
  const _Body({required this.isDark, required this.controller});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late List<AnimationController> _cardCtrls;
  final _items = WebNavData.bySlug('explore').items;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _cardCtrls = List.generate(_items.length, (i) =>
      AnimationController(vsync: this, duration: Duration(milliseconds: 400 + i * 60))
        ..forward());
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    for (final c in _cardCtrls) c.dispose();
    super.dispose();
  }

  static const _neonColors = [Color(0xFFFF6B35), Color(0xFF00D9C0), Color(0xFFFFD93D), Color(0xFF6BCB77), Color(0xFF4D96FF), Color(0xFFFF6B9D)];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: const Color(0xFFEA580C),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Life Hacks', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
            background: AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEA580C), Color(0xFF9A3412)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(children: [
                  ...List.generate(6, (i) {
                    final angle = (i / 6) * math.pi * 2 + _pulseCtrl.value * math.pi;
                    final r = 80.0 + i * 30;
                    return Positioned(
                      left: 180 + r * math.cos(angle),
                      top: 140 + r * math.sin(angle) * 0.5,
                      child: Container(
                        width: 12 + i * 4.0, height: 12 + i * 4.0,
                        decoration: BoxDecoration(
                          color: _neonColors[i].withValues(alpha: 0.4 + _pulseCtrl.value * 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                  Positioned(bottom: 60, left: 24, right: 24, child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Practical Shortcuts', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      const Text('Life Hacks\nfor Busy Learners', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                    ],
                  )),
                ]),
              ),
            ),
          ),
        ),

        // Tag filter
        SliverToBoxAdapter(
          child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: widget.controller.tags.map((tag) {
                final sel = widget.controller.activeTag.value == tag;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => widget.controller.activeTag.value = tag,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: sel ? const Color(0xFFEA580C) : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: sel ? const Color(0xFFEA580C) : Colors.grey.withValues(alpha: 0.3)),
                        boxShadow: sel ? [BoxShadow(color: const Color(0xFFEA580C).withValues(alpha: 0.35), blurRadius: 10)] : [],
                      ),
                      child: Text(tag, style: TextStyle(
                        color: sel ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black54),
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 13,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
        ),

        // Flutter 2026 showcase
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C2D12), Color(0xFFEA580C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Flutter 2026 Features', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
                  ]),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: ['Neon Particle Animations', 'Staggered Grid Slivers', 'Haptic Feedback API', 'ML Habit Suggestions', 'Adaptive Masonry Layouts', 'Voice Input Cards'].map((f) =>
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(f, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Section label
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text('Explore Topics', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w900,
              color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
            )),
          ),
        ),

        // Masonry-style items
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              childAspectRatio: 1.6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final items = _items;
                if (i >= items.length) return null;
                final item = items[i];
                final c = _neonColors[i % _neonColors.length];
                return ScaleTransition(
                  scale: CurvedAnimation(parent: _cardCtrls[i], curve: Curves.elasticOut),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.isDark ? WColors.cardDark : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: c.withValues(alpha: 0.3)),
                      boxShadow: [BoxShadow(color: c.withValues(alpha: 0.12), blurRadius: 16)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                            child: Icon(item.icon, color: c, size: 18),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                            child: Text('NEW', style: TextStyle(color: c, fontSize: 9, fontWeight: FontWeight.w800)),
                          ),
                        ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(item.description, style: TextStyle(fontSize: 11, color: widget.isDark ? Colors.white54 : Colors.black45, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: _items.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
