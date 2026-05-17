import 'package:flutter/material.dart';

/// DESIGN: Product Catalogue — card catalogue with specs, pricing, and features grid
class ProductsServicesBestView extends StatelessWidget {
  const ProductsServicesBestView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _rose = Color(0xFFF43F5E);
  static const _bg = Color(0xFF030810);

  @override
  Widget build(BuildContext context) {
    final products = [
      _Product(icon: Icons.psychology_rounded, color: _violet, name: 'AIR Intelligence Core', category: 'Platform', price: '₹2,499/mo', badge: 'FLAGSHIP', rating: 4.9, desc: 'The complete AIR intelligence platform. All modules, all integrations, full analytics suite, and priority support.', features: ['All 137+ Modules', 'Unlimited Storage', 'AI Recommendations', '24/7 Support']),
      _Product(icon: Icons.analytics_rounded, color: _blue, name: 'AIR Analytics Suite', category: 'Analytics', price: '₹899/mo', badge: 'POPULAR', rating: 4.7, desc: 'Advanced data analytics, dashboards, and predictive modelling for every tracked domain.', features: ['Custom Dashboards', 'Predictive Models', 'Export API', 'Weekly Reports']),
      _Product(icon: Icons.school_rounded, color: _teal, name: 'AIR Learning System', category: 'Education', price: '₹499/mo', badge: null, rating: 4.8, desc: 'Personalised learning paths, knowledge tracking, and spaced repetition for any domain.', features: ['Spaced Repetition', 'Progress Tracking', 'Expert Content', 'Peer Groups']),
      _Product(icon: Icons.security_rounded, color: _green, name: 'AIR Safety Shield', category: 'Security', price: '₹699/mo', badge: null, rating: 4.6, desc: 'Comprehensive safety monitoring, compliance tracking, and risk management.', features: ['Real-time Monitoring', 'Compliance Alerts', 'Risk Scoring', 'Incident Log']),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('PRODUCTS & SERVICES', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 12, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.storefront_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030820), const Color(0xFF020510)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PRODUCT INTELLIGENCE', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Every AIR product is designed around one principle: maximum insight with minimum friction.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35)),
              const SizedBox(height: 12),
              Row(children: [
                _HeroStat('4', 'Products', _blue), const SizedBox(width: 8),
                _HeroStat('137+', 'Modules', _violet), const SizedBox(width: 8),
                _HeroStat('4.8★', 'Avg Rating', _amber), const SizedBox(width: 8),
                _HeroStat('12K+', 'Users', _green),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('PRODUCT CATALOGUE', _blue),
          const SizedBox(height: 12),
          ...products.map((p) => _ProductCard(product: p)),
          const SizedBox(height: 20),
          _SecHead('SERVICE INTELLIGENCE', _teal),
          const SizedBox(height: 12),
          _ServCard(color: _sky, icon: Icons.support_agent_rounded, title: 'Dedicated Support', body: 'Every tier includes structured support with defined response SLAs. Priority and flagship tiers include direct access to AIR specialists for configuration, training, and strategic consultation sessions.'),
          const SizedBox(height: 8),
          _ServCard(color: _amber, icon: Icons.handshake_rounded, title: 'Partner Network', body: 'AIR\'s certified partner network provides implementation, training, and integration services across 47 countries. Partners are audited annually for technical competency and client satisfaction.'),
          const SizedBox(height: 8),
          _ServCard(color: _rose, icon: Icons.precision_manufacturing_rounded, title: 'Custom Development', body: 'Bespoke module development, API integration, and enterprise configuration for organisations with requirements beyond standard product capabilities. Minimum engagement: 90 days.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _violet.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"A product is not a product until it solves a problem someone actually has." — AIR Design Principles', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Product {
  final IconData icon; final Color color; final String name, category, price, desc; final String? badge; final double rating; final List<String> features;
  const _Product({required this.icon, required this.color, required this.name, required this.category, required this.price, required this.desc, this.badge, required this.rating, required this.features});
}

class _ProductCard extends StatelessWidget {
  final _Product product;
  const _ProductCard({required this.product});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: product.color.withOpacity(0.07), borderRadius: BorderRadius.circular(18), border: Border.all(color: product.color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: product.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(product.icon, color: product.color, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(product.name, style: TextStyle(color: product.color, fontSize: 13, fontWeight: FontWeight.w800)),
            if (product.badge != null) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: product.color, borderRadius: BorderRadius.circular(4)), child: Text(product.badge!, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900)))],
          ]),
          Row(children: [
            Text(product.category, style: TextStyle(color: product.color.withOpacity(0.7), fontSize: 10)),
            const SizedBox(width: 8),
            Icon(Icons.star_rounded, color: const Color(0xFFF59E0B), size: 10),
            Text(' ${product.rating}', style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 10, fontWeight: FontWeight.w700)),
          ]),
        ])),
        Text(product.price, style: TextStyle(color: product.color, fontSize: 14, fontWeight: FontWeight.w900)),
      ]),
      const SizedBox(height: 10),
      Text(product.desc, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.4)),
      const SizedBox(height: 10),
      Wrap(spacing: 6, runSpacing: 4, children: product.features.map((f) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: product.color.withOpacity(0.10), borderRadius: BorderRadius.circular(6), border: Border.all(color: product.color.withOpacity(0.2))),
        child: Text(f, style: TextStyle(color: product.color, fontSize: 9, fontWeight: FontWeight.w600)),
      )).toList()),
    ]),
  );
}

class _HeroStat extends StatelessWidget {
  final String v, l; final Color c;
  const _HeroStat(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 7), decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.18))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w900)), Text(l, style: const TextStyle(color: Colors.white30, fontSize: 8))])));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _ServCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ServCard({required this.color, required this.icon, required this.title, required this.body});
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
