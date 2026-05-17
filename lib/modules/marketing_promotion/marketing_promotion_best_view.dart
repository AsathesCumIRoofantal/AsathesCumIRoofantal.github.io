import 'package:flutter/material.dart';

/// DESIGN: Multi-column Newspaper Layout — editorial newspaper with columns and headlines
class MarketingPromotionBestView extends StatelessWidget {
  const MarketingPromotionBestView({super.key});

  static const _magenta = Color(0xFFDB2777);
  static const _orange = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _blue = Color(0xFF1D4ED8);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF0A0005);

  @override
  Widget build(BuildContext context) {
    final isDark = true;
    final text = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final sub = isDark ? Colors.white60 : Colors.black54;
    final bg2 = isDark ? const Color(0xFF110008) : Colors.white;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: Column(children: [
          Text('THE MARKETING DISPATCH', style: TextStyle(color: _magenta, fontSize: 7, letterSpacing: 4, fontWeight: FontWeight.w800)),
          const Text('PROMOTION INTELLIGENCE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 11)),
        ]),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 40),
        children: [
          Container(height: 2, decoration: BoxDecoration(gradient: LinearGradient(colors: [_magenta, _orange, _amber]))),
          const SizedBox(height: 10),
          // MASTHEAD DATE
          Center(child: Text('ISSUE 5 • MAY 2026 • MARKETING EDITION', style: TextStyle(color: Colors.white38, fontSize: 8, letterSpacing: 3))),
          Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8), color: Colors.white12),
          // MAIN HEADLINE
          Text('PRECISION MARKETING\nOUTPERFORMS VOLUME MARKETING\nACROSS EVERY METRIC', style: TextStyle(color: text, fontSize: 22, fontWeight: FontWeight.w900, height: 1.1, letterSpacing: -0.5)),
          const SizedBox(height: 6),
          Text('How targeting fewer customers more precisely is transforming commercial outcomes for organisations using AIR\'s marketing intelligence framework.', style: TextStyle(color: _magenta, fontSize: 12, fontStyle: FontStyle.italic, height: 1.35)),
          Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 10), color: Colors.white12),
          // TWO-COLUMN NEWSPAPER
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _ColHeadline('CAMPAIGN INTELLIGENCE', _magenta),
              _ColBody('The best campaigns are built backward from the customer — their jobs-to-be-done, their information environment, and their decision-making context. AIR\'s campaign builder starts with a customer profile, not a product claim.', sub),
              const SizedBox(height: 10),
              _ColHeadline('CHANNEL STRATEGY', _orange),
              _ColBody('Channel selection is strategy. Each channel reaches a different audience with a different readiness level. Mass channels build awareness; direct channels convert. The ratio between them is determined by your funnel health, not by budget alone.', sub),
            ])),
            Container(width: 1, height: 240, margin: const EdgeInsets.symmetric(horizontal: 10), color: Colors.white12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _ColHeadline('BRAND NARRATIVE', _violet),
              _ColBody('The most durable competitive advantage is a narrative that customers believe about themselves when they choose you. Product features are copied; identity stories are not. AIR\'s brand narrative builder distils your story to its most transferable core.', sub),
              const SizedBox(height: 10),
              _ColHeadline('METRICS THAT MATTER', _blue),
              _ColBody('Vanity metrics (impressions, followers, shares) consume attention but rarely predict revenue. AIR tracks a hierarchy: reach → engagement → conversion → retention → advocacy — with revenue attribution at each stage so spend decisions have an evidence base.', sub),
            ])),
          ]),
          Container(height: 2, margin: const EdgeInsets.symmetric(vertical: 14), color: Colors.white.withOpacity(0.06)),
          // FULL-WIDTH TOOLS SECTION
          Text('MARKETING TOOLKIT', style: TextStyle(color: _amber, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const SizedBox(height: 10),
          _MktCard(color: _magenta, icon: Icons.person_search_rounded, title: 'Audience Segmentation', body: 'Define customer segments by behaviour, need, and value — not just demographics. Behavioural segmentation produces 3–5x higher conversion rates than demographic segmentation alone.'),
          const SizedBox(height: 8),
          _MktCard(color: _orange, icon: Icons.analytics_rounded, title: 'Campaign Attribution', body: 'Map every conversion back to its touchpoints across the full customer journey. Multi-touch attribution distributes credit accurately rather than awarding it all to the last click.'),
          const SizedBox(height: 8),
          _MktCard(color: _teal, icon: Icons.science_rounded, title: 'A/B Testing Protocol', body: 'Structured A/B testing for messaging, creative, channels, and timing — with statistical significance thresholds enforced so no decision is made on inadequate sample sizes.'),
          const SizedBox(height: 8),
          _MktCard(color: _violet, icon: Icons.trending_up_rounded, title: 'Customer Lifetime Value', body: 'CLV modelling reveals which customer segments are genuinely profitable over their full relationship — preventing the common mistake of optimising for acquisition cost while ignoring retention economics.'),
          const SizedBox(height: 16),
          Container(height: 2, decoration: BoxDecoration(gradient: LinearGradient(colors: [_amber, _magenta]))),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_magenta.withOpacity(0.10), _violet.withOpacity(0.06)]), borderRadius: BorderRadius.circular(14), border: Border.all(color: _magenta.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Half the money I spend on advertising is wasted; the trouble is I don\'t know which half." — John Wanamaker (pre-AIR era)', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ColHeadline extends StatelessWidget {
  final String text; final Color color;
  const _ColHeadline(this.text, this.color);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)));
}

class _ColBody extends StatelessWidget {
  final String text; final Color color;
  const _ColBody(this.text, this.color);
  @override
  Widget build(BuildContext context) => Text(text, style: TextStyle(color: color, fontSize: 11, height: 1.55));
}

class _MktCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _MktCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
