import 'package:flutter/material.dart';

/// DESIGN: Social Media Grid — Instagram-style masonry grid with profile header
class SocialBestView extends StatelessWidget {
  const SocialBestView({super.key});

  static const _purple = Color(0xFF9333EA);
  static const _pink = Color(0xFFEC4899);
  static const _orange = Color(0xFFF97316);
  static const _blue = Color(0xFF2563EB);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _bg = Color(0xFF0A0010);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('SOCIAL INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.people_rounded, color: _purple, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // PROFILE HEADER
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1A0030), const Color(0xFF0D0020)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _purple.withOpacity(0.3)),
            ),
            child: Column(children: [
              Row(children: [
                Stack(children: [
                  Container(width: 64, height: 64, decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_purple, _pink, _orange]))),
                  Positioned(bottom: 0, right: 0, child: Container(width: 18, height: 18, decoration: BoxDecoration(color: _green, shape: BoxShape.circle, border: Border.all(color: _bg, width: 2)), child: const Icon(Icons.check, color: Colors.white, size: 10))),
                ]),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('AIR Social Hub', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                  Text('@air.intelligence', style: TextStyle(color: _purple.withOpacity(0.8), fontSize: 11)),
                  const SizedBox(height: 4),
                  Text('Social strategy, network health, and influence intelligence in one place.', style: TextStyle(color: Colors.white54, fontSize: 10, height: 1.3)),
                ])),
              ]),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _ProfileStat('2.4K', 'Following'),
                _ProfileStat('18.7K', 'Followers'),
                _ProfileStat('94%', 'Reach Rate'),
                _ProfileStat('6.2%', 'Engagement'),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // FEATURE GRID (Instagram-style)
          Row(children: [Container(width: 3, height: 14, color: _purple), const SizedBox(width: 8), Text('SOCIAL MODULES', style: TextStyle(color: _purple.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          // 3-column grid
          GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 3, mainAxisSpacing: 3, childAspectRatio: 1.0,
            children: [
              _GridTile(color: _purple, icon: Icons.analytics_rounded, label: 'Analytics'),
              _GridTile(color: _pink, icon: Icons.trending_up_rounded, label: 'Growth'),
              _GridTile(color: _orange, icon: Icons.campaign_rounded, label: 'Content'),
              _GridTile(color: _blue, icon: Icons.hub_rounded, label: 'Network'),
              _GridTile(color: _teal, icon: Icons.chat_rounded, label: 'Engagement'),
              _GridTile(color: _green, icon: Icons.star_rounded, label: 'Influence'),
            ]),
          const SizedBox(height: 20),
          // CONTENT CARDS
          Row(children: [Container(width: 3, height: 14, color: _pink), const SizedBox(width: 8), Text('SOCIAL INTELLIGENCE TOOLS', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          _SocialCard(color: _purple, icon: Icons.hub_rounded, title: 'Network Architecture',
              body: 'Map your social network by relationship type, interaction frequency, and mutual connection density. Identify the nodes that carry the most bridging value — the people who connect otherwise disconnected clusters of your network.'),
          const SizedBox(height: 8),
          _SocialCard(color: _pink, icon: Icons.trending_up_rounded, title: 'Influence Intelligence',
              body: 'Track your reach — how far your content, ideas, and reputation travel within and beyond your immediate network. Influence is measured by reach multiplied by trust: a message heard by few trusted people outperforms one broadcast to many indifferent ones.'),
          const SizedBox(height: 8),
          _SocialCard(color: _orange, icon: Icons.calendar_today_rounded, title: 'Content Strategy',
              body: 'Plan, draft, and schedule social content across platforms with an editorial calendar. AIR\'s content intelligence reviews your past posts and recommends topic clusters, optimal timing, and format types for maximum engagement.'),
          const SizedBox(height: 8),
          _SocialCard(color: _blue, icon: Icons.sensors_rounded, title: 'Listening Dashboard',
              body: 'Monitor mentions, sentiment, and trending conversations related to your brand, sector, and strategic topics. Social listening converts reactive reputation management into proactive narrative shaping.'),
          const SizedBox(height: 8),
          _SocialCard(color: _teal, icon: Icons.psychology_rounded, title: 'Community Intelligence',
              body: 'Understand the communities you are part of — their shared values, key influencers, common vocabulary, and collective concerns. Community intelligence enables authentic participation rather than transparent self-promotion.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_purple.withOpacity(0.1), _pink.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _purple.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _pink, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Your network is your net worth." — Porter Gale', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value, label;
  const _ProfileStat(this.value, this.label);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9)),
  ]);
}

class _GridTile extends StatelessWidget {
  final Color color; final IconData icon; final String label;
  const _GridTile({required this.color, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    color: color.withOpacity(0.12),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: color, size: 24),
      const SizedBox(height: 5),
      Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700)),
    ]),
  );
}

class _SocialCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _SocialCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}
