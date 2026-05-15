import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'respect_controller.dart';

class RespectView extends GetView<RespectController> {
  const RespectView({Key? key}) : super(key: key);

  static const _gold = Color(0xFFD97706);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF2563EB);
  static const _violet = Color(0xFF7C3AED);
  static const _green = Color(0xFF10B981);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF060402) : const Color(0xFFFFFBF0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('RESPECT', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.balance_outlined, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('RESPECT DIMENSIONS', Icons.category_rounded, _gold, onSurface),
          const SizedBox(height: 12),
          _buildDimensionRow(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('RESPECT PRACTICES', Icons.auto_stories_rounded, _amber, onSurface),
          const SizedBox(height: 12),
          _buildRespCard(context, isDark, Icons.badge_outlined, _gold, 'Titles & Forms of Address',
              'Using someone\'s preferred name and title is the smallest possible act of respect — and skipping it is a loud signal. Log the preferences of people you interact with regularly and honour them without being reminded. '
              'Name use signals that you see the person as an individual rather than a role or a function — it is a micro-act of recognition that compounds across thousands of interactions into a reputation for attentiveness. '
              'The preference log syncs with your communication templates so your default addressing style automatically reflects each person\'s stated preference rather than requiring active recall.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.do_not_disturb_alt_outlined, _teal, 'Boundary Awareness',
              'Boundaries are not obstacles — they are the terms under which someone can engage with you safely. Learn the stated and unstated limits of the people around you and treat them as hard constraints. '
              'Unstated boundaries are the harder ones — they require observation, not just listening. Watch for what people consistently decline, avoid, or deflect, and treat the pattern as a boundary even without an explicit statement. '
              'The boundary log distinguishes between personal, professional, and communication boundaries so you can respect someone fully across all the contexts in which your relationship operates.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.shield_outlined, _violet, 'Dignity Defaults',
              'Every person deserves basic dignity regardless of their status, performance, or relationship to you. Define your dignity defaults — how you speak about people when they\'re not in the room. '
              'The behind-closed-doors test: if the person you are discussing could hear what you are saying, would they feel seen and fairly treated? Dignity defaults require passing this test consistently, not just in public. '
              'Dignity defaults are especially tested in hierarchies — how you speak about and treat people with less institutional power than you is the most reliable measure of your actual respect ethic.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.hearing_outlined, _blue, 'Listening as Respect',
              'Interrupting, checking your phone, or half-listening signals that your thoughts matter more than theirs. Practise full-presence listening as a concrete act of respect in every conversation. '
              'Full-presence listening means your goal for the next 2 minutes is to understand, not to respond. The shift from listening-to-reply to listening-to-understand is felt by the speaker and changes the entire character of the conversation. '
              'A weekly listening log tracks the ratio of times you interrupted versus listened to completion — not to create guilt, but to give you honest data on a behaviour that is far more automatic than most people realise.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.forum_outlined, _green, 'Disagreement with Dignity',
              'You can challenge an idea without diminishing the person who holds it. Log how you handle disagreements — are you attacking the argument or the person? Respect survives conflict when the distinction is clear. '
              'The language of respectful disagreement: "I see it differently, and here\'s why" rather than "you\'re wrong"; "I didn\'t follow that reasoning" rather than "that makes no sense". The shift is small; the effect on the relationship is large. '
              'Disagreement done with dignity actually deepens respect — it signals that you take the other person seriously enough to engage their ideas rather than dismissing them or deferring to avoid conflict.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.swap_vert_outlined, _amber, 'Respect Under Hierarchy',
              'Respect flows in all directions — not just upward to authority. How you treat people with less power than you is the truest measure of your character. Track your behaviour with subordinates and service workers. '
              'Downward respect is the hardest to maintain because there is no immediate social cost to failing — but there is a long-term culture cost, because every person you disrespect observes and communicates how you treat others. '
              'The directional respect audit covers four directions: upward (to authority), lateral (to peers), downward (to those with less power), and outward (to strangers and service workers) — all four must pass the dignity default test.'),
          const SizedBox(height: 10),
          _buildRespCard(context, isDark, Icons.build_circle_outlined, _rose, 'Repair After Disrespect',
              'Everyone slips. What matters is whether you notice, own it, and repair it. Log instances where you fell short of your respect standards and the steps you took to make it right. '
              'Effective repair has three elements: acknowledgement (naming what happened without minimising), apology (taking responsibility without deflecting), and action (changing the specific behaviour that caused the harm). '
              'The repair log prevents the accumulation of unaddressed disrespect incidents that quietly erode trust — each logged repair is evidence of the self-awareness and accountability that make respect a genuine practice rather than a performance.'),
          const SizedBox(height: 20),
          _buildRespectQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF2D1A00), const Color(0xFF160C00)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _gold.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _gold.withOpacity(0.10), blurRadius: 16)],
      ),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
          color: _gold.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.balance_outlined, color: _amber, size: 28)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('CONSISTENT RESPECT PRACTICE', style: TextStyle(fontSize: 9, color: _amber, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 4),
          const Text('Respect in AIR is about establishing clear baselines — how you address people, honour their boundaries, and protect their dignity by default. It\'s not earned once; it\'s practised consistently.',
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
        ])),
      ]),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildDimensionRow(BuildContext context, bool isDark, Color onSurface) {
    final dims = [
      (Icons.badge_rounded, 'Address', _gold),
      (Icons.shield_rounded, 'Dignity', _violet),
      (Icons.hearing_rounded, 'Listening', _blue),
      (Icons.forum_rounded, 'Conflict', _green),
    ];
    return Row(children: dims.map((d) => Expanded(child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: d.$3.withOpacity(0.07), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: d.$3.withOpacity(0.20)),
      ),
      child: Column(children: [
        Icon(d.$1, color: d.$3, size: 20),
        const SizedBox(height: 5),
        Text(d.$2, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: onSurface)),
      ]),
    ))).toList());
  }

  Widget _buildRespCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(
          color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 12, height: 1.5, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
        ])),
      ]),
    );
  }

  Widget _buildRespectQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_gold.withOpacity(0.10), _teal.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Respect for ourselves guides our morals; respect for others guides our manners." — Laurence Sterne',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
