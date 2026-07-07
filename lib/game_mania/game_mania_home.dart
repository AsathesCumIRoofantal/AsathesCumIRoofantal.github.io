import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'game_mania_routes.dart';

class GameManiaHome extends StatelessWidget {
  const GameManiaHome({super.key});

  static const _games = [
    _GameCard('Space Shooter', '👾', 'Dodge and destroy enemies', Color(0xFF0F172A), Color(0xFF6366F1), GameManiaRoutes.spaceShooter),
    _GameCard('Snake Classic',  '🐍', 'Eat and grow — avoid yourself', Color(0xFF052E16), Color(0xFF22C55E), GameManiaRoutes.snake),
    _GameCard('Bounce Ball',    '🏀', 'Keep the ball from falling', Color(0xFF1C0A00), Color(0xFFF97316), GameManiaRoutes.bounceBall),
    _GameCard('Planet 3D',      '🪐', 'Shader-rendered spinning planet', Color(0xFF0B1120), Color(0xFF38BDF8), GameManiaRoutes.planet3d),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 720;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(child: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xFF0D0F14),
          floating: true,
          title: Row(children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.sports_esports_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text('Game Mania', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          ]),
          actions: [
            IconButton(icon: const Icon(Icons.arrow_back_rounded, color: Colors.white70),
              onPressed: Get.back),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 16, vertical: 16),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: wide ? 2 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: wide ? 1.9 : 2.2,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) => _games[i].build(),
              childCount: _games.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ])),
    );
  }
}

class _GameCard {
  final String title, emoji, desc, route;
  final Color bg, accent;
  const _GameCard(this.title, this.emoji, this.desc, this.bg, this.accent, this.route);

  Widget build() => GestureDetector(
    onTap: () => Get.toNamed(route),
    child: Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(.3)),
        boxShadow: [BoxShadow(color: accent.withOpacity(.15), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(emoji, style: const TextStyle(fontSize: 36)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(color: accent.withOpacity(.6), fontSize: 12)),
        ]),
      ]),
    )
    .animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
  );
}
