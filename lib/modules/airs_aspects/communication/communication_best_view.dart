import 'package:flutter/material.dart';

/// DESIGN: Communication Flow — signal-flow diagram with message type cards
class CommunicationBestView extends StatelessWidget {
  const CommunicationBestView({super.key});

  static const _sky = Color(0xFF0EA5E9);
  static const _blue = Color(0xFF2563EB);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _rose = Color(0xFFF43F5E);
  static const _bg = Color(0xFF020A10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('COMMUNICATION', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.cell_tower_rounded, color: _sky, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF001A24), _sky.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _sky.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('COMMUNICATION INTELLIGENCE', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('How you communicate determines what you achieve — more reliably than what you know or how hard you work.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35)),
            ]),
          ),
          const SizedBox(height: 20),
          // COMMUNICATION TYPES FLOW
          _SecHead('COMMUNICATION CHANNELS', _sky),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _ChannelBox(color: _sky, icon: Icons.face_rounded, title: 'Face-to-Face', bandwidth: 'Highest', retention: '80%', best: 'Complex, emotional, or high-stakes')),
            const SizedBox(width: 8),
            Expanded(child: _ChannelBox(color: _blue, icon: Icons.call_rounded, title: 'Voice Call', bandwidth: 'High', retention: '65%', best: 'Nuanced discussions, quick decisions')),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _ChannelBox(color: _teal, icon: Icons.videocam_rounded, title: 'Video Call', bandwidth: 'High', retention: '70%', best: 'Remote relationships, visual demos')),
            const SizedBox(width: 8),
            Expanded(child: _ChannelBox(color: _green, icon: Icons.email_rounded, title: 'Written', bandwidth: 'Medium', retention: '60%', best: 'Formal, reference, complex data')),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _ChannelBox(color: _amber, icon: Icons.chat_rounded, title: 'Messaging', bandwidth: 'Low', retention: '45%', best: 'Quick status, simple coordination')),
            const SizedBox(width: 8),
            Expanded(child: _ChannelBox(color: _violet, icon: Icons.people_rounded, title: 'Broadcast', bandwidth: 'Low', retention: '20%', best: 'Awareness, not understanding')),
          ]),
          const SizedBox(height: 20),
          // COMMUNICATION PRINCIPLES
          _SecHead('COMMUNICATION PRINCIPLES', _teal),
          const SizedBox(height: 12),
          _CommCard(color: _sky, icon: Icons.hearing_rounded, title: 'The 70/30 Rule',
              body: 'In any important conversation, listen 70% of the time and speak 30%. The person who speaks less typically controls the conversation — they ask better questions, synthesise what they hear, and speak with precision because they have listened first.'),
          const SizedBox(height: 8),
          _CommCard(color: _blue, icon: Icons.architecture_rounded, title: 'Structure First',
              body: 'The most common communication failure is structure, not vocabulary. Before any important communication — email, meeting, presentation — write the answer first, then the supporting points, then the context. This "answer-first" structure respects the listener\'s time and attention.'),
          const SizedBox(height: 8),
          _CommCard(color: _green, icon: Icons.loop_rounded, title: 'The Feedback Loop',
              body: 'Communication is not complete when something is said — it is complete when understanding is confirmed. Building feedback mechanisms (explicit confirmation, follow-up questions, summarisation requests) into your communication architecture closes the loop that most communicators leave open.'),
          const SizedBox(height: 8),
          _CommCard(color: _violet, icon: Icons.translate_rounded, title: 'Audience Calibration',
              body: 'The same information communicated at the wrong depth, speed, or vocabulary level fails regardless of accuracy. The skilled communicator continuously monitors the audience\'s comprehension signals and adjusts in real time — often before conscious confusion becomes visible.'),
          const SizedBox(height: 8),
          _CommCard(color: _rose, icon: Icons.do_not_disturb_rounded, title: 'Productive Silence',
              body: 'Silence in communication is not absence — it is presence without words. The willingness to hold silence after asking a question, after making a difficult statement, or after receiving difficult information is a high-bandwidth communication signal that most people underuse.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_sky.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _sky.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"The single biggest problem in communication is the illusion that it has taken place." — George Bernard Shaw', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ChannelBox extends StatelessWidget {
  final Color color; final IconData icon; final String title, bandwidth, retention, best;
  const _ChannelBox({required this.color, required this.icon, required this.title, required this.bandwidth, required this.retention, required this.best});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(icon, color: color, size: 16), const SizedBox(width: 6), Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800))]),
      const SizedBox(height: 6),
      _Row('Bandwidth', bandwidth),
      _Row('Retention', retention),
      const SizedBox(height: 4),
      Text(best, style: const TextStyle(color: Colors.white38, fontSize: 9, height: 1.3)),
    ]),
  );
  Widget _Row(String k, String v) => Padding(padding: const EdgeInsets.only(bottom: 3), child: Row(children: [Text('$k:', style: const TextStyle(color: Colors.white30, fontSize: 9)), const SizedBox(width: 4), Text(v, style: TextStyle(color: const Color(0xFF10B981), fontSize: 9, fontWeight: FontWeight.w700))]));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _CommCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _CommCard({required this.color, required this.icon, required this.title, required this.body});
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
