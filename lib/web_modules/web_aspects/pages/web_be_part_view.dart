import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_be_part_controller.dart';

class WebBePartView extends GetView<WebBePartController> {
  static const routeName = '/web-aspects/be-part';
  const WebBePartView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF1F2),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebBePartController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _heroCtrl;
  late AnimationController _progressCtrl;
  late Animation<double> _progressAnim;

  static const _roles = [
    ('Community Member', 'Engage, learn, and participate in AIR events', Icons.people_alt_rounded, Color(0xFFE11D48), 'Open'),
    ('Content Creator', 'Produce articles, guides, or media for AIR knowledge hub', Icons.create_rounded, Color(0xFF7C3AED), 'Open'),
    ('Facilitator', 'Lead workshops, sessions, and learning circles', Icons.record_voice_over_rounded, Color(0xFF0284C7), 'Invite'),
    ('Core Contributor', 'Shape features, policies, and core AIR direction', Icons.hub_rounded, Color(0xFF059669), 'Apply'),
    ('AIR Partner', 'Organisation-level partnership for mutual projects', Icons.handshake_rounded, Color(0xFFEA580C), 'Apply'),
  ];

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..forward();
    _progressCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    _progressAnim = CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() { _heroCtrl.dispose(); _progressCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: const Color(0xFFE11D48),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Be Part of AIR', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFBE123C), Color(0xFFE11D48), Color(0xFF9F1239)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(children: [
                Positioned(right: -30, top: 20,
                  child: Container(width: 200, height: 200,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Roles · Expectations · Belonging', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      const Text('Become Part\nof AIR', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                      const SizedBox(height: 8),
                      Text('Pathways to belong — roles, expectations, and how to plug into AIR.',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),

        // Journey stepper
        SliverToBoxAdapter(
          child: Obx(() {
            final step = widget.ctrl.currentStep.value;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Journey', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(widget.ctrl.steps.length, (i) {
                      final done = i <= step;
                      final active = i == step;
                      return Expanded(child: GestureDetector(
                        onTap: () => widget.ctrl.currentStep.value = i,
                        child: Row(children: [
                          Expanded(child: Column(children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: active ? 36 : 28, height: active ? 36 : 28,
                              decoration: BoxDecoration(
                                color: done ? const Color(0xFFE11D48) : (widget.isDark ? WColors.cardDark : Colors.white),
                                shape: BoxShape.circle,
                                border: Border.all(color: done ? const Color(0xFFE11D48) : Colors.grey.withValues(alpha: 0.3), width: active ? 2.5 : 1.5),
                                boxShadow: active ? [BoxShadow(color: const Color(0xFFE11D48).withValues(alpha: 0.4), blurRadius: 10)] : [],
                              ),
                              child: Icon(done ? Icons.check_rounded : Icons.circle_outlined, size: active ? 18 : 14,
                                color: done ? Colors.white : Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(widget.ctrl.steps[i], style: TextStyle(
                              fontSize: 9, fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                              color: active ? const Color(0xFFE11D48) : (widget.isDark ? Colors.white54 : Colors.black45),
                            ), textAlign: TextAlign.center),
                          ])),
                          if (i < widget.ctrl.steps.length - 1)
                            Flexible(child: Container(height: 2, color: i < step ? const Color(0xFFE11D48) : Colors.grey.withValues(alpha: 0.2))),
                        ]),
                      ));
                    }),
                  ),
                ],
              ),
            );
          }),
        ),

        // Flutter 2026 banner
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF881337), Color(0xFFE11D48)]),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [
                  Icon(Icons.auto_awesome_mosaic_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text('Flutter 2026 Onboarding Engine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                ]),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: ['Animated journey steps', 'Role matching AI', 'Progress persistence', 'Gamified onboarding', 'Confetti on completion'].map((f) =>
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(f, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)))
                ).toList()),
              ]),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Open Roles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i >= _roles.length) return null;
                final r = _roles[i];
                return AnimatedBuilder(
                  animation: _heroCtrl,
                  builder: (_, __) {
                    final prog = ((_heroCtrl.value - i * 0.15).clamp(0.0, 1.0));
                    return Opacity(
                      opacity: prog,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - prog)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: widget.isDark ? WColors.cardDark : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: r.$4.withValues(alpha: 0.2)),
                            ),
                            child: Row(children: [
                              Container(width: 44, height: 44,
                                decoration: BoxDecoration(color: r.$4.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
                                child: Icon(r.$3, color: r.$4, size: 22)),
                              const SizedBox(width: 14),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(r.$1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                                const SizedBox(height: 3),
                                Text(r.$2, style: TextStyle(fontSize: 11.5, color: widget.isDark ? Colors.white54 : Colors.black45, height: 1.3)),
                              ])),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(color: r.$4.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                                child: Text(r.$5, style: TextStyle(color: r.$4, fontWeight: FontWeight.w800, fontSize: 12)),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: _roles.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
