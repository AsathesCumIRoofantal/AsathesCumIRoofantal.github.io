import 'package:flutter/material.dart';

/// DESIGN: Resilience Streak — persistence tracker with comeback stories
class NeverGiveUpBestView extends StatelessWidget {
  const NeverGiveUpBestView({super.key});

  static const _fire = Color(0xFFEA580C);
  static const _orange = Color(0xFFF97316);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFDC2626);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF0A0200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('NEVER GIVE UP', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.local_fire_department_rounded, color: _fire, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // FIRE HERO
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF2A0800), const Color(0xFF140400)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(22), border: Border.all(color: _fire.withOpacity(0.4)),
            ),
            child: Stack(children: [
              Positioned(right: -30, bottom: -30, child: Icon(Icons.local_fire_department_rounded, size: 160, color: _fire.withOpacity(0.06))),
              Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(children: [
                  Icon(Icons.local_fire_department_rounded, color: _fire, size: 32),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('🔥 STREAK: 47 DAYS', style: TextStyle(color: _amber, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    Text('Personal best: 62 days', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  ]),
                ]),
                const SizedBox(height: 12),
                const Text('Every day you keep going is a vote for who you are becoming.', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w700, height: 1.3)),
              ])),
            ]),
          ),
          const SizedBox(height: 20),
          // COMEBACK STORIES
          _SecHead('RESILIENCE ARCHIVE', _fire),
          const SizedBox(height: 12),
          _ComebackCard(name: 'Walt Disney', attempt: 'Fired by newspaper editor for lacking imagination. Multiple business bankruptcies before age 40.', result: 'Built one of the most successful entertainment empires in history.', color: _orange),
          const SizedBox(height: 8),
          _ComebackCard(name: 'J.K. Rowling', attempt: 'Harry Potter rejected by 12 publishers. Living on welfare as a single mother before first publication.', result: 'Became the first author to reach billionaire status through writing.', color: _violet),
          const SizedBox(height: 8),
          _ComebackCard(name: 'Michael Jordan', attempt: 'Cut from his high school basketball team. Missed 9,000 shots. Lost 300 games.', result: 'Widely considered the greatest basketball player of all time.', color: _sky),
          const SizedBox(height: 8),
          _ComebackCard(name: 'Colonel Sanders', attempt: 'KFC recipe rejected by 1,009 restaurants before first acceptance.', result: 'KFC is now one of the most recognised brands in the world.', color: _red),
          const SizedBox(height: 20),
          // RESILIENCE PRINCIPLES
          _SecHead('RESILIENCE PRINCIPLES', _amber),
          const SizedBox(height: 12),
          _ResCard(color: _fire, icon: Icons.refresh_rounded, title: 'The Comeback Formula',
              body: 'Resilience is not the absence of failure — it is the speed and quality of recovery. Every resilient person has a recovery protocol: acknowledge the failure fully, extract the lesson completely, and re-engage with a revised approach. The protocol turns setbacks into data.'),
          const SizedBox(height: 8),
          _ResCard(color: _orange, icon: Icons.psychology_rounded, title: 'Reframing Without Denial',
              body: 'The resilient reframe failures as experiments: "That approach didn\'t work" rather than "I failed." This reframe is not denial — it is precision. The approach failed; you, as a capable person who can try different approaches, did not fail. The distinction matters enormously for what comes next.'),
          const SizedBox(height: 8),
          _ResCard(color: _violet, icon: Icons.people_rounded, title: 'Support Architecture',
              body: 'Resilience is not a solo sport. The most resilient people in the historical record had strong support networks — people who believed in them during the periods they struggled to believe in themselves. Building your support architecture before you need it is the single highest-leverage resilience investment.'),
          const SizedBox(height: 8),
          _ResCard(color: _green, icon: Icons.trending_up_rounded, title: 'Progress Visibility',
              body: 'Progress is often invisible to the person making it — especially during the slow, compounding early phase. AIR\'s progress visualiser makes invisible growth visible: the number of attempts, the distance from starting point, the trajectory implied by the current data. Seeing progress sustains the motivation to continue.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_fire.withOpacity(0.10), _amber.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _fire.withOpacity(0.25))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"It\'s not about how hard you hit. It\'s about how hard you can get hit and keep moving forward." — Rocky Balboa', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ComebackCard extends StatelessWidget {
  final String name, attempt, result; final Color color;
  const _ComebackCard({required this.name, required this.attempt, required this.result, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.close_rounded, color: const Color(0xFFEF4444).withOpacity(0.7), size: 14),
        const SizedBox(width: 6),
        Expanded(child: Text(attempt, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4))),
      ]),
      const SizedBox(height: 6),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.check_rounded, color: const Color(0xFF10B981), size: 14),
        const SizedBox(width: 6),
        Expanded(child: Text(result, style: const TextStyle(color: Colors.white80, fontSize: 11, height: 1.4))),
      ]),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _ResCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ResCard({required this.color, required this.icon, required this.title, required this.body});
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
