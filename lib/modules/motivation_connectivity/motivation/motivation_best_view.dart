import 'package:flutter/material.dart';

/// DESIGN: Story Bubbles — conversation-style cards with alternating alignment
class MotivationBestView extends StatelessWidget {
  const MotivationBestView({super.key});

  static const _fire = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _yellow = Color(0xFFEAB308);
  static const _lime = Color(0xFF84CC16);
  static const _green = Color(0xFF10B981);
  static const _bg = Color(0xFF0A0600);
  static const _c1 = Color(0xFF1C0F00);

  @override
  Widget build(BuildContext context) {
    final messages = [
      _Msg(isLeft: true, color: _fire, icon: Icons.rocket_launch_rounded, speaker: 'AIR Core', title: 'The Ignition', body: 'Motivation is not a feeling you wait for — it is a system you build. The difference between people who consistently act on their goals and those who don\'t is not willpower; it is architecture. Build triggers, remove friction, and stack rewards.'),
      _Msg(isLeft: false, color: _amber, icon: Icons.psychology_rounded, speaker: 'Neural Lab', title: 'The Dopamine Loop', body: 'Every motivational system exploits the brain\'s dopamine prediction circuit. Set goals just beyond comfortable reach, break them into visible milestones, and celebrate completion rituals. Your brain becomes your ally, not your adversary.'),
      _Msg(isLeft: true, color: _lime, icon: Icons.bolt_rounded, speaker: 'AIR Core', title: 'Intrinsic vs. Extrinsic', body: 'External rewards (money, praise, recognition) motivate reliably but shallowly. Internal drivers (mastery, purpose, autonomy) motivate slowly but with compounding depth. AIR helps you identify which lever is most powerful for each goal you pursue.'),
      _Msg(isLeft: false, color: _green, icon: Icons.trending_up_rounded, speaker: 'Progress Engine', title: 'The Progress Principle', body: 'Research by Teresa Amabile shows that the single strongest predictor of daily motivation is making progress on meaningful work — even small progress. AIR\'s daily log is designed to surface evidence of progress that anxiety tends to hide.'),
      _Msg(isLeft: true, color: _fire, icon: Icons.self_improvement_rounded, speaker: 'AIR Core', title: 'Motivational Seasons', body: 'Motivation is seasonal. There will be periods of fire and periods of ash. The mature practitioner does not mistake the ash phase for failure — they know it is consolidation before the next fire. Log your seasons and you will stop panicking in winter.'),
      _Msg(isLeft: false, color: _yellow, icon: Icons.people_rounded, speaker: 'Community Layer', title: 'Social Motivation', body: 'Commitment to others activates social accountability — a motivational force far more powerful than personal resolve alone. Every significant goal should have at least one witness. Public commitment is the oldest motivational technology in human culture.'),
      _Msg(isLeft: true, color: _lime, icon: Icons.wb_sunny_rounded, speaker: 'AIR Core', title: 'The Morning Protocol', body: 'The first 90 minutes after waking set the neurological tone for the entire day. A structured morning ritual — same sequence, same duration — conserves decision energy and activates the execution mindset before the world\'s demands arrive.'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _c1,
        foregroundColor: Colors.white,
        title: const Text('MOTIVATION', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.local_fire_department_rounded, color: _fire, size: 22))],
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1, color: _fire.withOpacity(0.25))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF3A1500), const Color(0xFF1C0800)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20), border: Border.all(color: _fire.withOpacity(0.3))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('MOTIVATION INTELLIGENCE', style: TextStyle(color: _fire, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 10),
              const Text('A live conversation about what actually drives consistent human action.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, height: 1.3)),
            ]),
          ),
          const SizedBox(height: 8),
          Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: _amber.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: _amber.withOpacity(0.2))), child: Text('7 messages • AIR Core + Community', style: TextStyle(color: _amber, fontSize: 9, fontWeight: FontWeight.w600)))),
          const SizedBox(height: 20),
          // MESSAGES
          ...messages.map((m) => _BubbleCard(msg: m)),
          // FINAL QUOTE
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [_fire.withOpacity(0.1), _amber.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _fire.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26),
              const SizedBox(width: 12),
              const Expanded(child: Text('"People often say that motivation doesn\'t last. Well, neither does bathing — that\'s why we recommend it daily." — Zig Ziglar', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.45, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final bool isLeft; final Color color; final IconData icon; final String speaker, title, body;
  const _Msg({required this.isLeft, required this.color, required this.icon, required this.speaker, required this.title, required this.body});
}

class _BubbleCard extends StatelessWidget {
  final _Msg msg;
  const _BubbleCard({required this.msg});
  @override
  Widget build(BuildContext context) {
    final card = Container(
      constraints: const BoxConstraints(maxWidth: 280),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: msg.color.withOpacity(0.08), borderRadius: BorderRadius.only(
          topLeft: Radius.circular(msg.isLeft ? 4 : 16), topRight: Radius.circular(msg.isLeft ? 16 : 4),
          bottomLeft: const Radius.circular(16), bottomRight: const Radius.circular(16)),
        border: Border.all(color: msg.color.withOpacity(0.22)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: msg.color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Icon(msg.icon, color: msg.color, size: 14)),
          const SizedBox(width: 6),
          Text(msg.speaker, style: TextStyle(color: msg.color, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1)),
        ]),
        const SizedBox(height: 6),
        Text(msg.title, style: TextStyle(color: msg.color, fontSize: 13, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(msg.body, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.5)),
      ]),
    );
    return Row(
      mainAxisAlignment: msg.isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [card],
    );
  }
}
