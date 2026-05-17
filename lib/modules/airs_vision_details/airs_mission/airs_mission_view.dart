import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'airs_mission_controller.dart';

class AirsMissionView extends GetView<AirsMissionController> {
  final bool isEmbedded;
  const AirsMissionView({super.key, this.isEmbedded = false});

  static const _flag = Color(0xFF0EA5E9);
  static const _blue = Color(0xFF2563EB);
  static const _cyan = Color(0xFF06B6D4);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF010510) : const Color(0xFFF0F9FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          "AIR'S MISSION",
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
            child: Icon(Icons.flag_rounded, color: _flag, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'CORE MISSION',
            Icons.stars_rounded,
            _flag,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildMissionStatement(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'STRATEGIC PRIORITIES',
            Icons.format_list_numbered_rounded,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildPriorityList(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'MISSION DETAILS',
            Icons.auto_stories_rounded,
            _cyan,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildMissionCard(
            context,
            isDark,
            Icons.gavel_rounded,
            _flag,
            'Non-Negotiable Commitments',
            'Certain principles — data integrity, user privacy, and equitable access — are never traded away for speed or profit. '
                'This section documents those commitments explicitly so they cannot be quietly eroded over time. '
                'Non-negotiables are distinguished from preferences: a preference can be traded under sufficient pressure; a non-negotiable cannot — documenting them removes the ambiguity that allows erosion to happen incrementally.',
          ),
          const SizedBox(height: 10),
          _buildMissionCard(
            context,
            isDark,
            Icons.checklist_rounded,
            _blue,
            'Mission Alignment Check',
            'Before launching any new initiative, run it through the mission alignment checklist to confirm it serves the core purpose. '
                'Misaligned initiatives are redirected or shelved, keeping the roadmap coherent and focused. '
                'The alignment check takes 10 minutes and produces a written summary that can be shared with any stakeholder questioning why an initiative was approved or declined — making the decision process transparent and repeatable.',
          ),
          const SizedBox(height: 10),
          _buildMissionCard(
            context,
            isDark,
            Icons.handshake_rounded,
            _teal,
            'Stakeholder Commitments',
            'Document the specific promises AIR has made to users, partners, and communities — and track delivery against each one. '
                'Transparency about commitments builds the trust that makes long-term collaboration possible. '
                'Each stakeholder commitment has a delivery owner, a deadline, a success metric, and a current status — making the commitment ledger a living accountability document, not a static list of aspirations.',
          ),
          const SizedBox(height: 10),
          _buildMissionCard(
            context,
            isDark,
            Icons.history_edu_rounded,
            _violet,
            'Mission History & Evolution',
            'A versioned record of how the mission statement has evolved since AIR\'s founding, with the reasoning behind each change. '
                'Understanding the evolution prevents revisionism and helps new members grasp the depth of the current direction. '
                'Version history includes the internal debate that preceded each change — the objections raised, the evidence considered, and the reasoning that ultimately prevailed — so the current mission is understood as a deliberate choice, not an inherited default.',
          ),
          const SizedBox(height: 10),
          _buildMissionCard(
            context,
            isDark,
            Icons.format_list_numbered_rounded,
            _green,
            'Strategic Priorities',
            'A ranked list of the three to five outcomes AIR is optimising for in the current operating period. '
                'Priorities are reviewed quarterly and updated transparently so every team member knows where to focus energy. '
                'Each priority includes a time horizon, a success indicator, and the current progress status — ensuring priorities remain actionable rather than becoming abstract aspirations that cannot be measured or operationalised.',
          ),
          const SizedBox(height: 10),
          _buildMissionCard(
            context,
            isDark,
            Icons.stars_rounded,
            _amber,
            'Core Mission Statement',
            'AIR exists to revolutionise industrial coordination through autonomous digitisation and community-driven verification. '
                'Every feature, policy, and partnership is evaluated against this statement before it is approved. '
                'The mission statement is intentionally compact — short enough to be memorised, specific enough to make tradeoffs obvious, and ambitious enough to inspire effort beyond what immediate incentives would produce.',
          ),
          const SizedBox(height: 20),
          _buildMissionQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF01091E), const Color(0xFF010510)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _flag.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _blue.withValues(alpha: 0.14), blurRadius: 18),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _flag.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.flag_rounded, color: _flag, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WHY AIR EXISTS',
                  style: TextStyle(
                    fontSize: 10,
                    color: _flag,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Understand the non-negotiable commitments and strategic priorities that define what AIR stands for. The mission is the decision filter applied every time AIR faces a trade-off.',
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
    );
  }

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

  Widget _buildMissionStatement(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _blue.withValues(alpha: 0.12),
            _cyan.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _flag.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CORE MISSION',
            style: TextStyle(
              fontSize: 9,
              color: _flag,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'AIR exists to revolutionise industrial coordination through autonomous digitisation and community-driven verification.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.4,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Every feature, policy, and partnership is evaluated against this statement before it is approved.',
            style: TextStyle(
              fontSize: 12,
              color: onSurface.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityList(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final priorities = [
      ('Expand community verification coverage to 50 new sectors', _flag),
      ('Achieve 99.9% data integrity across all AIR modules', _green),
      ('Onboard 100,000 new members with full orientation completion', _cyan),
      ('Launch rewards economy with first-tier partner redemptions', _amber),
    ];
    return Column(
      children: priorities
          .asMap()
          .entries
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: e.value.$2.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: e.value.$2.withValues(alpha: 0.18)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e.value.$2.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: Text(
                        '${e.key + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: e.value.$2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.value.$1,
                      style: TextStyle(
                        fontSize: 11,
                        color: onSurface,
                        height: 1.3,
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

  Widget _buildMissionCard(
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

  Widget _buildMissionQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _flag.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _flag.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"A mission is not a goal — it is a reason for existing that remains true even when every current goal has been achieved."',
              style: TextStyle(
                fontSize: 12,
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
