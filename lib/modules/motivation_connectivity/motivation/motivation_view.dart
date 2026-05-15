import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'motivation_controller.dart';

class MotivationView extends GetView<MotivationController> {
  const MotivationView({Key? key}) : super(key: key);

  static const _blue = Color(0xFF2563EB);
  static const _indigo = Color(0xFF4F46E5);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('MOTIVATION', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: ListView(
        children: [
          _buildQuoteHero(context, isDark),
          _buildCategoryPillars(context, isDark),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionLabel('DAILY PRACTICES', Icons.wb_sunny_rounded, _blue, context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: _dailyPractices.map((p) => _buildPracticeCard(context, isDark, p)).toList()),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionLabel('MOTIVATION ARCHETYPES', Icons.category_rounded, _violet, context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildArchetypeGrid(context, isDark),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionLabel('WISDOM FROM ACHIEVERS', Icons.format_quote_rounded, _sky, context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: _wisdomQuotes.map((q) => _buildWisdomCard(context, isDark, q)).toList()),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionLabel('MOTIVATION SCIENCE', Icons.science_rounded, _teal, context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: _scienceFacts.map((f) => _buildFactCard(context, isDark, f)).toList()),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildQuoteHero(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _blue.withOpacity(isDark ? 0.20 : 0.12),
            _violet.withOpacity(isDark ? 0.15 : 0.08),
          ],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _blue.withOpacity(0.25)),
        boxShadow: [BoxShadow(color: _blue.withOpacity(0.10), blurRadius: 20, offset: const Offset(0, 6))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_quote_rounded, size: 48, color: _blue.withOpacity(0.80)),
          const SizedBox(height: 20),
          Obx(() {
            final quote = controller.quotes[controller.currentQuoteIndex.value];
            return Column(
              children: [
                Text(
                  '"${quote.text}"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300, height: 1.5),
                ),
                const SizedBox(height: 16),
                Text('— ${quote.author}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _blue)),
              ],
            );
          }),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: () => controller.nextQuote(),
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('NEXT QUOTE', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              side: BorderSide(color: _blue.withOpacity(0.50)),
              foregroundColor: _blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPillars(BuildContext context, bool isDark) {
    final categories = [
      ('Achievement', Icons.emoji_events_rounded, _blue),
      ('Resilience', Icons.shield_rounded, const Color(0xFFEA3A00)),
      ('Purpose', Icons.my_location_rounded, _teal),
      ('Growth', Icons.trending_up_rounded, _violet),
    ];
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: categories.map((c) => Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: c.$3.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.$3.withOpacity(0.25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(c.$2, color: c.$3, size: 20),
              const SizedBox(height: 6),
              Text(c.$1, style: TextStyle(fontSize: 11, color: c.$3, fontWeight: FontWeight.bold)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, BuildContext context) {
    return Row(children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
    ]);
  }

  Widget _buildPracticeCard(BuildContext context, bool isDark, _Practice p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: p.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.color.withOpacity(0.20)),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: p.color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(p.icon, color: p.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text(p.description, style: TextStyle(fontSize: 11, height: 1.4,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.68))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: p.color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(p.time, style: TextStyle(fontSize: 9, color: p.color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildArchetypeGrid(BuildContext context, bool isDark) {
    final archetypes = [
      ('The Achiever', Icons.emoji_events_rounded, _blue,
          'Driven by milestones and measurable progress. Thrives on clear goals and visible results.'),
      ('The Contributor', Icons.volunteer_activism_rounded, _teal,
          'Motivated by impact on others. Energy comes from seeing how their work improves lives.'),
      ('The Explorer', Icons.explore_rounded, _violet,
          'Fuelled by curiosity and discovery. New challenges and learning opportunities renew their drive.'),
      ('The Builder', Icons.construction_rounded, const Color(0xFFEA580C),
          'Motivated by creating something lasting. Long-term vision sustains them through short-term friction.'),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.0,
      children: archetypes.map((a) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: a.$3.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: a.$3.withOpacity(0.20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(a.$2, color: a.$3, size: 24),
            const SizedBox(height: 8),
            Text(a.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 4),
            Expanded(child: Text(a.$4, style: TextStyle(fontSize: 10, height: 1.35,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.62)),
                overflow: TextOverflow.fade)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildWisdomCard(BuildContext context, bool isDark, _WisdomQuote q) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _sky.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _sky.withOpacity(0.18)),
      ),
      child: Row(children: [
        Icon(Icons.format_quote_rounded, color: _sky.withOpacity(0.60), size: 28),
        const SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('"${q.quote}"', style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4,
                color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 4),
            Text('— ${q.person} · ${q.domain}',
                style: TextStyle(fontSize: 10, color: _sky, fontWeight: FontWeight.bold)),
          ],
        )),
      ]),
    );
  }

  Widget _buildFactCard(BuildContext context, bool isDark, _ScienceFact f) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _teal.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _teal.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _teal.withOpacity(0.14), shape: BoxShape.circle),
            child: Icon(f.icon, color: _teal, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(f.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface)),
              const SizedBox(height: 3),
              Text(f.fact, style: TextStyle(fontSize: 11, height: 1.4,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.68))),
            ],
          )),
        ],
      ),
    );
  }
}

