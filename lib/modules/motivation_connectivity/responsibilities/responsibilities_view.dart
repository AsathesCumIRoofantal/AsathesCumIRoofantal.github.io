import 'package:flutter/material.dart';

class ResponsibilitiesView extends StatelessWidget {
  final bool isEmbedded;
  const ResponsibilitiesView({super.key, this.isEmbedded = false});

  static const _sage = Color(0xFF15803D);
  static const _earth = Color(0xFF713F12);
  static const _terracotta = Color(0xFFEA580C);
  static const _moss = Color(0xFF4D7C0F);
  static const _sky = Color(0xFF0369A1);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF030A04) : const Color(0xFFF0FDF4);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      shrinkWrap: isEmbedded,
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      children: [
        _buildHeroHeader(context, isDark, onSurface),
        const SizedBox(height: 20),
        _buildSectionLabel(
          'DUTY DOMAINS',
          Icons.category_rounded,
          _sage,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildDomainRings(context, isDark, onSurface),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'RESPONSIBILITY DETAILS',
          Icons.list_alt_rounded,
          _earth,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildRespCard(
          context,
          isDark,
          Icons.person_rounded,
          _sage,
          'Self-Responsibility Inventory',
          'Identify the core duties you hold toward your own health, growth, finances, and mental wellbeing — the foundation everything else rests on. '
              'You cannot reliably fulfil responsibilities to others if the responsibilities to yourself are chronically neglected. '
              'The self-inventory includes a quarterly health review, a financial status check, and a growth commitments tracker — three pillars that together constitute the foundation of a responsible life.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.family_restroom_rounded,
          _earth,
          'Family Duty Map',
          'Clarify the specific responsibilities you carry within your family — care, presence, financial contribution, emotional support, and shared decisions. '
              'Making these explicit prevents the resentment that builds when family members have different assumptions about who owes what. '
              'The duty map includes a conversation guide for discussing it openly with family members so alignment is explicit rather than assumed.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.work_rounded,
          _terracotta,
          'Professional Obligations Tracker',
          'List your active professional commitments — deliverables, relationships, and role-specific duties — and track their status in one place. '
              'Professional responsibilities are often the most visible, but they are also the most likely to expand beyond sustainable limits without active management. '
              'The tracker includes a scope-creep alert that flags when new commitments are being added faster than existing ones are being closed.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.groups_rounded,
          _moss,
          'Community Contribution Planner',
          'Define how you will contribute to your community — AIR, local, or broader — in ways that are meaningful, sustainable, and matched to your capacity. '
              'Community responsibility is the outermost ring of duty, and it is where individual integrity becomes collective strength. '
              'The planner includes a capacity calculator so you never commit to community roles that would require cannibalising your self or family duties.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.balance_rounded,
          _sky,
          'Responsibility Conflict Resolver',
          'When duties in different domains collide — work versus family, self versus community — use the resolver to make a principled choice and communicate it clearly. '
              'Conflicts between responsibilities are inevitable; having a framework for resolving them prevents paralysis and preserves relationships. '
              'The resolver walks you through a five-step process: name the conflict, identify the competing values, clarify the stakes, choose deliberately, and communicate the choice with care.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.share_rounded,
          _violet,
          'Duty Delegation Guide',
          'Identify responsibilities that can be shared, delegated, or renegotiated without abandoning your core obligations. '
              'Carrying every duty alone is not virtue — it is a path to burnout that ultimately harms the people who depend on you. '
              'The delegation guide distinguishes between responsibilities you must own personally, those you can share, and those that were never really yours to begin with but which you accepted by default.',
        ),
        const SizedBox(height: 10),
        _buildRespCard(
          context,
          isDark,
          Icons.loop_rounded,
          _amber,
          'Responsibility Review Cycle',
          'Schedule a quarterly review of your full duty map to add new responsibilities, retire completed ones, and rebalance as your life evolves. '
              'Responsibilities change as circumstances change — a regular review keeps your map accurate and your commitments realistic. '
              'The quarterly review includes a wellbeing check so you can catch unsustainable loads before they cause breakdown rather than after.',
        ),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'RESPONSIBILITY LOAD',
          Icons.bar_chart_rounded,
          _amber,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildLoadMeter(context, isDark, onSurface),
        const SizedBox(height: 20),
        _buildQuoteBanner(context, isDark, onSurface),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF052E0F), const Color(0xFF0A1A05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _sage.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(
            color: _sage.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sage.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.assignment_rounded,
                  color: _sage,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DUTY MAP',
                      style: TextStyle(
                        fontSize: 10,
                        color: _sage,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Map the full landscape of what you owe — to yourself, your family, your work, and your community — so nothing important falls through the cracks.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStat('4', 'Domains', _sage),
              const SizedBox(width: 16),
              _buildStat('18', 'Active Duties', _moss),
              const SizedBox(width: 16),
              _buildStat('3', 'Review Due', _amber),
              const SizedBox(width: 16),
              _buildStat('74%', 'On Track', _sage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String v, String l, Color c) => Expanded(
    child: Column(
      children: [
        Text(
          v,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c),
        ),
        Text(
          l,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8,
            color: c.withValues(alpha: 0.8),
            height: 1.2,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    Color onSurface,
  ) => Row(
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

  Widget _buildDomainRings(BuildContext context, bool isDark, Color onSurface) {
    final domains = [
      (
        Icons.person_rounded,
        'SELF',
        'Health · Growth · Finances · Wellbeing',
        _sage,
        '5 duties',
      ),
      (
        Icons.family_restroom_rounded,
        'FAMILY',
        'Care · Presence · Support · Decisions',
        _earth,
        '4 duties',
      ),
      (
        Icons.work_rounded,
        'WORK',
        'Deliverables · Relationships · Role Duties',
        _terracotta,
        '6 duties',
      ),
      (
        Icons.groups_rounded,
        'COMMUNITY',
        'AIR · Local · Broader Contribution',
        _moss,
        '3 duties',
      ),
    ];
    return Column(
      children: domains
          .map(
            (d) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: d.$4.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: d.$4.withValues(alpha: 0.22)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: d.$4.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(d.$1, color: d.$4, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.$2,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: d.$4,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          d.$3,
                          style: TextStyle(
                            fontSize: 10,
                            color: onSurface.withValues(alpha: 0.58),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: d.$4.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      d.$5,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: d.$4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRespCard(
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
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
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
                    ).colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMeter(BuildContext context, bool isDark, Color onSurface) {
    final domains = [
      ('Self', 0.65, _sage),
      ('Family', 0.80, _earth),
      ('Work', 0.90, _terracotta),
      ('Community', 0.40, _moss),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sage.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Text(
            'Current duty load across all four domains — aim for balance, not perfection.',
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.60),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          ...domains.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d.$1,
                        style: TextStyle(fontSize: 12, color: onSurface),
                      ),
                      Text(
                        '${(d.$2 * 100).round()}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: d.$3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: d.$2,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: d.$3,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: d.$3.withValues(alpha: 0.3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteBanner(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _sage.withValues(alpha: 0.10),
            _moss.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sage.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _sage, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Duty mapping is not about guilt or obligation — it is about living with integrity by knowing your commitments and honouring them deliberately.',
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.4,
                color: onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
