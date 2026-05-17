import 'package:flutter/material.dart';

/// DESIGN: Streaming Grid — Netflix-style content grid with genre cards and ratings
class EntertainmentBestView extends StatelessWidget {
  const EntertainmentBestView({super.key});

  static const _red = Color(0xFFDC2626);
  static const _orange = Color(0xFFF97316);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _pink = Color(0xFFEC4899);
  static const _bg = Color(0xFF080208);

  @override
  Widget build(BuildContext context) {
    final genres = [
      _Genre(icon: Icons.movie_rounded, color: _red, label: 'Cinema', count: '2,847'),
      _Genre(icon: Icons.music_note_rounded, color: _pink, label: 'Music', count: '14K+'),
      _Genre(icon: Icons.sports_soccer_rounded, color: _green, label: 'Sports', count: '892'),
      _Genre(icon: Icons.library_books_rounded, color: _sky, label: 'Books', count: '5,240'),
      _Genre(icon: Icons.games_rounded, color: _violet, label: 'Gaming', count: '1,342'),
      _Genre(icon: Icons.theater_comedy_rounded, color: _orange, label: 'Theatre', count: '318'),
    ];
    final featured = [
      _Content(title: 'Oppenheimer', genre: 'Cinema', rating: 9.2, color: _red, year: '2023', duration: '3h 1m'),
      _Content(title: 'Bohemian Rhapsody', genre: 'Music', rating: 8.4, color: _pink, year: '2018', duration: '2h 14m'),
      _Content(title: 'Moneyball', genre: 'Sports', rating: 8.6, color: _green, year: '2011', duration: '2h 13m'),
      _Content(title: 'Thinking Fast', genre: 'Books', rating: 9.5, color: _sky, year: '2011', duration: '480 pages'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('ENTERTAINMENT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.theater_comedy_rounded, color: _red, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        children: [
          // HERO BANNER
          Container(
            margin: const EdgeInsets.all(14),
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF300010), const Color(0xFF180008)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _red.withOpacity(0.3)),
            ),
            child: Stack(children: [
              Positioned(right: -20, top: -20, child: Icon(Icons.play_circle_rounded, size: 160, color: _red.withOpacity(0.06))),
              Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('ENTERTAINMENT INTELLIGENCE', style: TextStyle(color: _red, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 6),
                const Text('Curated content across every medium — because culture is not a luxury, it is the context of human understanding.', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, height: 1.3)),
              ])),
            ]),
          ),
          // GENRE GRID
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: _SecHead('GENRE EXPLORER', _amber)),
          const SizedBox(height: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.3,
            children: genres.map((g) => Container(
              decoration: BoxDecoration(color: g.color.withOpacity(0.10), borderRadius: BorderRadius.circular(12), border: Border.all(color: g.color.withOpacity(0.22))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(g.icon, color: g.color, size: 22),
                const SizedBox(height: 4),
                Text(g.label, style: TextStyle(color: g.color, fontSize: 10, fontWeight: FontWeight.w700)),
                Text(g.count, style: const TextStyle(color: Colors.white30, fontSize: 8)),
              ]),
            )).toList())),
          const SizedBox(height: 20),
          // FEATURED CONTENT
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: _SecHead('FEATURED PICKS', _red)),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              scrollDirection: Axis.horizontal,
              itemCount: featured.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final c = featured[i];
                return Container(
                  width: 130,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: c.color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: c.color.withOpacity(0.22))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: c.color.withOpacity(0.14), borderRadius: BorderRadius.circular(4)), child: Text(c.genre, style: TextStyle(color: c.color, fontSize: 8, fontWeight: FontWeight.w800))),
                    const SizedBox(height: 8),
                    Text(c.title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    Row(children: [Icon(Icons.star_rounded, color: _amber, size: 12), const SizedBox(width: 3), Text('${c.rating}', style: TextStyle(color: _amber, fontSize: 11, fontWeight: FontWeight.w700))]),
                    const SizedBox(height: 2),
                    Text('${c.year} • ${c.duration}', style: const TextStyle(color: Colors.white30, fontSize: 9)),
                  ]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // ENTERTAINMENT INTELLIGENCE
          Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Column(children: [
            _SecHead('ENTERTAINMENT INTELLIGENCE', _violet),
            const SizedBox(height: 12),
            _EntCard(color: _violet, icon: Icons.psychology_rounded, title: 'The Cultural Intelligence Argument', body: 'Deep engagement with great films, literature, music, and theatre builds a different kind of intelligence — the ability to empathise across experience gaps, to read complex human motivations, and to hold ambiguity comfortably. These are not soft skills; they are core competencies.'),
            const SizedBox(height: 8),
            _EntCard(color: _sky, icon: Icons.analytics_rounded, title: 'The Pattern Recognition Library', body: 'Every story you deeply engage with adds a pattern to your mental library. The person with a rich library of stories — from any medium — pattern-matches more quickly in novel situations than the person who has only encountered direct experience. Fiction is an experience simulator.'),
            const SizedBox(height: 8),
            _EntCard(color: _pink, icon: Icons.people_rounded, title: 'Entertainment as Social Currency', body: 'Shared cultural references are the basis of more conversations, negotiations, and relationships than most people realise. Knowing what matters culturally to the people you work with or care about is a form of respect and connection.'),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_red.withOpacity(0.10), _violet.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _red.withOpacity(0.2))),
              child: Row(children: [
                Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
                const Expanded(child: Text('"Art is not what you see, but what you make others see." — Edgar Degas', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
              ]),
            ),
          ])),
        ],
      ),
    );
  }
}

class _Genre { final IconData icon; final Color color; final String label, count; const _Genre({required this.icon, required this.color, required this.label, required this.count}); }
class _Content { final String title, genre, year, duration; final Color color; final double rating; const _Content({required this.title, required this.genre, required this.rating, required this.color, required this.year, required this.duration}); }

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _EntCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _EntCard({required this.color, required this.icon, required this.title, required this.body});
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
