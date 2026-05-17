import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'accountable_controller.dart';

class AccountableView extends GetView<AccountableController> {
  final bool isEmbedded;
  const AccountableView({super.key, this.isEmbedded = false});

  static const _steel = Color(0xFF334155);
  static const _slate = Color(0xFF475569);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020408) : const Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'ACCOUNTABLE',
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
            child: Icon(Icons.fact_check_rounded, color: _blue, size: 22),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'COMMITMENT LEDGER',
            Icons.menu_book_rounded,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildLedgerPanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'ACCOUNTABILITY SCORE',
            Icons.score_rounded,
            _green,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildScoreCard(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'ACCOUNTABILITY TOOLS',
            Icons.build_rounded,
            _violet,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildAcctCard(
            context,
            isDark,
            Icons.assignment_ind_rounded,
            _blue,
            'Outcome Ownership Declaration',
            'Before starting any task or project, formally declare ownership so there is never ambiguity about who is responsible for the result. '
                'Declarations are timestamped and visible to relevant stakeholders, removing the grey zone where accountability usually disappears. '
                'Co-owned tasks require dual declarations, making shared accountability explicit rather than leaving it as an unspoken assumption that erodes when pressure builds.',
          ),
          const SizedBox(height: 10),
          _buildAcctCard(
            context,
            isDark,
            Icons.update_rounded,
            _sky,
            'Transparent Progress Updates',
            'Share structured progress notes at agreed intervals so stakeholders always know where things stand without having to chase you. '
                'Transparency builds trust faster than any single success, and it makes course-correction a collaborative act rather than a surprise. '
                'Update templates are pre-formatted to take under 2 minutes to complete — the friction of transparency is removed so it actually happens consistently.',
          ),
          const SizedBox(height: 10),
          _buildAcctCard(
            context,
            isDark,
            Icons.report_problem_rounded,
            _amber,
            'Miss & Learn Report',
            'When a commitment is missed, file a brief miss-and-learn report that captures what happened, why, and what changes next time. '
                'The report is not a confession — it is a signal of maturity that turns every failure into institutional knowledge. '
                'Miss reports are visible to stakeholders as evidence of honest self-reflection, and they consistently build more trust than pretending the miss did not happen.',
          ),
          const SizedBox(height: 10),
          _buildAcctCard(
            context,
            isDark,
            Icons.menu_book_rounded,
            _green,
            'Commitment Ledger',
            'Log every promise you make — to yourself, your team, or the community — and track its status from open to closed. '
                'The ledger creates a living record of your word, making it easy to spot patterns of follow-through or drift before they become habits. '
                'The ledger distinguishes between hard commitments (spoken promises with clear deadlines) and soft commitments (intentions without explicit deadlines) — both tracked, but weighted differently in your accountability score.',
          ),
          const SizedBox(height: 10),
          _buildAcctCard(
            context,
            isDark,
            Icons.swap_horiz_rounded,
            _violet,
            'Delegation Handoff Protocol',
            'When you pass a task to someone else, use the handoff protocol to transfer ownership cleanly — including context, constraints, and a clear acceptance signal. '
                'Clean handoffs prevent the accountability vacuum that forms when tasks move between people without explicit transfer. '
                'Handoffs require confirmation from the receiver before ownership is transferred in the system — no assumption of receipt without explicit acknowledgement.',
          ),
          const SizedBox(height: 10),
          _buildAcctCard(
            context,
            isDark,
            Icons.check_circle_rounded,
            _green,
            'Closure Ritual',
            'Mark completed commitments with a brief closure note that confirms the outcome and any residual actions. '
                'The ritual trains the brain to associate finishing with satisfaction, reinforcing the accountability loop at a neurological level. '
                'Closure notes are archived permanently in your commitment ledger, creating a growing evidence base of your reliability that compounds in credibility over time.',
          ),
          const SizedBox(height: 20),
          _buildAccountabilityQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF0A1628), const Color(0xFF050C14)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _blue.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(color: _blue.withValues(alpha: 0.12), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.fact_check_rounded,
                  color: _sky,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACCOUNTABILITY CENTRE',
                      style: TextStyle(
                        fontSize: 10,
                        color: _sky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Own every outcome you set in motion — through transparent ledgers, kept promises, and honest follow-through even when no one is watching.',
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
              _stat('24', 'Open', _sky),
              const SizedBox(width: 16),
              _stat('87', 'Closed', _green),
              const SizedBox(width: 16),
              _stat('3', 'Missed', _red),
              const SizedBox(width: 16),
              _stat('97%', 'Score', _amber),
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

  Widget _buildLedgerPanel(BuildContext context, bool isDark, Color onSurface) {
    final entries = [
      ('Submit Q2 Report', 'Work', _green, 'CLOSED'),
      ('Team feedback sessions', 'Work', _amber, 'OPEN'),
      ('Personal health check', 'Self', _sky, 'OPEN'),
      ('Community post this week', 'AIR', _red, 'MISSED'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: entries.asMap().entries.map((e) {
          final item = e.value;
          final isLast = e.key == entries.length - 1;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
            ),
            child: Row(
              children: [
                Icon(
                  item.$3 == _green
                      ? Icons.check_circle_rounded
                      : item.$3 == _red
                      ? Icons.cancel_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: item.$3,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                      ),
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontSize: 10,
                          color: onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: item.$3.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.$4,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: item.$3,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _green.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.97,
                  strokeWidth: 5,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  color: _green,
                ),
              ),
              const Text(
                '97%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _green,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accountability Score',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your rolling 90-day commitment-kept ratio. Private by default — share selectively to build credibility.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: onSurface.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _chip('87 closed', _green),
                    const SizedBox(width: 6),
                    _chip('3 missed', _red),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String t, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      t,
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: c),
    ),
  );

  Widget _buildAcctCard(
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

  Widget _buildAccountabilityQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _blue.withValues(alpha: 0.10),
            _green.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _sky, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Accountability is not punishment — it is the discipline of closing every loop you open.',
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
