import 'package:flutter/material.dart';

/// DESIGN: Global Trade Map — flow diagrams with country flags and trade corridors
class TradeImportExportBestView extends StatelessWidget {
  const TradeImportExportBestView({super.key});

  static const _green = Color(0xFF10B981);
  static const _blue = Color(0xFF1D4ED8);
  static const _amber = Color(0xFFF59E0B);
  static const _sky = Color(0xFF0EA5E9);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _red = Color(0xFFEF4444);
  static const _bg = Color(0xFF020A04);

  @override
  Widget build(BuildContext context) {
    final corridors = [
      _Corridor(from: '🇮🇳 India', to: '🇺🇸 USA', volume: '₹4.2T', growth: '+12%', category: 'IT Services', color: _blue),
      _Corridor(from: '🇮🇳 India', to: '🇦🇪 UAE', volume: '₹2.8T', growth: '+8%', category: 'Petroleum', color: _amber),
      _Corridor(from: '🇨🇳 China', to: '🇮🇳 India', volume: '₹6.1T', growth: '+3%', category: 'Electronics', color: _sky),
      _Corridor(from: '🇮🇳 India', to: '🇬🇧 UK', volume: '₹1.9T', growth: '+18%', category: 'Pharma', color: _green),
      _Corridor(from: '🇮🇳 India', to: '🇩🇪 Germany', volume: '₹1.4T', growth: '+11%', category: 'Machinery', color: _violet),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('TRADE INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.public_rounded, color: _green, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF001A08), _green.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _green.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('GLOBAL TRADE INTELLIGENCE', style: TextStyle(color: _green, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Track trade flows, regulatory barriers, and market opportunities across all active corridors.', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600, height: 1.3)),
              const SizedBox(height: 12),
              Row(children: [
                _TradeStat('₹47T', 'Total\nTrade', _green), const SizedBox(width: 8),
                _TradeStat('187', 'Countries', _sky), const SizedBox(width: 8),
                _TradeStat('+8.4%', 'YoY Growth', _amber), const SizedBox(width: 8),
                _TradeStat('12', 'FTAs\nActive', _blue),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('ACTIVE TRADE CORRIDORS', _green),
          const SizedBox(height: 12),
          ...corridors.map((c) => _CorridorCard(corridor: c)),
          const SizedBox(height: 20),
          _SecHead('TRADE INTELLIGENCE TOOLS', _blue),
          const SizedBox(height: 12),
          _TradeCard(color: _blue, icon: Icons.search_rounded, title: 'Market Entry Scanner',
              body: 'Assess market entry feasibility for any country — regulatory barriers, tariff schedules, local partner requirements, and competitive intensity in your product category. Ranked entry difficulty and recommended entry mode.'),
          const SizedBox(height: 8),
          _TradeCard(color: _amber, icon: Icons.gavel_rounded, title: 'Customs & Compliance Hub',
              body: 'HS code lookup, duty rate calculator, import/export licensing requirements, and documentation checklists for every major trade corridor. Updated within 24 hours of any regulatory change.'),
          const SizedBox(height: 8),
          _TradeCard(color: _teal, icon: Icons.currency_exchange_rounded, title: 'FX Risk Monitor',
              body: 'Currency exposure tracker for all active trade receivables and payables. Scenario analysis for 3% / 5% / 10% currency movements and their P&L impact. Forward contract tracking integrated.'),
          const SizedBox(height: 8),
          _TradeCard(color: _violet, icon: Icons.local_shipping_rounded, title: 'Logistics Intelligence',
              body: 'Compare shipping routes, carriers, transit times, and all-in landed costs for every major corridor. Track shipments, flag delays, and calculate optimal order quantities based on lead time variability.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_green.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _green.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Trade is the exchange of prosperity. Every new market opened is a new possibility created." — AIR Trade Desk', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Corridor {
  final String from, to, volume, growth, category; final Color color;
  const _Corridor({required this.from, required this.to, required this.volume, required this.growth, required this.category, required this.color});
}

class _CorridorCard extends StatelessWidget {
  final _Corridor corridor;
  const _CorridorCard({required this.corridor});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: corridor.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: corridor.color.withOpacity(0.2))),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(corridor.from, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_rounded, color: corridor.color.withOpacity(0.6), size: 14),
          const SizedBox(width: 8),
          Text(corridor.to, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: corridor.color.withOpacity(0.10), borderRadius: BorderRadius.circular(4)), child: Text(corridor.category, style: TextStyle(color: corridor.color, fontSize: 9, fontWeight: FontWeight.w700))),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(corridor.volume, style: TextStyle(color: corridor.color, fontSize: 14, fontWeight: FontWeight.w900)),
        Text(corridor.growth, style: TextStyle(color: corridor.growth.startsWith('+') ? const Color(0xFF10B981) : const Color(0xFFEF4444), fontSize: 11, fontWeight: FontWeight.w700)),
      ]),
    ]),
  );
}

class _TradeStat extends StatelessWidget {
  final String v, l; final Color c;
  const _TradeStat(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.18))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w900)), Text(l, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white30, fontSize: 8, height: 1.2))])));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _TradeCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _TradeCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
