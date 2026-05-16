import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'timeline_of_air_controller.dart';

class TimelineOfAirView extends GetView<TimelineOfAirController> {
  const TimelineOfAirView({super.key});

  static const _gold = Color(0xFFD4AF37);
  static const _teal = Color(0xFF009688);
  static const _indigo = Color(0xFF3F51B5);
  static const _purple = Color(0xFF7B1FA2);
  static const _green = Color(0xFF388E3C);
  static const _orange = Color(0xFFE64A19);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0A0E1A) : const Color(0xFFF0F4FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text(
          'Timeline of AIR',
          style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeader(context, isDark),
          const SizedBox(height: 24),
          _buildStatRow(context),
          const SizedBox(height: 28),
          _buildSectionLabel(
            'FOUNDING ERA',
            Icons.flag_rounded,
            _gold,
            context,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2019',
            era: 'GENESIS',
            color: _gold,
            icon: Icons.lightbulb_rounded,
            title: 'The AIR Concept is Born',
            description:
                'The all-space intelligence framework is conceived — a bold vision to map, track, and '
                'make transparent every entity and union in existence. The foundational philosophy of '
                'Alifiyas (Explore) and Mazeasta (Rule) is authored as a living governing doctrine.',
            isFirst: true,
            isLast: false,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2020',
            era: 'FRAMEWORK',
            color: _gold,
            icon: Icons.architecture,
            title: 'First Framework Documented',
            description:
                'The dual-council model — Alifiyas overseeing the EXPLORE domain and Mazeasta governing the RULE domain — '
                'is formally documented. Entity and Union classification taxonomy v1.0 is released internally '
                'and the all-space atlas structure is defined.',
            isFirst: false,
            isLast: false,
          ),
          _buildSectionLabel(
            'GROWTH ERA',
            Icons.trending_up_rounded,
            _teal,
            context,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2021',
            era: 'FOUNDATION',
            color: _teal,
            icon: Icons.account_tree_rounded,
            title: 'Alifiyas-Mazeasta Dual Framework Ratified',
            description:
                'The full governance model is ratified. Alifiyas Council takes responsibility for all learning, '
                'identity, and public interaction touchpoints. Mazeasta Council assumes stewardship of advanced '
                'philosophical frameworks, expert supervision protocols, and earned privileges.',
            isFirst: false,
            isLast: false,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2022',
            era: 'BUILD',
            color: _teal,
            icon: Icons.phone_android_rounded,
            title: 'AIR Mobile App Development Begins',
            description:
                'Flutter is chosen as the cross-platform framework. The app\'s modular drawer navigation '
                'system — with 10 thematic sections and 80+ module pages — is architected and the '
                'core GetX state management framework is implemented.',
            isFirst: false,
            isLast: false,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2023',
            era: 'LAUNCH',
            color: _teal,
            icon: Icons.school_rounded,
            title: 'Learn & Fun Module Released',
            description:
                'The first public-facing module launches. Learners access an interactive grid of knowledge categories '
                '— Science, Art, Mathematics, Vision — each linking to AIR\'s JSON-powered document '
                'library. Community engagement passes 1,000 active sessions.',
            isFirst: false,
            isLast: false,
          ),
          _buildSectionLabel(
            'CURRENT ERA',
            Icons.radio_button_checked_rounded,
            _indigo,
            context,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2024',
            era: 'IDENTITY',
            color: _indigo,
            icon: Icons.fingerprint,
            title: 'Identity System Deployed',
            description:
                'The "Get-As-Identified" questionnaire goes live — placing every individual within their '
                'unique all-space node. The system uses a philosophical phase-based approach to map '
                'cognitive coordinates. Wisdom Mode and Expert Supervision protocols are activated.',
            isFirst: false,
            isLast: false,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2025',
            era: 'ECONOMY',
            color: _indigo,
            icon: Icons.account_balance_wallet_rounded,
            title: 'Rewards Economy & Be-You Earnings Activated',
            description:
                'The Be-You & Earn Living economy activates: users receive AIR-V credits for contributions, '
                'shared experiences, and verified posts. Identity-linked earnings are tracked in real time. '
                'The Identities Cum Earnings dashboard reaches 5,000+ logged entries.',
            isFirst: false,
            isLast: false,
          ),
          _buildSectionLabel(
            'FUTURE ROADMAP',
            Icons.explore_rounded,
            _purple,
            context,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2026',
            era: 'SCALE',
            color: _purple,
            icon: Icons.public_rounded,
            title: 'Global Atlas Expansion',
            description:
                'AIR begins full-scale mapping of global entities and unions across all seven continents. '
                'Multi-language support is rolled out. Strategic partnerships with academic institutions and '
                'organisations are formalised under the AIR Partner Programme.',
            isFirst: false,
            isLast: false,
          ),
          _buildTimelineEvent(
            context,
            isDark,
            date: '2027',
            era: 'GOVERN',
            color: _green,
            icon: Icons.gavel_rounded,
            title: 'Full Governance Mode',
            description:
                'AIR Organisation operates at full-scale governance — products, services, and the knowledge '
                'economy running end-to-end. Democratic peer-review systems, transparent decision logs, '
                'and community-driven atlas maintenance become the standard operating model.',
            isFirst: false,
            isLast: true,
          ),
          const SizedBox(height: 12),
          _buildClosingBanner(context, isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _teal.withValues(alpha: 0.18),
            _indigo.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _teal.withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _teal.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.timeline_rounded, color: _teal, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ORGANISATION HISTORY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: _teal,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Every milestone from inception to the horizon of full governance.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(BuildContext context) {
    final stats = [
      ('7+', 'Years', _gold, Icons.calendar_today_rounded),
      ('9', 'Milestones', _teal, Icons.emoji_events_rounded),
      ('80+', 'Modules', _indigo, Icons.apps_rounded),
      ('4', 'Eras', _purple, Icons.layers_rounded),
    ];
    return Row(
      children: stats
          .map(
            (s) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: s.$3.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: s.$3.withValues(alpha: 0.20)),
                ),
                child: Column(
                  children: [
                    Icon(s.$4, color: s.$3, size: 18),
                    const SizedBox(height: 6),
                    Text(
                      s.$1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: s.$3,
                      ),
                    ),
                    Text(
                      s.$2,
                      style: TextStyle(
                        fontSize: 9,
                        color: s.$3.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSectionLabel(
    String label,
    IconData icon,
    Color color,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 48),
      child: Row(
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEvent(
    BuildContext context,
    bool isDark, {
    required String date,
    required String era,
    required Color color,
    required IconData icon,
    required String title,
    required String description,
    required bool isFirst,
    required bool isLast,
  }) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.15),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.5),
                            color.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? color.withValues(alpha: 0.05)
                    : color.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: color.withValues(alpha: 0.4),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          era,
                          style: TextStyle(
                            fontSize: 9,
                            letterSpacing: 1,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClosingBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _green.withValues(alpha: 0.12),
            _teal.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _green.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'This timeline is a living document — updated as milestones are reached and '
              'historical significance becomes clearer. Contribute to it through Timeline Suggestions.',
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
