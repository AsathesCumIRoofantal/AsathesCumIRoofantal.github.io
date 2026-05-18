import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'punctuality_controller.dart';

class PunctualityView extends GetView<PunctualityController> {
  final bool isEmbedded;
  const PunctualityView({super.key, this.isEmbedded = false});

  static const _steel = Color(0xFF475569);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020408) : const Color(0xFFF8FAFC);

    return Container(
      color: bg,
      child: ListView(
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: isEmbedded,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'TIME INTEGRITY SCORE',
            Icons.timer_outlined,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildScorePanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'TIME INTEGRITY TOOLS',
            Icons.build_rounded,
            _sky,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            isDark,
            Icons.timer_outlined,
            _blue,
            'Time SLAs',
            'Define your personal service-level agreements for time — how early you arrive for meetings, how quickly you respond to messages, how long tasks should take. Written SLAs make accountability concrete. '
                'Personal time SLAs function like a contract with your future self: they are set when you are thinking clearly about what you value, and they govern behaviour in moments when that clarity is absent. '
                'SLA tracking produces a monthly compliance report so you can see objectively whether your time commitments are being honoured and which specific SLA categories are generating the most drift.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.hourglass_bottom_outlined,
            _amber,
            'Buffer Planning',
            'Chronic lateness is usually a planning failure, not a character flaw. Build transition buffers between commitments — 10 minutes minimum — and log how often you actually use them. '
                'Buffer use data reveals whether your schedule is genuinely realistic — if you consistently use the full buffer and still arrive tight, the buffer is too short, not your execution. '
                'The buffer planner calculates the minimum buffer needed for each recurring commute or transition type in your schedule, giving you a personalised default rather than a one-size rule.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.people_outline,
            _teal,
            'Respect for Others\' Time',
            'Every minute someone waits for you is a minute they didn\'t choose to give. Track your on-time rate for meetings and appointments and treat it as a metric worth improving. '
                'On-time rate is one of the most consistently underestimated signals of reliability — people form lasting impressions based on whether you treat their time as valuable as your own. '
                'The on-time tracker distinguishes between "arrived on time", "arrived late with warning", and "arrived late without warning" — the communication makes almost as much difference as the punctuality itself.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.event_available_outlined,
            _green,
            'Deadline Integrity',
            'A deadline is a promise. Log every deadline you commit to and your actual delivery date. The gap between the two is your integrity score — review it monthly and close it deliberately. '
                'Deadline integrity scores above 90% are associated with high trust ratings in professional settings — below 80%, trust erodes measurably even when delivery quality is high. '
                'The deadline integrity log includes a "complexity versus estimate" column so you can see whether systematic underestimation — rather than effort or commitment — is the root cause of your deadline gaps.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.notifications_active_outlined,
            _red,
            'Early Warning System',
            'When you know you\'re going to be late or miss a deadline, communicate early — not at the last minute. Log how often you give advance notice versus scrambling at the deadline. '
                'Early warning converts an implicit breach of trust into an explicit renegotiation — and people consistently rate communicating early as more respectful than silent lateness, even when the news is bad. '
                'The advance notice log measures the average lead time of your warnings — giving you data to improve from "5 minutes before" to "24 hours before" as your self-awareness of schedule risk improves.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.bar_chart_outlined,
            _blue,
            'Time Audit',
            'Where your time actually goes versus where you think it goes are rarely the same. Run a weekly time audit — log your actual hours against your intended schedule and identify the biggest gaps. '
                'Time audit data consistently reveals 2–3 significant unintentional time sinks that account for most schedule slippage, making targeted fixes far more effective than general resolve to "manage time better". '
                'The audit template takes 15 minutes to complete and generates a gap analysis chart showing planned versus actual time in each of your major categories for the week.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.alarm_outlined,
            _sky,
            'Clock Discipline',
            'Set your clocks and reminders to work for you, not against you. Review your alarm and reminder system quarterly to ensure it\'s still calibrated to your current schedule and commitments. '
                'An overloaded reminder system trains you to ignore all reminders — periodically culling unnecessary alerts preserves the signal value of the ones that remain. '
                'Clock discipline audit covers four categories: alarms (wake/sleep), meeting reminders, task nudges, and review triggers — ensuring each category is calibrated correctly rather than carrying legacy settings that no longer reflect your life.',
          ),
          const SizedBox(height: 20),
          _buildPunctualityQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF050B20), const Color(0xFF020610)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _blue.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(color: _blue.withValues(alpha: 0.10), blurRadius: 16),
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
                  Icons.schedule_outlined,
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
                      'TIME INTEGRITY',
                      style: TextStyle(
                        fontSize: 10,
                        color: _sky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Punctuality in AIR is time integrity — treating your commitments to others\' time as seriously as you treat your own. Being on time is a form of respect made visible.',
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
              _stat('94%', 'On-Time Rate', _sky),
              const SizedBox(width: 16),
              _stat('2.1h', 'Lead Time', _teal),
              const SizedBox(width: 16),
              _stat('3', 'Late This Mo.', _red),
              const SizedBox(width: 16),
              _stat('98%', 'Deadline Rate', _green),
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

  Widget _buildScorePanel(BuildContext context, bool isDark, Color onSurface) {
    final metrics = [
      ('Meeting On-Time Rate', 0.94, _sky),
      ('Deadline Integrity', 0.98, _green),
      ('Advance Notice Rate', 0.88, _teal),
      ('Buffer Usage', 0.72, _amber),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.14)),
      ),
      child: Column(
        children: metrics
            .map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          m.$1,
                          style: TextStyle(fontSize: 12, color: onSurface),
                        ),
                        Text(
                          '${(m.$2 * 100).round()}%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: m.$3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: m.$2,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: m.$3,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: m.$3.withValues(alpha: 0.30),
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
            )
            .toList(),
      ),
    );
  }

  Widget _buildCard(
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

  Widget _buildPunctualityQuote(
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
            _teal.withValues(alpha: 0.07),
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
              '"Punctuality is the soul of business." — Thomas C. Haliburton',
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
