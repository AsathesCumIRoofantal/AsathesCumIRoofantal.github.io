import 'package:flutter/material.dart';

/// DESIGN: Warm Masonry Grid — varying-height cards on warm family theme
class FamilyBestView extends StatelessWidget {
  const FamilyBestView({super.key});

  static const _warm1 = Color(0xFFEA580C);
  static const _warm2 = Color(0xFFD97706);
  static const _warm3 = Color(0xFF854D0E);
  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _green = Color(0xFF059669);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF0A0400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('FAMILY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.home_rounded, color: _warm1, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 40),
        children: [
          // HERO — warm family portrait
          Container(
            height: 180, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF2A1000), const Color(0xFF180800)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(22), border: Border.all(color: _warm1.withOpacity(0.3)),
            ),
            child: Stack(children: [
              Positioned(right: -20, bottom: -20, child: Icon(Icons.home_rounded, size: 160, color: _warm1.withOpacity(0.06))),
              Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('FAMILY INTELLIGENCE', style: TextStyle(color: _warm2, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 8),
                const Text('Home is not a place. It is the people who make you feel known.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, height: 1.2)),
              ])),
            ]),
          ),
          const SizedBox(height: 14),
          // MASONRY GRID — varied heights
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(children: [
              _MasonCard(color: _warm1, height: 130, icon: Icons.favorite_rounded, title: 'Unconditional Love', body: 'The defining feature of family at its best — love that does not depend on performance, agreement, or reciprocity. It is the model for all other loving.'),
              const SizedBox(height: 10),
              _MasonCard(color: _green, height: 160, icon: Icons.shield_rounded, title: 'The Safety Function', body: 'Healthy families are the primary safe harbour — the place where failure does not end belonging, where vulnerability is safe, and where the self can be known without being judged. This safety is the foundation from which risk-taking in the wider world becomes possible.\n\nFamilies that provide this safety produce children who take more risks, fail more productively, and ultimately achieve more.'),
              const SizedBox(height: 10),
              _MasonCard(color: _pink, height: 110, icon: Icons.celebration_rounded, title: 'Rituals & Memory', body: 'Family rituals — repeated, meaningful practices — are the primary mechanism by which shared identity and collective memory are built across generations.'),
            ])),
            const SizedBox(width: 10),
            Expanded(child: Column(children: [
              _MasonCard(color: _rose, height: 170, icon: Icons.account_tree_rounded, title: 'Family Architecture', body: 'Every family has a structure — patterns of communication, power, roles, and unspoken rules. Making the implicit architecture explicit — through family conversations, shared agreements, and role clarity — is the first step toward intentional family culture.\n\nIntentional families tend to produce more resilient members because the support structures are visible and reliable rather than assumed and fragile.'),
              const SizedBox(height: 10),
              _MasonCard(color: _teal, height: 120, icon: Icons.psychology_rounded, title: 'Intergenerational Wisdom', body: 'Each generation carries knowledge — of hardship survived, mistakes made, and lessons hard-won — that is most efficiently transmitted within family rather than rediscovered by each generation at full cost.'),
              const SizedBox(height: 10),
              _MasonCard(color: _warm2, height: 110, icon: Icons.healing_rounded, title: 'Repair & Forgiveness', body: 'All families produce conflict. The differentiator is repair speed — how quickly ruptures are addressed and wounds closed before they calcify into distance.'),
            ])),
          ]),
          const SizedBox(height: 14),
          // BOTTOM WIDE CARD
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: _warm3.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: _warm3.withOpacity(0.25))),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.book_rounded, color: _warm2, size: 20),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('FAMILY HEALTH INDEX', style: TextStyle(color: _warm2, fontSize: 11, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...[('Communication quality', 0.78, _warm1), ('Conflict resolution speed', 0.65, _rose), ('Shared time investment', 0.72, _green), ('Emotional safety level', 0.88, _teal)].map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    SizedBox(width: 140, child: Text(m.$1, style: const TextStyle(color: Colors.white54, fontSize: 10))),
                    Expanded(child: Stack(children: [
                      Container(height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3))),
                      FractionallySizedBox(widthFactor: m.$2, child: Container(height: 6, decoration: BoxDecoration(color: m.$3, borderRadius: BorderRadius.circular(3)))),
                    ])),
                    const SizedBox(width: 8),
                    Text('${(m.$2 * 100).round()}%', style: TextStyle(color: m.$3, fontSize: 9, fontWeight: FontWeight.w700)),
                  ]),
                )),
              ])),
            ]),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_warm1.withOpacity(0.10), _rose.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _warm1.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _warm2, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Family is not an important thing. It\'s everything." — Michael J. Fox', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _MasonCard extends StatelessWidget {
  final Color color; final double height; final IconData icon; final String title, body;
  const _MasonCard({required this.color, required this.height, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    height: height, padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(height: 6),
      Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      Expanded(child: Text(body, style: const TextStyle(color: Colors.white60, fontSize: 10, height: 1.4), overflow: TextOverflow.fade)),
    ]),
  );
}
