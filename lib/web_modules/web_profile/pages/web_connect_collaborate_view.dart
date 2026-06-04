import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_connect_collaborate_controller.dart';

class WebConnectCollaborateView
    extends GetView<WebConnectCollaborateController> {
  static const routeName = '/web-profile/connect-collaborate';
  const WebConnectCollaborateView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF5F3FF),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebConnectCollaborateController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _orbitCtrl;
  late AnimationController _staggerCtrl;

  static const _people = [
    ('Aryan Verma', 'Mentor · Design Systems', Color(0xFF7C3AED), 'AV'),
    ('Sara Hassan', 'Partner · Research', Color(0xFF0284C7), 'SH'),
    ('Leo Kim', 'Peer · Flutter Dev', Color(0xFF059669), 'LK'),
    ('Nour Farid', 'Team · Content', Color(0xFFEA580C), 'NF'),
    ('Priya Rao', 'Mentor · Strategy', Color(0xFFEC4899), 'PR'),
    ('Zaid Malik', 'Peer · AI/ML', Color(0xFFD4AF37), 'ZM'),
  ];

  @override
  void initState() {
    super.initState();
    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _orbitCtrl.dispose();
    _staggerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 340,
          pinned: true,
          backgroundColor: const Color(0xFF7C3AED),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Connect & Collaborate',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
            background: AnimatedBuilder(
              animation: _orbitCtrl,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4C1D95),
                      Color(0xFF7C3AED),
                      Color(0xFF6D28D9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Orbiting dots
                    ...List.generate(6, (i) {
                      final angle =
                          (i / 6) * math.pi * 2 +
                          _orbitCtrl.value * math.pi * 2;
                      return Positioned(
                        left: 200 + 80 * math.cos(angle),
                        top: 160 + 50 * math.sin(angle),
                        child: Container(
                          width: 8 + i * 2.0,
                          height: 8 + i * 2.0,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Network · Co-create · Visibility',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Your Collaboration\nNetwork',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find partners, co-create, and keep collaboration visible in one place.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Stats row
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children:
                  [
                        ['12', 'Connections'],
                        ['4', 'Active Projects'],
                        ['8', 'Messages'],
                      ]
                      .map(
                        (s) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: widget.isDark
                                  ? WColors.cardDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  s[0],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF7C3AED),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s[1],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: widget.isDark
                                        ? Colors.white54
                                        : Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),

        // Role filter
        SliverToBoxAdapter(
          child: Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: widget.ctrl.roles.map((r) {
                  final sel = widget.ctrl.filterRole.value == r;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => widget.ctrl.filterRole.value = r,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: sel
                              ? const Color(0xFF7C3AED)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: sel
                                ? const Color(0xFF7C3AED)
                                : Colors.grey.withValues(alpha: 0.3),
                          ),
                          boxShadow: sel
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF7C3AED,
                                    ).withValues(alpha: 0.35),
                                    blurRadius: 10,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          r,
                          style: TextStyle(
                            color: sel
                                ? Colors.white
                                : (widget.isDark
                                      ? Colors.white70
                                      : Colors.black54),
                            fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // People grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate((ctx, i) {
              if (i >= _people.length) return null;
              final p = _people[i];
              final delay = i / _people.length;
              return AnimatedBuilder(
                animation: _staggerCtrl,
                builder: (_, __) {
                  final prog = ((_staggerCtrl.value - delay * 0.5) / 0.5).clamp(
                    0.0,
                    1.0,
                  );
                  return Opacity(
                    opacity: prog,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - prog)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? WColors.cardDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: p.$3.withValues(alpha: 0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: p.$3.withValues(alpha: 0.1),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: p.$3.withValues(alpha: 0.15),
                              child: Text(
                                p.$4,
                                style: TextStyle(
                                  color: p.$3,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              p.$1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: widget.isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.$2,
                              style: TextStyle(
                                fontSize: 11,
                                color: widget.isDark
                                    ? Colors.white54
                                    : Colors.black45,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: p.$3.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                      color: p.$3,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }, childCount: _people.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
