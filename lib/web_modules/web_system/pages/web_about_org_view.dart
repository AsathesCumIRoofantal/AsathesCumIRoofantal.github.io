import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_about_org_controller.dart';

class WebAboutOrgView extends GetView<WebAboutOrgController> {
  static const routeName = '/web-system/about-org';
  const WebAboutOrgView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF8FAFC),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebAboutOrgController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _entryCtrl;
  late Animation<double> _fadeAnim;

  static const _stats = [
    ('Founded', '2019', Icons.flag_rounded),
    ('Members', '12K+', Icons.people_alt_rounded),
    ('Modules', '100+', Icons.grid_view_rounded),
    ('Countries', '24', Icons.public_rounded),
  ];

  static const _leadership = [
    ('Director General', 'Dr. A. Siddiqui', Color(0xFF475569)),
    ('Head of Products', 'F. Rahman', Color(0xFF475569)),
    ('Community Lead', 'T. Nair', Color(0xFF475569)),
    ('Technical Lead', 'K. Patel', Color(0xFF475569)),
  ];

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
    _fadeAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() { _entryCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final sec = WebNavData.bySlug('system');
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: const Color(0xFF475569),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('About AIR Organisation', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF475569)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(children: [
                Positioned(right: -20, bottom: -20,
                  child: Container(width: 200, height: 200,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.03), shape: BoxShape.circle))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Charter · Background · Contact', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      const Text('About AIR\nOrganisation', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                      const SizedBox(height: 8),
                      Text('Charter, background, and the people behind the platform.',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),

        // Stats
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: _stats.asMap().entries.map((e) {
                  final s = e.value;
                  return Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: widget.isDark ? WColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
                      ),
                      child: Column(children: [
                        Icon(s.$3, color: const Color(0xFF475569), size: 20),
                        const SizedBox(height: 6),
                        Text(s.$2, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF475569))),
                        const SizedBox(height: 2),
                        Text(s.$1, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: widget.isDark ? Colors.white54 : Colors.black45)),
                      ]),
                    ),
                  ));
                }).toList(),
              ),
            ),
          ),
        ),

        // About text
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isDark ? WColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF475569).withValues(alpha: 0.1)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Our Story', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                const SizedBox(height: 12),
                Text(
                  'AIR (All-In-Real) Organisation was founded to create a comprehensive, human-centred platform where individuals can explore, learn, contribute, and grow — all in one unified space.\n\nWe believe knowledge, community, and purpose should be accessible to everyone, everywhere. Our platform bridges the gap between isolated tools by building an interconnected ecosystem that respects both individual agency and collective growth.',
                  style: TextStyle(fontSize: 13.5, height: 1.7, color: widget.isDark ? Colors.white70 : Colors.black54),
                ),
              ]),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Leadership
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text('Leadership', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i >= _leadership.length) return null;
                final l = _leadership[i];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.isDark ? WColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF475569).withValues(alpha: 0.15)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 22, backgroundColor: const Color(0xFF475569).withValues(alpha: 0.1),
                      child: Text(l.$2[0], style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w900, fontSize: 18)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(l.$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                      const SizedBox(height: 3),
                      Text(l.$1, style: TextStyle(fontSize: 11, color: widget.isDark ? Colors.white54 : Colors.black45)),
                    ])),
                  ]),
                );
              },
              childCount: _leadership.length,
            ),
          ),
        ),

        // Flutter 2026 note
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                const Icon(Icons.info_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Flutter 2026 Powers This Page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                  Text('Sliver lazy org-charts · Animated counters · Adaptive grid leadership cards · Live member feeds',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11, height: 1.5)),
                ])),
              ]),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
