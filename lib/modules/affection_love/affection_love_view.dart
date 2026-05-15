import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'affection_love_controller.dart';

class AffectionLoveView extends GetView<AffectionLoveController> {
  const AffectionLoveView({Key? key}) : super(key: key);

  static const _crimson = Color(0xFFBE123C);
  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _coral = Color(0xFFFB7185);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF0D9488);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF090010) : const Color(0xFFFFF1F5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('AFFECTION & LOVE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 13)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.favorite_outlined, color: _rose, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('LOVE LANGUAGES', Icons.translate_outlined, _rose, onSurface),
          const SizedBox(height: 12),
          _buildLoveLanguages(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('AFFECTION PRACTICES', Icons.spa_rounded, _pink, onSurface),
          const SizedBox(height: 12),
          _buildCard(context, isDark, Icons.do_not_disturb_outlined, _violet, 'Affection Boundaries',
              'Affection without consent is intrusion. Log the comfort levels of the people in your life — who welcomes physical warmth, who prefers verbal affirmation — and honour those preferences every time. '
              'Boundary preferences are not static — they shift with relationship depth, context, and personal circumstances. Regular check-ins are more reliable than assuming yesterday\'s comfort level persists today. '
              'Honouring stated boundaries is itself an act of love — it communicates that your affection is for the other person\'s benefit, not your own need to express.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.emoji_emotions_outlined, _coral, 'Consistent Small Gestures',
              'Grand gestures are memorable but rare. Consistent small gestures — a check-in text, a remembered detail, a moment of undivided attention — build the deepest sense of being loved. '
              'Consistency signals that your care is not performance-dependent — it continues when there is nothing to gain, no audience, and no special occasion creating obligation. '
              'The small-gesture log prompts you to note one specific micro-act of affection each day — building a practice of attentiveness that rewires attention toward the people who matter most.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.record_voice_over_outlined, _amber, 'Expressing Appreciation',
              'Telling someone specifically what you love about them is more powerful than a general "I love you." Practise naming the exact quality or action you appreciate and log the moments that matter. '
              'Specific appreciation communicates that you have actually been paying attention — and it tells the other person exactly what to keep doing, making it both emotionally nourishing and practically useful. '
              'The appreciation log includes a prompt to reflect on what each logged appreciation reveals about your own values — what you notice and name in others reflects what matters most to you.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.healing_outlined, _rose, 'Affection in Conflict',
              'Withdrawing affection during conflict is a punishment, not a boundary. Learn to stay warm even when you\'re hurt — separate the disagreement from the relationship and keep the connection intact. '
              'The ability to maintain warmth during disagreement is the single strongest predictor of relationship resilience in long-term partnership research. '
              'The "conflict warmth" log records moments where you chose to stay connected despite being hurt — each logged instance builds the emotional muscle that makes repair faster and more natural over time.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.access_time_outlined, _teal, 'Quality Time',
              'Presence is the most irreplaceable form of affection. Schedule protected time with the people you love — no phones, no agenda — and log what you did together to build a shared memory bank. '
              'Shared memory is the relational currency that funds trust during difficult periods — people with rich shared histories are more resilient in conflict and more quickly forgiving. '
              'Quality time prompts in the log include a simple question to reflect on before each session: "What does this person need from me today?" — grounding presence in awareness rather than just availability.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.translate_outlined, _pink, 'Love Languages',
              'People receive love differently — words, acts, gifts, time, or touch. Know your own love language and the languages of the people closest to you so your affection actually reaches them. '
              'Expressing love in your own language rather than the recipient\'s is a very common and very unintentional failure mode — one that leaves givers feeling unappreciated and receivers feeling uncared-for simultaneously. '
              'The love language log tracks each significant person\'s primary and secondary languages, and prompts you before significant interactions to consider which mode of expression will land most powerfully for that specific person.'),
          const SizedBox(height: 20),
          _buildLoveQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF30001A), const Color(0xFF18000D)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _rose.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _crimson.withOpacity(0.14), blurRadius: 18)],
      ),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
          color: _rose.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.favorite_outlined, color: _rose, size: 28)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('WARM & BOUNDED AFFECTION', style: TextStyle(fontSize: 9, color: _coral, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 4),
          const Text('Healthy affection holds warmth and boundaries in the same frame — generous without being intrusive, and consistent without being performative.',
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
        ])),
      ]),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildLoveLanguages(BuildContext context, bool isDark, Color onSurface) {
    final langs = [
      (Icons.chat_rounded, 'Words', _rose),
      (Icons.handyman_rounded, 'Acts', _amber),
      (Icons.card_giftcard_rounded, 'Gifts', _violet),
      (Icons.access_time_rounded, 'Time', _teal),
      (Icons.touch_app_rounded, 'Touch', _pink),
    ];
    return Row(children: langs.map((l) => Expanded(child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: l.$3.withOpacity(0.08), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: l.$3.withOpacity(0.22)),
      ),
      child: Column(children: [
        Icon(l.$1, color: l.$3, size: 18),
        const SizedBox(height: 5),
        Text(l.$2, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: onSurface)),
      ]),
    ))).toList());
  }

  Widget _buildCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildLoveQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_rose.withOpacity(0.10), _violet.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _rose.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _coral, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"The best thing to hold onto in life is each other." — Audrey Hepburn',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
