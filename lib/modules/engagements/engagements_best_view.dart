import 'package:flutter/material.dart';

/// DESIGN: Event Calendar — schedule cards with time blocks and engagement tracking
class EngagementsBestView extends StatelessWidget {
  const EngagementsBestView({super.key});

  static const _indigo = Color(0xFF4F46E5);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFF43F5E);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF03030E);

  @override
  Widget build(BuildContext context) {
    final events = [
      _Evt(time: '09:00', duration: '1h', color: _indigo, title: 'Board Strategy Review', type: 'Meeting', icon: Icons.groups_rounded, engagement: 0.9),
      _Evt(time: '10:30', duration: '30m', color: _sky, title: '1-on-1: Team Lead', type: 'Check-in', icon: Icons.person_rounded, engagement: 0.85),
      _Evt(time: '12:00', duration: '45m', color: _green, title: 'Community Event — Launch', type: 'Event', icon: Icons.celebration_rounded, engagement: 0.95),
      _Evt(time: '14:00', duration: '2h', color: _amber, title: 'Workshop: Design Thinking', type: 'Learning', icon: Icons.school_rounded, engagement: 0.88),
      _Evt(time: '16:30', duration: '1h', color: _violet, title: 'Partner Collaboration Call', type: 'External', icon: Icons.call_rounded, engagement: 0.75),
      _Evt(time: '18:00', duration: '1.5h', color: _rose, title: 'Networking Dinner', type: 'Social', icon: Icons.restaurant_rounded, engagement: 0.92),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('ENGAGEMENTS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.calendar_today_rounded, color: _indigo, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // WEEK HEADER
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF080820), const Color(0xFF040410)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _indigo.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('WEEK OF MAY 13–19, 2026', style: TextStyle(color: _indigo.withOpacity(0.8), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              // MINI WEEK VIEW
              Row(children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].asMap().entries.map((e) => Expanded(child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: e.key == 3 ? _indigo : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: e.key == 3 ? null : Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Column(children: [
                  Text(e.value, style: TextStyle(color: e.key == 3 ? Colors.white : Colors.white38, fontSize: 9, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text('${13 + e.key}', style: TextStyle(color: e.key == 3 ? Colors.white : Colors.white54, fontSize: 11, fontWeight: FontWeight.w900)),
                  if (e.key < 5) ...[const SizedBox(height: 3), Container(width: 4, height: 4, decoration: BoxDecoration(shape: BoxShape.circle, color: e.key == 3 ? Colors.white : _indigo.withOpacity(0.4)))],
                ]),
              ))).toList()),
              const SizedBox(height: 12),
              Row(children: [
                _QuickInfo('6', 'Engagements', _indigo),
                const SizedBox(width: 8),
                _QuickInfo('7.5h', 'Engaged', _sky),
                const SizedBox(width: 8),
                _QuickInfo('89%', 'Quality', _green),
                const SizedBox(width: 8),
                _QuickInfo('3', 'External', _amber),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('TODAY — MAY 16 (THURSDAY)', _indigo),
          const SizedBox(height: 12),
          // EVENT CARDS
          ...events.map((ev) => _EventCard(ev: ev)),
          const SizedBox(height: 20),
          _SecHead('ENGAGEMENT ANALYTICS', _teal),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _teal.withOpacity(0.06), borderRadius: BorderRadius.circular(16), border: Border.all(color: _teal.withOpacity(0.18))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Engagement Quality Score', style: TextStyle(color: _teal, fontSize: 11, fontWeight: FontWeight.w700)),
                Text('88%', style: TextStyle(color: _teal, fontSize: 14, fontWeight: FontWeight.w900)),
              ]),
              const SizedBox(height: 12),
              ...[('High Energy', 0.88, _green), ('Deep Focus', 0.73, _indigo), ('Social Value', 0.91, _rose), ('Strategic', 0.82, _amber)].map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  SizedBox(width: 90, child: Text(m.$1, style: const TextStyle(color: Colors.white54, fontSize: 10))),
                  Expanded(child: Stack(children: [
                    Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3))),
                    FractionallySizedBox(widthFactor: m.$2, child: Container(height: 5, decoration: BoxDecoration(color: m.$3, borderRadius: BorderRadius.circular(3)))),
                  ])),
                  const SizedBox(width: 8),
                  Text('${(m.$2 * 100).round()}%', style: TextStyle(color: m.$3, fontSize: 10, fontWeight: FontWeight.w700)),
                ]),
              )),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_indigo.withOpacity(0.08), _violet.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _indigo.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Engagement is the measure of attention + energy + commitment applied to something that matters." — AIR', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Evt {
  final String time, duration, title, type; final Color color; final IconData icon; final double engagement;
  const _Evt({required this.time, required this.duration, required this.title, required this.type, required this.color, required this.icon, required this.engagement});
}

class _EventCard extends StatelessWidget {
  final _Evt ev;
  const _EventCard({required this.ev});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: ev.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: ev.color.withOpacity(0.2))),
    child: Row(children: [
      // Time column
      SizedBox(width: 48, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(ev.time, style: TextStyle(color: ev.color, fontSize: 12, fontWeight: FontWeight.w900)),
        Text(ev.duration, style: const TextStyle(color: Colors.white30, fontSize: 9)),
      ])),
      Container(width: 1, height: 40, color: ev.color.withOpacity(0.2), margin: const EdgeInsets.symmetric(horizontal: 10)),
      // Icon
      Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: ev.color.withOpacity(0.14), borderRadius: BorderRadius.circular(8)), child: Icon(ev.icon, color: ev.color, size: 14)),
      const SizedBox(width: 10),
      // Content
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(ev.title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 3),
        Row(children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: ev.color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(ev.type, style: TextStyle(color: ev.color, fontSize: 8, fontWeight: FontWeight.w700))),
          const SizedBox(width: 8),
          Text('${(ev.engagement * 100).round()}% engagement', style: TextStyle(color: Colors.white38, fontSize: 9)),
        ]),
      ])),
    ]),
  );
}

class _QuickInfo extends StatelessWidget {
  final String value, label; final Color color;
  const _QuickInfo(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(7), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(children: [Text(value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(color: Colors.white30, fontSize: 7))]),
  ));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}
