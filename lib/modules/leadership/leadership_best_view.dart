import 'package:flutter/material.dart';

/// DESIGN: Magazine Editorial — big drop-cap typography, pull quotes, editorial columns
class LeadershipBestView extends StatelessWidget {
  const LeadershipBestView({super.key});

  static const _ink = Color(0xFF1A1A2E);
  static const _gold = Color(0xFFD4A853);
  static const _cream = Color(0xFFF5F0E8);
  static const _charcoal = Color(0xFF2D2D2D);
  static const _red = Color(0xFFB91C1C);
  static const _teal = Color(0xFF0D9488);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? _ink : _cream;
    final text = isDark ? Colors.white : _charcoal;
    final sub = isDark ? Colors.white60 : Colors.black54;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        foregroundColor: text,
        elevation: 0,
        title: Column(children: [
          Text('THE AIR REVIEW', style: TextStyle(fontSize: 8, letterSpacing: 4, color: _gold, fontWeight: FontWeight.w800)),
          Text('LEADERSHIP EDITION', style: TextStyle(fontSize: 12, letterSpacing: 2, color: text, fontWeight: FontWeight.w900)),
        ]),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // MASTHEAD RULE
          Container(height: 3, margin: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(gradient: LinearGradient(colors: [_red, _gold]))),
          // ISSUE INFO
          Center(child: Text('VOLUME XII • ISSUE 5 • MAY 2026', style: TextStyle(fontSize: 9, letterSpacing: 3, color: sub, fontWeight: FontWeight.w600))),
          Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8), color: isDark ? Colors.white12 : Colors.black12),
          const SizedBox(height: 8),
          // HEADLINE
          Text('THE WEIGHT OF COMMAND', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: text, height: 1.1, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text('What separates leaders who endure from those who merely hold power', style: TextStyle(fontSize: 14, color: _gold, fontWeight: FontWeight.w600, height: 1.3, fontStyle: FontStyle.italic)),
          Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 12), color: isDark ? Colors.white12 : Colors.black12),
          // BYLINE
          Row(children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: _gold.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.person, color: Color(0xFFD4A853), size: 20)),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('By the AIR Editorial Board', style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.w700)),
              Text('Leadership Intelligence Desk', style: TextStyle(color: sub, fontSize: 9)),
            ]),
          ]),
          const SizedBox(height: 16),
          // DROP CAP OPENING PARAGRAPH
          _DropCapPara(
            dropCap: 'L',
            rest: 'eadership is not a title — it is a practice. Every person who has ever sat in a position of authority has discovered, usually painfully, that authority is the least of the tools available to them.',
            text: text, sub: sub, gold: _gold,
          ),
          const SizedBox(height: 12),
          Text('The most effective leaders in history shared a common trait: they invested disproportionately in the people below them and demanded disproportionately little in personal deference. Command was reserved for crisis; influence was the permanent mode of operation.', style: TextStyle(color: sub, fontSize: 13, height: 1.65)),
          const SizedBox(height: 20),
          // PULL QUOTE
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: _red, width: 4))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('"Leadership is not about being in charge. It is about taking care of those in your charge."', style: TextStyle(fontSize: 18, color: _red, fontWeight: FontWeight.w700, height: 1.4, fontStyle: FontStyle.italic)),
              const SizedBox(height: 8),
              Text('— Simon Sinek', style: TextStyle(color: sub, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1)),
            ]),
          ),
          const SizedBox(height: 20),
          // SUB-SECTIONS
          _EditSection(title: 'THE FIVE CORE MANDATES', color: _gold, text: text, sub: sub, body: 'Every leadership role carries five non-negotiable mandates: set direction, align people, motivate and inspire, produce results, and develop successors. The leader who fulfills all five is rare. The leader who neglects even one creates a gap that the organisation will eventually fill with crisis.'),
          const SizedBox(height: 16),
          _EditSection(title: 'ON DELEGATION', color: _teal, text: text, sub: sub, body: 'The greatest leadership leverage point is delegation — the art of handing off work in a way that develops the person who receives it. The leader who cannot delegate cannot scale. The leader who delegates without development creates dependency, not capability.'),
          const SizedBox(height: 16),
          _EditSection(title: 'THE TRUST ECONOMY', color: _red, text: text, sub: sub, body: 'Trust is the currency of leadership. It is earned slowly, through consistent words and actions aligned over time, and lost instantly through a single significant breach. The leader\'s most important daily task is the maintenance of the trust that makes voluntary cooperation possible.'),
          const SizedBox(height: 16),
          _EditSection(title: 'LEADING UNDER PRESSURE', color: _gold, text: text, sub: sub, body: 'Pressure is the test of character that ordinary circumstances cannot provide. Leaders who have never faced a genuine crisis have not yet discovered who they are. AIR\'s leadership module includes a crisis simulation framework that surfaces your default leadership pattern before a real crisis does.'),
          const SizedBox(height: 16),
          _EditSection(title: 'SUCCESSION: THE FINAL DUTY', color: _teal, text: text, sub: sub, body: 'The ultimate measure of a leader is the quality of the leadership that follows them. Leaders who build organisations that cannot survive their departure have failed the most important test — not because they lacked talent, but because they confused being needed with being effective.'),
          const SizedBox(height: 20),
          Container(height: 3, decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold, _red]))),
          const SizedBox(height: 12),
          Center(child: Text('AIR INTELLIGENCE REVIEW • ALL RIGHTS RESERVED', style: TextStyle(fontSize: 8, letterSpacing: 2, color: sub))),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _DropCapPara extends StatelessWidget {
  final String dropCap, rest; final Color text, sub, gold;
  const _DropCapPara({required this.dropCap, required this.rest, required this.text, required this.sub, required this.gold});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 52, height: 60, alignment: Alignment.center,
      child: Text(dropCap, style: TextStyle(fontSize: 64, fontWeight: FontWeight.w900, color: gold, height: 1.0))),
    const SizedBox(width: 6),
    Expanded(child: Text(rest, style: TextStyle(color: text, fontSize: 14, height: 1.65))),
  ]);
}

class _EditSection extends StatelessWidget {
  final String title, body; final Color color, text, sub;
  const _EditSection({required this.title, required this.body, required this.color, required this.text, required this.sub});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2, color: color)),
    const SizedBox(height: 6),
    Text(body, style: TextStyle(color: sub, fontSize: 13, height: 1.6)),
  ]);
}
