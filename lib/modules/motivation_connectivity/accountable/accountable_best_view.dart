import 'package:flutter/material.dart';

/// DESIGN: Accountability Scoreboard — commitments, check-ins, and responsibility rings
class AccountableBestView extends StatelessWidget {
  const AccountableBestView({super.key});

  static const _blue = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF030810);

  @override
  Widget build(BuildContext context) {
    final commitments = [
      _Commitment(text: 'Complete leadership module before May 22', due: 'May 22', status: 'on-track', progress: 0.72, color: _green),
      _Commitment(text: 'Weekly team 1-on-1 sessions (Thursdays)', due: 'Recurring', status: 'done', progress: 1.0, color: _green),
      _Commitment(text: 'Quarterly financial review with board', due: 'May 31', status: 'at-risk', progress: 0.25, color: _amber),
      _Commitment(text: 'Health check-up appointment', due: 'May 20', status: 'overdue', progress: 0.0, color: _red),
      _Commitment(text: 'Read 2 books in core domain this month', due: 'May 31', status: 'on-track', progress: 0.60, color: _green),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('ACCOUNTABLE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.assignment_turned_in_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // ACCOUNTABILITY SCORE
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030D20), const Color(0xFF01060E)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Row(children: [
              SizedBox(width: 90, height: 90, child: CustomPaint(painter: _ScorePainter(score: 0.82, color: _blue))),
              const SizedBox(width: 20),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('ACCOUNTABILITY SCORE', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 4),
                const Text('82/100', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                const Text('"Excellent" — Your commitment follow-through exceeds 80% of AIR users in your category.', style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.35)),
                const SizedBox(height: 8),
                Row(children: [_Tag('4 On Track', _green), const SizedBox(width: 6), _Tag('1 At Risk', _amber), const SizedBox(width: 6), _Tag('1 Overdue', _red)]),
              ])),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('ACTIVE COMMITMENTS', _blue),
          const SizedBox(height: 12),
          ...commitments.map((c) => _CommCard(c: c)),
          const SizedBox(height: 20),
          _SecHead('ACCOUNTABILITY FRAMEWORK', _teal),
          const SizedBox(height: 12),
          _AccCard(color: _blue, icon: Icons.record_voice_over_rounded, title: 'Public Commitment Power',
              body: 'Commitments made to another person are kept at a rate 60–70% higher than private intentions. The mechanism is social identity — we maintain commitments to avoid the dissonance of acting inconsistently with how others see us. Use this deliberately by choosing the right witness for each commitment.'),
          const SizedBox(height: 8),
          _AccCard(color: _teal, icon: Icons.track_changes_rounded, title: 'Pre-Commitment Devices',
              body: 'Pre-commitment is the practice of removing future choice — paying in advance, removing temptation from the environment, or creating social penalties for non-completion. It acknowledges that your future self may be weaker than your present self, and compensates in advance.'),
          const SizedBox(height: 8),
          _AccCard(color: _violet, icon: Icons.loop_rounded, title: 'Review Rhythm',
              body: 'A weekly review of all active commitments — 15 minutes on the same day each week — produces completion rates 3x higher than tracking only at deadline. The review identifies emerging problems when they are still manageable rather than after they have become failures.'),
          const SizedBox(height: 8),
          _AccCard(color: _amber, icon: Icons.people_rounded, title: 'Accountability Partners',
              body: 'An accountability partner is someone who has agreed to hold you to a specific commitment with a specific consequence for non-completion. The quality of the relationship and the specificity of the commitment are both critical — vague commitments to distant acquaintances produce poor results.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Accountability is the glue that ties commitment to results." — Bob Proctor', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Commitment { final String text, due, status; final Color color; final double progress; const _Commitment({required this.text, required this.due, required this.status, required this.color, required this.progress}); }

class _CommCard extends StatelessWidget {
  final _Commitment c;
  const _CommCard({required this.c});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: c.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: c.color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(c.text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
        const SizedBox(width: 10),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c.color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text(c.status.replaceAll('-', ' ').toUpperCase(), style: TextStyle(color: c.color, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1))),
      ]),
      const SizedBox(height: 8),
      Stack(children: [
        Container(height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(2))),
        FractionallySizedBox(widthFactor: c.progress, child: Container(height: 4, decoration: BoxDecoration(color: c.color, borderRadius: BorderRadius.circular(2)))),
      ]),
      const SizedBox(height: 5),
      Row(children: [
        Text('Due: ${c.due}', style: TextStyle(color: c.color.withOpacity(0.7), fontSize: 9)),
        const Spacer(),
        Text('${(c.progress * 100).round()}%', style: TextStyle(color: c.color, fontSize: 9, fontWeight: FontWeight.w700)),
      ]),
    ]),
  );
}

class _Tag extends StatelessWidget {
  final String l; final Color c;
  const _Tag(this.l, this.c);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(l, style: TextStyle(color: c, fontSize: 8, fontWeight: FontWeight.w700)));
}

class _ScorePainter extends CustomPainter {
  final double score; final Color color;
  _ScorePainter({required this.score, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    import 'dart:math' as math;
    final cx = size.width / 2; final cy = size.height / 2; final r = size.width / 2 - 6;
    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = color.withOpacity(0.1)..strokeWidth = 8..style = PaintingStyle.stroke);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), -math.pi / 2, 2 * math.pi * score, false, Paint()..color = color..strokeWidth = 8..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
    final tp = TextPainter(text: TextSpan(text: '${(score * 100).round()}', style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w900)), textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }
  @override bool shouldRepaint(_) => false;
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _AccCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _AccCard({required this.color, required this.icon, required this.title, required this.body});
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