class _Practice {
  final String title, description, time;
  final IconData icon;
  final Color color;
  const _Practice(this.title, this.description, this.time, this.icon, this.color);
}

final _dailyPractices = [
  _Practice('Morning Intention Setting', 'Write one clear intention for the day before checking any device. It anchors your energy before the world claims it.',
      '5 min', Icons.wb_sunny_rounded, Color(0xFF2563EB)),
  _Practice('Gratitude Snapshot', 'Name three specific things — not generic ones — that you are genuinely grateful for today. Specificity builds the neural pattern.',
      '3 min', Icons.favorite_rounded, Color(0xFFDB2777)),
  _Practice('Progress Review', 'At day\'s end, record one thing you moved forward today — however small. Progress, not perfection, sustains motivation.',
      '5 min', Icons.trending_up_rounded, Color(0xFF059669)),
  _Practice('Energy Alignment Check', 'Rate your energy source today: Was it fear-based or aspiration-based? Aspiration-based motivation is sustainable; fear-based burns out.',
      '2 min', Icons.bolt_rounded, Color(0xFF7C3AED)),
];

class _WisdomQuote {
  final String quote, person, domain;
  const _WisdomQuote(this.quote, this.person, this.domain);
}

final _wisdomQuotes = [
  _WisdomQuote('The secret of getting ahead is getting started.', 'Mark Twain', 'Literature'),
  _WisdomQuote('You don\'t have to be great to start, but you have to start to be great.', 'Zig Ziglar', 'Leadership'),
  _WisdomQuote('The only way to do great work is to love what you do.', 'Steve Jobs', 'Innovation'),
  _WisdomQuote('Success is not final, failure is not fatal — it is the courage to continue that counts.', 'Winston Churchill', 'Statesmanship'),
  _WisdomQuote('Believe you can and you\'re halfway there.', 'Theodore Roosevelt', 'Governance'),
];

class _ScienceFact {
  final String title, fact;
  final IconData icon;
  const _ScienceFact(this.title, this.fact, this.icon);
}

final _scienceFacts = [
  _ScienceFact('The 2-Minute Rule', 'If a task takes less than two minutes, do it immediately. This removes the decision-debt that drains motivational energy throughout the day.',
      Icons.timer_rounded),
  _ScienceFact('Implementation Intentions', 'Stating "I will do X at time Y in location Z" makes goal achievement 2-3x more likely than stating the goal alone — per Gollwitzer\'s research.',
      Icons.calendar_today_rounded),
  _ScienceFact('Dopamine & Process', 'Dopamine spikes not just on achievement but on anticipated progress. Breaking goals into visible sub-steps delivers motivational fuel more consistently.',
      Icons.science_rounded),
  _ScienceFact('Intrinsic vs. Extrinsic', 'Intrinsic motivation — doing something for its inherent value — produces longer-lasting, higher-quality effort than extrinsic rewards alone.',
      Icons.psychology_rounded),
];
