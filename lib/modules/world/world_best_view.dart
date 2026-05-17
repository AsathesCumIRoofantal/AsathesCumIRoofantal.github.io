import 'package:flutter/material.dart';

/// DESIGN: Mind Map — central concept with radiating branch cards
class WorldBestView extends StatelessWidget {
  const WorldBestView({super.key});

  static const _blue = Color(0xFF1D4ED8);
  static const _green = Color(0xFF059669);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFF43F5E);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF010A10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('WORLD INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.public_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // MIND MAP HERO
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF00081A), const Color(0xFF000D24)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.2)),
            ),
            child: Stack(children: [
              // CENTER NODE
              const Center(child: _CenterNode()),
              // BRANCH NODES
              Positioned(top: 30, left: 20, child: _BranchNode('🌏 Geopolitics', _blue)),
              Positioned(top: 20, right: 16, child: _BranchNode('📡 Technology', _violet)),
              Positioned(top: 100, left: 8, child: _BranchNode('🌿 Climate', _green)),
              Positioned(top: 110, right: 8, child: _BranchNode('💰 Economics', _amber)),
              Positioned(bottom: 80, left: 14, child: _BranchNode('🧬 Science', _sky)),
              Positioned(bottom: 70, right: 10, child: _BranchNode('🤝 Society', _rose)),
              Positioned(bottom: 20, left: 60, child: _BranchNode('🏛️ Governance', _teal)),
              Positioned(bottom: 18, right: 50, child: _BranchNode('🎭 Culture', Color(0xFFF97316))),
              // CONNECTOR LINES (simplified)
              Positioned.fill(child: CustomPaint(painter: _MindMapPainter())),
            ]),
          ),
          const SizedBox(height: 20),
          // WORLD INTELLIGENCE DOMAINS
          _SecHead('GLOBAL INTELLIGENCE DOMAINS', _blue),
          const SizedBox(height: 12),
          _WorldCard(color: _blue, icon: Icons.public_rounded, title: 'Geopolitical Intelligence',
              body: 'Track shifting power dynamics, alliance formations, territorial disputes, and diplomatic developments. Understand how geopolitical events interact with your personal and professional life — the global always becomes local eventually.'),
          const SizedBox(height: 8),
          _WorldCard(color: _green, icon: Icons.eco_rounded, title: 'Climate Intelligence',
              body: 'Monitor climate science data, policy developments, and adaptation strategies. Map the physical and economic risk exposure of your location, industry, and supply chain to climate change scenarios — from 1.5°C to 4°C pathways.'),
          const SizedBox(height: 8),
          _WorldCard(color: _amber, icon: Icons.currency_exchange_rounded, title: 'Economic Intelligence',
              body: 'Follow macroeconomic indicators — GDP growth, inflation trajectories, currency movements, interest rate cycles, and trade flow shifts — across the regions that matter most to your professional and investment exposure.'),
          const SizedBox(height: 8),
          _WorldCard(color: _violet, icon: Icons.biotech_rounded, title: 'Technology Intelligence',
              body: 'Monitor the global technology landscape — which nations are leading in which technologies, which regulations are emerging, and which breakthrough capabilities are approaching commercial viability with world-changing implications.'),
          const SizedBox(height: 8),
          _WorldCard(color: _rose, icon: Icons.people_rounded, title: 'Social Intelligence',
              body: 'Track global demographic shifts, urbanisation trends, migration patterns, and cultural evolution. The social changes happening now will shape every market, institution, and community over the next 20 years.'),
          const SizedBox(height: 8),
          _WorldCard(color: _teal, icon: Icons.account_balance_rounded, title: 'Governance Intelligence',
              body: 'Monitor the health of institutions — the rule of law, judicial independence, press freedom, electoral integrity, and regulatory quality — across jurisdictions relevant to your activities. Governance quality is the most reliable predictor of long-run national prosperity.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _green.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Think globally, act locally." — Patrick Geddes', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CenterNode extends StatelessWidget {
  const _CenterNode();
  @override
  Widget build(BuildContext context) => Container(
    width: 72, height: 72,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(colors: [Color(0xFF1D4ED8), Color(0xFF1E3A5F)]),
      boxShadow: [BoxShadow(color: const Color(0xFF1D4ED8).withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
    ),
    child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.public_rounded, color: Colors.white, size: 28),
      Text('WORLD', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
    ]),
  );
}

class _BranchNode extends StatelessWidget {
  final String label; final Color color;
  const _BranchNode(this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.3))),
    child: Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700)),
  );
}

class _MindMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.08)..strokeWidth = 1..style = PaintingStyle.stroke;
    final cx = size.width / 2; final cy = size.height / 2;
    final ends = [(40.0, 55.0), (size.width - 50, 35.0), (24.0, 125.0), (size.width - 40, 130.0), (40.0, size.height - 95), (size.width - 40, size.height - 85), (90.0, size.height - 38), (size.width - 80, size.height - 36)];
    for (final e in ends) { canvas.drawLine(Offset(cx, cy), Offset(e.$1, e.$2), p); }
  }
  @override bool shouldRepaint(_) => false;
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _WorldCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _WorldCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}
