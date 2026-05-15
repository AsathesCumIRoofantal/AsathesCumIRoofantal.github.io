import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'greetings_controller.dart';

class GreetingsView extends GetView<GreetingsController> {
  const GreetingsView({Key? key}) : super(key: key);

  static const _warm = Color(0xFFEA580C);
  static const _peach = Color(0xFFFB923C);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF3B82F6);
  static const _violet = Color(0xFF7C3AED);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF0A0502) : const Color(0xFFFFF7F0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('GREETINGS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.waving_hand_rounded, color: _warm, size: 22),
        )],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('CULTURAL GREETINGS', Icons.language_rounded, _warm, onSurface),
          const SizedBox(height: 12),
          _buildCultureChips(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('GREETING CONTEXTS', Icons.forum_rounded, _teal, onSurface),
          const SizedBox(height: 12),
          _buildContextCards(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('GREETING TOOLKIT', Icons.build_rounded, _violet, onSurface),
          const SizedBox(height: 12),
          _buildToolCard(context, isDark, Icons.language_rounded, _warm, 'Cultural Greeting Library',
              'Browse a curated library of greeting customs from dozens of cultures — verbal, gestural, and written — so you can meet people on their own terms. '
              'The library is searchable by region, formality level, and context, making it a practical reference for real interactions. '
              'Each cultural entry includes pronunciation guides, the appropriate response, and notes on common mistakes made by outsiders so you can avoid the most frequent missteps.'),
          const SizedBox(height: 10),
          _buildToolCard(context, isDark, Icons.auto_awesome_rounded, _amber, 'Context-Aware Greeting Builder',
              'Generate a contextually appropriate greeting for any situation — first meeting, re-engagement, formal introduction, or community welcome — in seconds. '
              'The builder factors in the recipient\'s background, the channel, and the relationship stage to produce something that feels genuinely personal. '
              'Generated greetings can be saved as templates so your most effective openings are reusable without feeling copy-pasted.'),
          const SizedBox(height: 10),
          _buildToolCard(context, isDark, Icons.psychology_rounded, _blue, 'First Impression Principles',
              'Learn the evidence-based principles behind strong first impressions — warmth before competence, name use, and the power of genuine curiosity. '
              'These principles apply across cultures and channels, giving you a reliable foundation regardless of the specific greeting form. '
              'Principle cards include common pitfalls and real examples of how subtle changes in wording or timing dramatically shift the warmth of an opening exchange.'),
          const SizedBox(height: 10),
          _buildToolCard(context, isDark, Icons.mail_rounded, _teal, 'Welcome Message Templates',
              'Access a set of thoughtfully written welcome messages for new AIR members, guests, and collaborators that you can personalise and send in one tap. '
              'Templates save time without sacrificing warmth — they are starting points, not scripts. '
              'Welcome message effectiveness is tracked through response rates so you know which templates are landing well and which need refinement.'),
          const SizedBox(height: 10),
          _buildToolCard(context, isDark, Icons.tune_rounded, _peach, 'Greeting Tone Calibrator',
              'Adjust the formality, warmth, and length of any greeting to match the specific relationship and context you are navigating. '
              'Tone mismatches are one of the most common sources of early friction — the calibrator helps you get it right the first time. '
              'The calibrator uses a simple three-axis model: formality (casual to formal), warmth (professional to personal), and directness (indirect to direct) — adjust each slider and preview the result in real time.'),
          const SizedBox(height: 10),
          _buildToolCard(context, isDark, Icons.refresh_rounded, _rose, 'Re-engagement Opener',
              'Reconnect with someone you have not spoken to in a while using an opener that acknowledges the gap without making it awkward. '
              'Re-engagement is a skill — the right opener turns a dormant relationship into an active one with a single well-crafted message. '
              'The opener wizard prompts you to recall your last meaningful shared moment and weaves it naturally into the re-engagement so the message feels specific rather than generic.'),
          const SizedBox(height: 20),
          _buildGreetingPrinciple(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D1600), const Color(0xFF1A0900)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _warm.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _warm.withOpacity(0.12), blurRadius: 16)],
      ),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
          color: _warm.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.waving_hand_rounded, color: _peach, size: 28)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('THE ART OF THE GREETING', style: TextStyle(fontSize: 10, color: _peach, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 4),
          const Text('A well-crafted greeting is not small talk — it is the first signal of respect, and it sets the tone for everything that follows.',
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
        ])),
      ]),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildCultureChips(BuildContext context, bool isDark, Color onSurface) {
    final cultures = ['South Asian', 'East Asian', 'Middle Eastern', 'European', 'African', 'Latin American', 'Pacific', 'North American', 'AIR Community'];
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: cultures.map((c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _warm.withOpacity(0.08), borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _warm.withOpacity(0.22)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.public_rounded, size: 12, color: _peach),
          const SizedBox(width: 5),
          Text(c, style: TextStyle(fontSize: 11, color: onSurface, fontWeight: FontWeight.w500)),
        ]),
      )).toList(),
    );
  }

  Widget _buildContextCards(BuildContext context, bool isDark, Color onSurface) {
    final contexts = [
      ('First Meeting', Icons.person_add_rounded, _teal),
      ('Formal Introduction', Icons.handshake_rounded, _blue),
      ('Re-engagement', Icons.refresh_rounded, _rose),
      ('Community Welcome', Icons.groups_rounded, _violet),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5,
      children: contexts.map((c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: c.$3.withOpacity(0.07), borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.$3.withOpacity(0.20)),
        ),
        child: Row(children: [
          Icon(c.$2, color: c.$3, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(c.$1, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: onSurface))),
        ]),
      )).toList(),
    );
  }

  Widget _buildToolCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildGreetingPrinciple(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_warm.withOpacity(0.10), _amber.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _warm.withOpacity(0.22)),
      ),
      child: Row(children: [
        const Icon(Icons.lightbulb_rounded, color: _amber, size: 22),
        const SizedBox(width: 12),
        Expanded(child: Text(
          'Warmth before competence: research shows people judge you as likeable or not within milliseconds — and they remember the feeling long after they forget the words.',
          style: TextStyle(fontSize: 12, height: 1.4, color: onSurface.withOpacity(0.80)),
        )),
      ]),
    );
  }
}
