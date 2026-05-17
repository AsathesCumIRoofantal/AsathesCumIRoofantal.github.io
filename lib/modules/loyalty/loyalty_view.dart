import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loyalty_controller.dart';

class LoyaltyView extends GetView<LoyaltyController> {
  final bool isEmbedded;
  const LoyaltyView({super.key, this.isEmbedded = false});

  static const _indigo = Color(0xFF4338CA);
  static const _violet = Color(0xFF7C3AED);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF04040E) : const Color(0xFFF5F3FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'LOYALTY',
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
            child: Icon(Icons.verified_outlined, color: _violet, size: 22),
          ),
        ],
      ),
      body: ListView(
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: isEmbedded,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'COMMITMENT TYPES',
            Icons.category_rounded,
            _indigo,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCommitmentTypes(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'LOYALTY PRINCIPLES',
            Icons.anchor_rounded,
            _violet,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.anchor_outlined,
            _indigo,
            'Long-Term Commitments',
            'Some relationships and causes deserve your unconditional investment — your family, your core team, your deepest values. Name them explicitly so you know what you are protecting when things get hard. '
                'Long-term commitments are the anchors that give you stability when circumstances shift — without them, every difficulty becomes a reason to start over rather than a reason to deepen. '
                'AIR prompts you to articulate why each long-term commitment matters to you at a values level so the "why" is clear when the "what" becomes difficult.',
          ),
          const SizedBox(height: 10),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.science_outlined,
            _sky,
            'Experimental Allegiances',
            'Not every commitment needs to be permanent. Some relationships and projects are worth a trial period — log them separately so you can evaluate honestly without guilt when the trial ends. '
                'Experimental allegiances are not lesser commitments — they are appropriate commitments for situations where permanence has not yet been earned or established. '
                'Trial periods are set explicitly at the outset so both parties understand the nature of the commitment and can have an honest conversation at the end of the trial.',
          ),
          const SizedBox(height: 10),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.thumb_up_alt_outlined,
            _green,
            'Loyalty Signals',
            'Loyalty is shown through behaviour, not declarations. Log the concrete signals you send — showing up when it\'s inconvenient, defending someone in their absence, keeping confidences under pressure. '
                'The signal log builds a record of the specific acts that make loyalty real, distinguishing genuine commitment from rhetorical allegiance. '
                'Reviewing your loyalty signal log annually reveals which relationships you are investing in and which you are maintaining in name only — a clarifying exercise that prevents unconscious neglect.',
          ),
          const SizedBox(height: 10),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.warning_outlined,
            _amber,
            'Loyalty vs. Enabling',
            'Loyalty does not mean covering for bad behaviour or staying silent when someone you care about is heading in the wrong direction. Know the line between standing by someone and enabling their worst patterns. '
                'The most loyal act is often the most difficult one — the honest conversation delivered with care, not the comfortable silence that protects the relationship at the cost of the person. '
                'AIR\'s loyalty module includes a decision framework for confronting difficult loyalty paradoxes, helping you choose between kindness and honesty when they appear to conflict.',
          ),
          const SizedBox(height: 10),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.compare_arrows_outlined,
            _blue,
            'Reciprocal Loyalty Check',
            'Loyalty should be mutual. Periodically review whether the people and organisations you are loyal to are showing up for you in return — not to keep score, but to ensure the relationship is sustainable. '
                'Chronically one-sided loyalty is not virtue — it is a pattern that eventually produces resentment or collapse. The check is not transactional; it is diagnostic. '
                'The reciprocal check helps you distinguish between a genuinely difficult season for the other party (temporary imbalance) and a structural pattern (chronic imbalance) that requires a direct conversation.',
          ),
          const SizedBox(height: 10),
          _buildLoyaltyCard(
            context,
            isDark,
            Icons.exit_to_app_outlined,
            _rose,
            'Exiting with Integrity',
            'When a commitment no longer serves either party, leaving well is the final act of loyalty. Log how you have ended commitments — did you give notice, honour obligations, and leave the door open? '
                'How you exit is remembered as much as how you contributed — a clean, honourable exit protects the relationship even when the commitment ends. '
                'The exit protocol prompts you to complete any outstanding obligations, communicate your reasons clearly, and express genuine gratitude for what the relationship produced before formally closing it.',
          ),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'LOYALTY MAP',
            Icons.map_rounded,
            _amber,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildLoyaltyMap(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildLoyaltyQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF0E0840), const Color(0xFF060420)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _violet.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _violet.withValues(alpha: 0.12), blurRadius: 18),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _violet.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  color: _violet,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DELIBERATE LOYALTY',
                      style: TextStyle(
                        fontSize: 10,
                        color: _violet,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Loyalty in AIR is about knowing where you commit long-term versus where you experiment — not blind allegiance, but a deliberate signal of deep investment.',
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
              _stat('6', 'Long-term', _violet),
              const SizedBox(width: 16),
              _stat('3', 'Trial', _sky),
              const SizedBox(width: 16),
              _stat('18', 'Signals', _green),
              const SizedBox(width: 16),
              _stat('1', 'Review Due', _amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(
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

  Widget _buildCommitmentTypes(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _indigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _indigo.withValues(alpha: 0.22)),
            ),
            child: Column(
              children: [
                const Icon(Icons.anchor_rounded, color: _indigo, size: 24),
                const SizedBox(height: 8),
                Text(
                  'Long-term',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Unconditional investment — you stay through difficulty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: onSurface.withValues(alpha: 0.60),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _sky.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _sky.withValues(alpha: 0.22)),
            ),
            child: Column(
              children: [
                const Icon(Icons.science_rounded, color: _sky, size: 24),
                const SizedBox(height: 8),
                Text(
                  'Trial-period',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Time-boxed investment — honest evaluation at the end',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: onSurface.withValues(alpha: 0.60),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoyaltyCard(
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

  Widget _buildLoyaltyMap(BuildContext context, bool isDark, Color onSurface) {
    final relationships = [
      (
        'Family',
        'Unconditional — core anchor',
        Icons.family_restroom_rounded,
        _rose,
      ),
      (
        'Core Team',
        'Long-term — invested through difficulty',
        Icons.groups_rounded,
        _indigo,
      ),
      (
        'AIR Community',
        'Long-term — shared mission',
        Icons.public_rounded,
        _violet,
      ),
      (
        'New Partnership',
        'Trial — 6 months remaining',
        Icons.handshake_rounded,
        _sky,
      ),
    ];
    return Column(
      children: relationships
          .map(
            (r) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: r.$4.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: r.$4.withValues(alpha: 0.18)),
              ),
              child: Row(
                children: [
                  Icon(r.$3, color: r.$4, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.$1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                        Text(
                          r.$2,
                          style: TextStyle(
                            fontSize: 10,
                            color: onSurface.withValues(alpha: 0.58),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLoyaltyQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _violet.withValues(alpha: 0.10),
            _indigo.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _violet.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _violet, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Loyalty is not about staying — it is about investing. The measure is not duration but the depth of presence you bring when you are tested.',
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
