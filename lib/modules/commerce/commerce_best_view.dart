import 'package:flutter/material.dart';

/// DESIGN: Kanban Board — status columns with draggable-style cards
class CommerceBestView extends StatelessWidget {
  const CommerceBestView({super.key});

  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _blue = Color(0xFF2563EB);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF070B0E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('COMMERCE BOARD', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.storefront_rounded, color: _green, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF001A08), _green.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _green.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('COMMERCE INTELLIGENCE', style: TextStyle(color: _green, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Your commercial pipeline at a glance — every opportunity, transaction, and partnership tracked across its full lifecycle.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35)),
              const SizedBox(height: 12),
              Row(children: [
                _Kpi('₹2.4M', 'Pipeline', _green), const SizedBox(width: 10),
                _Kpi('34', 'Deals', _amber), const SizedBox(width: 10),
                _Kpi('68%', 'Win Rate', _sky), const SizedBox(width: 10),
                _Kpi('22d', 'Avg Cycle', _violet),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // KANBAN COLUMNS
          Row(children: [
            Container(width: 3, height: 14, color: _blue),
            const SizedBox(width: 8),
            const Text('COMMERCE PIPELINE', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          ]),
          const SizedBox(height: 14),
          // HORIZONTAL KANBAN SCROLL
          SizedBox(
            height: 380,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _KanbanColumn(title: 'PROSPECT', color: _blue, count: 8, cards: [
                  _KCard(title: 'Export deal — UAE', value: '₹280K', tag: 'New'),
                  _KCard(title: 'Retail chain — Delhi', value: '₹190K', tag: 'Cold'),
                  _KCard(title: 'SaaS partnership', value: '₹420K', tag: 'Warm'),
                ]),
                const SizedBox(width: 12),
                _KanbanColumn(title: 'QUALIFIED', color: _violet, count: 6, cards: [
                  _KCard(title: 'Gov. tender — Roads', value: '₹1.2M', tag: 'Priority'),
                  _KCard(title: 'Franchise expansion', value: '₹340K', tag: 'Active'),
                ]),
                const SizedBox(width: 12),
                _KanbanColumn(title: 'PROPOSAL', color: _amber, count: 5, cards: [
                  _KCard(title: 'Corp. license bundle', value: '₹620K', tag: 'Due Fri'),
                  _KCard(title: 'Distribution rights', value: '₹510K', tag: 'Review'),
                  _KCard(title: 'Data partnership', value: '₹230K', tag: 'Sent'),
                ]),
                const SizedBox(width: 12),
                _KanbanColumn(title: 'NEGOTIATION', color: _sky, count: 4, cards: [
                  _KCard(title: 'Bank integration deal', value: '₹880K', tag: 'Hot'),
                  _KCard(title: 'Media rights — S5', value: '₹390K', tag: 'Final'),
                ]),
                const SizedBox(width: 12),
                _KanbanColumn(title: 'CLOSED', color: _green, count: 11, cards: [
                  _KCard(title: 'API access — FinTech', value: '₹740K', tag: 'Won'),
                  _KCard(title: 'Logistics partnership', value: '₹310K', tag: 'Won'),
                  _KCard(title: 'State contract — MH', value: '₹1.6M', tag: 'Won'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // COMMERCE TOOLS
          Row(children: [
            Container(width: 3, height: 14, color: _green),
            const SizedBox(width: 8),
            const Text('COMMERCE TOOLS', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _ToolCard(color: _green, icon: Icons.bar_chart_rounded, title: 'Revenue Analytics', body: 'Full revenue breakdown by channel, product, region, and partner — updated in real time.')),
            const SizedBox(width: 10),
            Expanded(child: _ToolCard(color: _amber, icon: Icons.handshake_rounded, title: 'Contract Manager', body: 'All commercial agreements with terms, renewal dates, and compliance status tracked centrally.')),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _ToolCard(color: _violet, icon: Icons.people_rounded, title: 'Partner Network', body: 'Map of commercial partners, their tier, performance, and relationship health score.')),
            const SizedBox(width: 10),
            Expanded(child: _ToolCard(color: _sky, icon: Icons.trending_up_rounded, title: 'Market Intelligence', body: 'Competitive pricing, market size estimates, and demand signals for your key commercial segments.')),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_green.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _green.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Commerce is the engine of civilisation." — AIR Commercial Intelligence', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  final String value, label; final Color color;
  const _Kpi(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8)),
    ]),
  ));
}

class _KCard { final String title, value, tag; const _KCard({required this.title, required this.value, required this.tag}); }

class _KanbanColumn extends StatelessWidget {
  final String title; final Color color; final int count; final List<_KCard> cards;
  const _KanbanColumn({required this.title, required this.color, required this.count, required this.cards});
  @override
  Widget build(BuildContext context) => Container(
    width: 170,
    decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.15))),
    child: Column(children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: const BorderRadius.vertical(top: Radius.circular(14))),
        child: Row(children: [
          Text(title, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const Spacer(),
          Container(width: 18, height: 18, decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Center(child: Text('$count', style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)))),
        ])),
      Expanded(child: ListView(padding: const EdgeInsets.all(8), children: cards.map((c) => Container(
        margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.08))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(c.title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(c.value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)), child: Text(c.tag, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w800))),
          ]),
        ]),
      )).toList())),
    ]),
  );
}

class _ToolCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ToolCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(height: 6),
      Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(body, style: const TextStyle(color: Colors.white54, fontSize: 10, height: 1.4)),
    ]),
  );
}
