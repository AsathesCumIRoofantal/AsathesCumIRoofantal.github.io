import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'never_give_up_controller.dart';

class NeverGiveUpView extends GetView<NeverGiveUpController> {
  final bool isEmbedded;
  const NeverGiveUpView({super.key, this.isEmbedded = false});

  static const _ember = Color(0xFFEA3A00);
  static const _flame = Color(0xFFFF6B00);
  static const _gold = Color(0xFFFFC107);
  static const _rose = Color(0xFFE91E63);
  static const _teal = Color(0xFF00897B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F0600) : const Color(0xFFFFF3E0);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      shrinkWrap: isEmbedded,
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      children: [
        _buildMantaCard(context, isDark),
        const SizedBox(height: 20),
        _buildPersistenceBar(context, isDark),
        const SizedBox(height: 24),
        _buildSectionTitle(
          'THE THREE TESTS',
          Icons.quiz_rounded,
          _ember,
          context,
        ),
        const SizedBox(height: 12),
        _buildHoldPivot(context, isDark),
        const SizedBox(height: 24),
        _buildSectionTitle(
          'CORE FRAMEWORKS',
          Icons.architecture,
          _flame,
          context,
        ),
        const SizedBox(height: 12),
        ..._frameworks.map((f) => _buildFrameworkCard(context, isDark, f)),
        const SizedBox(height: 24),
        _buildSectionTitle(
          'MENTAL TOOLS',
          Icons.psychology_rounded,
          _gold,
          context,
        ),
        const SizedBox(height: 12),
        _buildMentalTools(context, isDark),
        const SizedBox(height: 24),
        _buildSectionTitle(
          'RESILIENCE PILLARS',
          Icons.shield_rounded,
          _teal,
          context,
        ),
        const SizedBox(height: 12),
        ..._pillars.map((p) => _buildPillarRow(context, isDark, p)),
        const SizedBox(height: 24),
        _buildSectionTitle(
          'INSPIRATION & EVIDENCE',
          Icons.bookmark_rounded,
          _rose,
          context,
        ),
        const SizedBox(height: 12),
        ..._inspirations.map((i) => _buildInspirationCard(context, isDark, i)),
        const SizedBox(height: 20),
        _buildAccountabilityBanner(context, isDark),
      ],
    );
  }

  Widget _buildMantaCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF5C0A00),
            const Color(0xFF2C0500),
            const Color(0xFF0A0000),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _ember.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: _ember.withValues(alpha: 0.20),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                color: _flame,
                size: 20,
              ),
              const SizedBox(width: 6),
              const Text(
                'PERSISTENCE IS A SKILL',
                style: TextStyle(
                  fontSize: 10,
                  color: _flame,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '"The obstacle is not the signal to stop. It is data. Process it and move."',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Build the mental frameworks and practical tools to hold the line when progress is '
            'hard — and to pivot smartly when holding the line becomes stubbornness. '
            'Persistence can be trained, not merely inherited.',
            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white60),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFireStat(
                'Day Streak',
                '47',
                Icons.calendar_today_rounded,
                _gold,
              ),
              const SizedBox(width: 20),
              _buildFireStat(
                'Obstacles Reframed',
                '13',
                Icons.psychology_rounded,
                _flame,
              ),
              const SizedBox(width: 20),
              _buildFireStat(
                'Evidence Entries',
                '28',
                Icons.savings_rounded,
                _rose,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFireStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white38,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPersistenceBar(BuildContext context, bool isDark) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ember.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: _flame,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'PERSISTENCE METER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: _flame,
                    ),
                  ),
                ],
              ),
              Text(
                '74%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.74,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_ember, _flame, _gold],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: _flame.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Keep showing up — 26% to the next Resilience Level.',
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.60),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    IconData icon,
    Color color,
    BuildContext context,
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

  Widget _buildHoldPivot(BuildContext context, bool isDark) {
    final tests = [
      (
        'Is the goal still valid?',
        'Is what you are pursuing still aligned with your deepest values and where you want to be in 5 years?',
        Icons.my_location_rounded,
        _ember,
      ),
      (
        'Is the path still viable?',
        'Can this specific route still realistically get you there, or are you hitting a structural limit — not a temporary resistance?',
        Icons.route_rounded,
        _flame,
      ),
      (
        'Is the cost still acceptable?',
        'Are the sacrifices this path requires still proportionate to the value of the goal — or has the equation shifted?',
        Icons.balance_rounded,
        _gold,
      ),
    ];
    return Column(
      children: tests
          .map(
            (t) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: t.$4.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: t.$4.withValues(alpha: 0.22)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: t.$4.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(t.$3, color: t.$4, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.$1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          t.$2,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.4,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.65),
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
    );
  }

  Widget _buildFrameworkCard(BuildContext context, bool isDark, _Framework f) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: f.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: f.color.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(f.icon, color: f.color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  f.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            f.body,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentalTools(BuildContext context, bool isDark) {
    final tools = [
      (
        Icons.zoom_out_map_rounded,
        'Obstacle Reframe',
        'Transform setbacks from verdicts on your worth into data points to process and act upon.',
        _ember,
      ),
      (
        Icons.savings_rounded,
        'Evidence Bank',
        'Record every hard thing you have already moved through — proof you can do it again.',
        _teal,
      ),
      (
        Icons.pivot_table_chart_rounded,
        'Smart Pivot Planner',
        'Plan directional shifts deliberately — preserving what was learned and redirecting cleanly.',
        _flame,
      ),
      (
        Icons.local_fire_department_rounded,
        'Streak Tracker',
        'Track consecutive days of showing up — even imperfectly — to build identity-level momentum.',
        _gold,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.95,
      children: tools
          .map(
            (t) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: t.$4.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: t.$4.withValues(alpha: 0.20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(t.$1, color: t.$4, size: 22),
                  const SizedBox(height: 8),
                  Text(
                    t.$2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      t.$3,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.62),
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPillarRow(BuildContext context, bool isDark, _Pillar p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _teal.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(p.icon, color: _teal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  p.description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.35,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.62),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspirationCard(
    BuildContext context,
    bool isDark,
    _Inspiration i,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _rose.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _rose.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${i.quote}"',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '— ${i.source}',
            style: const TextStyle(
              fontSize: 10,
              color: _rose,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountabilityBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _teal.withValues(alpha: 0.12),
            _ember.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _teal.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.people_alt_rounded, color: _teal, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACCOUNTABILITY PARTNER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: _teal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Connect with someone who checks in on your persistence commitments without judgment. '
                  'Partners are matched by domain and communication style.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.68),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Framework {
  final String title, body;
  final IconData icon;
  final Color color;
  const _Framework(this.title, this.body, this.icon, this.color);
}

final _frameworks = [
  _Framework(
    'Obstacle Reframe Tool',
    'Every time you hit a wall, log it here. The system asks: what is this obstacle '
        'actually telling you? Is it signalling a genuine dead end or merely the discomfort '
        'of meaningful growth? Reframes are stored so you can look back at how many "impossible" '
        'moments you actually navigated through successfully.',
    Icons.psychology_rounded,
    Color(0xFFEA3A00),
  ),
  _Framework(
    'Resilience Evidence Bank',
    'Humans forget their resilience in moments of doubt. The evidence bank systematically '
        'records every hard thing you have already done — challenges you faced, hard conversations '
        'you had, commitments you kept when everything urged you to abandon them. When doubt '
        'strikes, the bank provides concrete, irreversible proof.',
    Icons.savings_rounded,
    Color(0xFF00897B),
  ),
  _Framework(
    'Smart Pivot Planner',
    'A pivot is not giving up — it is applying hard-won insight to a better path. '
        'The smart pivot planner walks you through: what was learned, what is being preserved, '
        'what is being released, and what the next path commits to. Planned pivots outperform '
        'reactive ones by a significant margin.',
    Icons.fork_right_rounded,
    Color(0xFFFF6B00),
  ),
];

class _Pillar {
  final String title, description;
  final IconData icon;
  const _Pillar(this.title, this.description, this.icon);
}

final _pillars = [
  _Pillar(
    'Identity Continuity',
    'Resilience is not willpower — it is identity. People who persist are those who see persistence as part of who they are, not something they summon under pressure.',
    Icons.fingerprint,
  ),
  _Pillar(
    'Process Over Outcome',
    'Focusing solely on results makes every setback existential. Focusing on process makes every setback correctable.',
    Icons.loop_rounded,
  ),
  _Pillar(
    'Recovery Protocol',
    'Having a pre-planned recovery routine — for bad days, failures, and unexpected setbacks — removes the cognitive cost of deciding what to do when you are already depleted.',
    Icons.healing_rounded,
  ),
  _Pillar(
    'Transparent Progress',
    'Sharing your honest progress — including struggles — with a trusted community creates accountability that mere willpower cannot match.',
    Icons.visibility_rounded,
  ),
];

class _Inspiration {
  final String quote, source;
  const _Inspiration(this.quote, this.source);
}

final _inspirations = [
  _Inspiration(
    'It does not matter how slowly you go as long as you do not stop.',
    'Confucius',
  ),
  _Inspiration('The secret of getting ahead is getting started.', 'Mark Twain'),
  _Inspiration(
    'Many of life\'s failures are people who did not realise how close they were to success when they gave up.',
    'Thomas Edison',
  ),
  _Inspiration(
    'Strength does not come from what you can do. It comes from overcoming the things you thought you could not.',
    'Rikki Rogers',
  ),
];
