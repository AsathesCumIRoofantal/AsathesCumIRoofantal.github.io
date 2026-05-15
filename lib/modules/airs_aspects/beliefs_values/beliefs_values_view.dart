import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'beliefs_values_controller.dart';

class BeliefsValuesView extends GetView<BeliefsValuesController> {
  const BeliefsValuesView({Key? key}) : super(key: key);

  static const _gold = Color(0xFFD97706);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _purple = Color(0xFF9333EA);
  static const _indigo = Color(0xFF4F46E5);
  static const _teal = Color(0xFF0D9488);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF080510) : const Color(0xFFFAF8FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'BELIEFS & VALUES',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.balance_rounded, color: _gold, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'CORE VALUES DECLARATION',
            Icons.star_rounded,
            _amber,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCoreValuesGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'BELIEF FRAMEWORK',
            Icons.account_tree_rounded,
            _violet,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildBeliefCard(
            context,
            isDark,
            Icons.star_rounded,
            _amber,
            'Core Values Declaration',
            'State the three to five values that guide your decisions — integrity, curiosity, service, excellence, or whatever is authentically yours — and explain what each means in practice. '
                'AIR uses your declaration to filter recommendations and flag when a proposed action conflicts with what you say you stand for. '
                'Values declarations are revisited annually to ensure they reflect genuine growth rather than remaining a static list from a single moment of reflection.',
          ),
          const SizedBox(height: 10),
          _buildBeliefCard(
            context,
            isDark,
            Icons.account_tree_rounded,
            _violet,
            'Belief Mapping',
            'Map your beliefs about people, systems, and progress — the assumptions that shape how you interpret situations and make choices. '
                'Surfacing beliefs explicitly helps you spot blind spots, challenge outdated assumptions, and communicate your worldview to collaborators more clearly. '
                'Each belief entry includes a confidence rating and a "last challenged" date, prompting you to revisit assumptions that have gone unexamined for too long.',
          ),
          const SizedBox(height: 10),
          _buildBeliefCard(
            context,
            isDark,
            Icons.fact_check_rounded,
            _teal,
            'Values-in-Action Log',
            'Track moments where you acted in alignment with your stated values — and moments where you did not — to build an honest picture of the gap between intention and behaviour. '
                'The log is private by default; it is a tool for self-awareness, not a public scorecard. '
                'Regular logging builds metacognitive clarity — the ability to observe your own patterns and make intentional adjustments rather than reacting on autopilot.',
          ),
          const SizedBox(height: 10),
          _buildBeliefCard(
            context,
            isDark,
            Icons.compass_calibration_rounded,
            _indigo,
            'Alignment Check',
            'Run a periodic alignment check that compares your recent activity, decisions, and commitments against your declared values to surface any drift. '
                'Drift is normal; catching it early and course-correcting is what separates people who live their values from those who only list them. '
                'The alignment check generates a private report visible only to you, quantifying the percentage of your recent actions that were value-consistent.',
          ),
          const SizedBox(height: 10),
          _buildBeliefCard(
            context,
            isDark,
            Icons.shield_rounded,
            _rose,
            'Ethical Boundaries',
            'Define the lines you will not cross — the actions, partnerships, or compromises that are off the table regardless of incentive or pressure. '
                'Clear ethical boundaries protect you from gradual erosion and give AIR the context to decline matching you with opportunities that violate them. '
                'Boundaries are distinguished from preferences — a boundary is a line, not a preference; documenting them with that clarity prevents rationalisation under pressure.',
          ),
          const SizedBox(height: 10),
          _buildBeliefCard(
            context,
            isDark,
            Icons.psychology_rounded,
            _purple,
            'Values Coaching',
            'Receive AIR-guided coaching prompts that help you deepen your understanding of your own values, resolve internal conflicts between competing principles, and grow your ethical clarity over time. '
                'Coaching is not prescriptive — it asks questions that help you find your own answers. '
                'Coaching sessions are archived so you can trace the evolution of your thinking over months and years, making your values journey a legible personal narrative.',
          ),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'VALUES COMPASS',
            Icons.explore_rounded,
            _gold,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCompassCard(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildInfoBanner(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3D2A00).withOpacity(isDark ? 1 : 0.6),
            const Color(0xFF1A0050).withOpacity(isDark ? 1 : 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _gold.withOpacity(0.30)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.balance_rounded, color: _amber, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR PRINCIPLES COMPASS',
                  style: TextStyle(
                    fontSize: 10,
                    color: _amber,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Articulate what you genuinely stand for so AIR can align its coaching, matching, and recommendations with your actual principles — not generic defaults.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: isDark
                        ? Colors.white70
                        : Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    Color onSurface,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCoreValuesGrid(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final values = [
      (
        'Integrity',
        Icons.verified_rounded,
        _teal,
        'Act honestly even when unseen',
      ),
      ('Curiosity', Icons.explore_rounded, _indigo, 'Stay open to being wrong'),
      (
        'Service',
        Icons.volunteer_activism_rounded,
        _violet,
        'Contribute before you extract',
      ),
      (
        'Excellence',
        Icons.workspace_premium_rounded,
        _amber,
        'Raise the floor, not just the ceiling',
      ),
      (
        'Courage',
        Icons.shield_rounded,
        _rose,
        'Act on conviction under pressure',
      ),
      (
        'Growth',
        Icons.trending_up_rounded,
        _teal,
        'Never finish becoming better',
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: values
          .map(
            (v) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: v.$3.withOpacity(0.07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: v.$3.withOpacity(0.22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(v.$2, color: v.$3, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          v.$1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    v.$4,
                    style: TextStyle(
                      fontSize: 10,
                      color: onSurface.withOpacity(0.58),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBeliefCard(
    BuildContext context,
    bool isDark,
    IconData icon,
    Color color,
    String title,
    String body,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompassCard(BuildContext context, bool isDark, Color onSurface) {
    final dimensions = [
      (
        'Towards People',
        'How do you relate to and think about others?',
        Icons.people_rounded,
        _violet,
      ),
      (
        'Towards Systems',
        'How do you approach rules, structures, and institutions?',
        Icons.account_balance_rounded,
        _indigo,
      ),
      (
        'Towards Progress',
        'What is your belief about change and growth?',
        Icons.trending_up_rounded,
        _teal,
      ),
      (
        'Towards Self',
        'What do you believe you owe yourself?',
        Icons.person_rounded,
        _amber,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.03)
            : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withOpacity(0.18)),
      ),
      child: Column(
        children: dimensions
            .map(
              (d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(d.$3, color: d.$4, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.$1,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: onSurface,
                            ),
                          ),
                          Text(
                            d.$2,
                            style: TextStyle(
                              fontSize: 11,
                              color: onSurface.withOpacity(0.60),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInfoBanner(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_amber.withOpacity(0.10), _violet.withOpacity(0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _amber.withOpacity(0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _amber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Declared values are not a performance; they are the compass AIR uses to surface opportunities and flag misalignments before they become problems.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: onSurface.withOpacity(0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
