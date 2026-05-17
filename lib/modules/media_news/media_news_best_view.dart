import 'package:flutter/material.dart';

/// DESIGN: Breaking News Ticker — live news dashboard with priority alerts and feed
class MediaNewsBestView extends StatelessWidget {
  const MediaNewsBestView({super.key});

  static const _red = Color(0xFFDC2626);
  static const _blue = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF030510);

  @override
  Widget build(BuildContext context) {
    final feed = [
      _Article(cat: 'BREAKING', color: _red, time: '09:14', title: 'Global Leaders Reach Historic Climate Agreement at Emergency Summit', src: 'AIR World Desk', reads: '847K'),
      _Article(cat: 'POLITICS', color: _blue, time: '08:52', title: 'Parliament Passes Landmark Digital Rights Bill in Unanimous Vote', src: 'AIR Politics', reads: '234K'),
      _Article(cat: 'TECHNOLOGY', color: _violet, time: '08:30', title: 'AI System Achieves Medical Diagnosis Accuracy Equal to Specialist Physicians', src: 'AIR Tech', reads: '512K'),
      _Article(cat: 'ECONOMY', color: _amber, time: '08:05', title: 'Central Bank Holds Rates; Signals Cuts in Q3 Amid Stable Inflation Data', src: 'AIR Finance', reads: '189K'),
      _Article(cat: 'SCIENCE', color: _green, time: '07:40', title: 'Fusion Energy Breakthrough: Commercial Plant Achieves Net Energy Gain', src: 'AIR Science', reads: '923K'),
      _Article(cat: 'CULTURE', color: _sky, time: '07:15', title: 'Long-Lost Manuscript Discovered in Vatican Archives Rewrites Medieval History', src: 'AIR Culture', reads: '76K'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A14),
        foregroundColor: Colors.white,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: _red, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900))),
          const SizedBox(width: 8),
          const Text('AIR MEDIA & NEWS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
        ]),
        centerTitle: true,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1, color: _red.withOpacity(0.4))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        children: [
          // TICKER BAR
          Container(
            color: _red.withOpacity(0.1), padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), color: _red, child: const Text('TICKER', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900))),
              const SizedBox(width: 12),
              const Expanded(child: Text('Markets up 1.2% • Climate agreement signed • AI breakthrough confirmed • Parliament in session • New discovery in Vatican...', style: TextStyle(color: Colors.white60, fontSize: 10), overflow: TextOverflow.ellipsis)),
            ]),
          ),
          // FEATURED STORY
          Container(
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1A0010), _red.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18), border: Border.all(color: _red.withOpacity(0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: _red.withOpacity(0.15), borderRadius: const BorderRadius.vertical(top: Radius.circular(17))),
                child: Row(children: [const Icon(Icons.bolt_rounded, color: Color(0xFFDC2626), size: 14), const SizedBox(width: 6), Text('TOP STORY', style: TextStyle(color: _red, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 2)), const Spacer(), const Text('09:14 AM', style: TextStyle(color: Colors.white38, fontSize: 9))]),
              ),
              Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Global Leaders Reach Historic Climate Agreement at Emergency Summit', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, height: 1.25)),
                const SizedBox(height: 10),
                const Text('In an unprecedented session that ran through the night, representatives from 147 nations signed a binding agreement committing to net-zero emissions by 2040 — a decade ahead of the previous target. The breakthrough came after a 11th-hour compromise on carbon credit mechanisms.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.5)),
                const SizedBox(height: 12),
                Row(children: [
                  Text('AIR World Desk', style: TextStyle(color: _sky, fontSize: 10, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Icon(Icons.visibility_rounded, color: Colors.white38, size: 12), const SizedBox(width: 4),
                  const Text('847K reads', style: TextStyle(color: Colors.white38, fontSize: 10)),
                ]),
              ])),
            ]),
          ),
          // NEWS FEED
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(children: [Container(width: 3, height: 14, color: _blue), const SizedBox(width: 8), Text('NEWS FEED', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))])),
          const SizedBox(height: 10),
          ...feed.map((a) => _ArticleTile(article: a)),
          // MEDIA INTELLIGENCE TOOLS
          Padding(padding: const EdgeInsets.fromLTRB(14, 20, 14, 10),
            child: Row(children: [Container(width: 3, height: 14, color: _violet), const SizedBox(width: 8), Text('MEDIA INTELLIGENCE', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))])),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Column(children: [
            _MediaTool(color: _blue, icon: Icons.fact_check_rounded, title: 'Fact-Check Engine', body: 'Automated verification of claims against primary sources. AIR labels each story with a credibility score and links directly to the evidence base behind the reporting.'),
            const SizedBox(height: 8),
            _MediaTool(color: _green, icon: Icons.compare_arrows_rounded, title: 'Cross-Source Analysis', body: 'Compare how different outlets cover the same story — what each emphasises, omits, and frames differently. The truth often lives in the gap between competing narratives.'),
            const SizedBox(height: 8),
            _MediaTool(color: _amber, icon: Icons.person_search_rounded, title: 'Source Credibility Rating', body: 'Track the historical accuracy, bias patterns, and correction rates of every major media outlet — so you know the reliability of the source before you invest in the story.'),
          ])),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _Article {
  final String cat, time, title, src, reads; final Color color;
  const _Article({required this.cat, required this.color, required this.time, required this.title, required this.src, required this.reads});
}

class _ArticleTile extends StatelessWidget {
  final _Article article;
  const _ArticleTile({required this.article});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: article.color.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: article.color.withOpacity(0.16))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: article.color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)), child: Text(article.cat, style: TextStyle(color: article.color, fontSize: 8, fontWeight: FontWeight.w900))),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(article.title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3)),
        const SizedBox(height: 5),
        Row(children: [
          Text(article.src, style: TextStyle(color: article.color.withOpacity(0.7), fontSize: 9)),
          const SizedBox(width: 8),
          Text(article.time, style: const TextStyle(color: Colors.white30, fontSize: 9)),
          const Spacer(),
          Icon(Icons.visibility_rounded, color: Colors.white24, size: 10), const SizedBox(width: 3),
          Text(article.reads, style: const TextStyle(color: Colors.white30, fontSize: 9)),
        ]),
      ])),
    ]),
  );
}

class _MediaTool extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _MediaTool({required this.color, required this.icon, required this.title, required this.body});
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
