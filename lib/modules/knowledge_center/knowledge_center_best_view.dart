import 'package:flutter/material.dart';
import 'dart:ui';

/// DESIGN: Glassmorphism — frosted glass cards on rich gradient background
class KnowledgeCenterBestView extends StatelessWidget {
  const KnowledgeCenterBestView({super.key});

  static const _c1 = Color(0xFF6366F1);
  static const _c2 = Color(0xFFEC4899);
  static const _c3 = Color(0xFF06B6D4);
  static const _c4 = Color(0xFFF59E0B);
  static const _c5 = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              title: const Text('KNOWLEDGE CENTER', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
              centerTitle: true,
              actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.school_rounded, color: _c4, size: 22))],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // GLASS HERO
                  _GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: _c1.withOpacity(0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: _c1.withOpacity(0.4))), child: const Icon(Icons.school_rounded, color: Color(0xFF6366F1), size: 24)),
                        const SizedBox(width: 14),
                        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('KNOWLEDGE INTELLIGENCE', style: TextStyle(color: Color(0xFF6366F1), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                          SizedBox(height: 4),
                          Text('Your central hub for learning, discovery, and intellectual growth.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.3)),
                        ])),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        _GlassStat('247', 'Articles', _c3),
                        const SizedBox(width: 12),
                        _GlassStat('48', 'Courses', _c2),
                        const SizedBox(width: 12),
                        _GlassStat('12', 'Domains', _c4),
                        const SizedBox(width: 12),
                        _GlassStat('91%', 'Mastery', _c5),
                      ]),
                    ]),
                  ),
                  const SizedBox(height: 14),
                  // GRID OF GLASS CARDS
                  Row(children: [
                    Expanded(child: _GlassFeature(color: _c1, icon: Icons.menu_book_rounded, title: 'Curated Library', body: 'Hand-picked articles, papers, and books ranked by depth and actionability. Never wade through noise again.')),
                    const SizedBox(width: 12),
                    Expanded(child: _GlassFeature(color: _c2, icon: Icons.psychology_rounded, title: 'Mental Models', body: 'A growing library of thinking frameworks from the world\'s sharpest minds — searchable and cross-referenced.')),
                  ]),
                  const SizedBox(height: 12),
                  _GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Icon(Icons.explore_rounded, color: _c3, size: 20),
                        const SizedBox(width: 10),
                        Text('KNOWLEDGE GRAPH', style: TextStyle(color: _c3, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                      ]),
                      const SizedBox(height: 10),
                      const Text('Map connections between concepts, domains, and insights you\'ve captured. The Knowledge Graph visualises how ideas in leadership connect to psychology, which connects to neuroscience — revealing synthesis opportunities invisible in siloed reading.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: _GlassFeature(color: _c4, icon: Icons.timer_rounded, title: 'Spaced Review', body: 'Algorithmic review scheduling ensures knowledge sticks using the proven spacing effect — no more forgetting what you read.')),
                    const SizedBox(width: 12),
                    Expanded(child: _GlassFeature(color: _c5, icon: Icons.edit_note_rounded, title: 'Note Synthesis', body: 'Capture, tag, and link notes across any source. The synthesis engine surfaces patterns across your entire note base automatically.')),
                  ]),
                  const SizedBox(height: 12),
                  _GlassCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Icon(Icons.people_rounded, color: _c2, size: 20),
                        const SizedBox(width: 10),
                        Text('PEER LEARNING', style: TextStyle(color: _c2, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                      ]),
                      const SizedBox(height: 10),
                      const Text('Join domain-specific study cohorts where members share notes, challenge each other\'s understanding, and build collective intelligence. Social learning multiplies individual study efficiency by a consistent factor of 2–3x.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  _GlassCard(
                    child: Row(children: [
                      Icon(Icons.format_quote_rounded, color: _c4, size: 28),
                      const SizedBox(width: 14),
                      const Expanded(child: Text('"An investment in knowledge pays the best interest." — Benjamin Franklin', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.45, fontStyle: FontStyle.italic))),
                    ]),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: child,
      ),
    ),
  );
}

class _GlassFeature extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _GlassFeature({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(color: Colors.white60, fontSize: 10, height: 1.45)),
        ]),
      ),
    ),
  );
}

class _GlassStat extends StatelessWidget {
  final String value, label; final Color color;
  const _GlassStat(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w900)),
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 8)),
    ]),
  ));
}
