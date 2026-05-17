import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'relationships_controller.dart';

class RelationshipsView extends GetView<RelationshipsController> {
  final bool isEmbedded;
  const RelationshipsView({super.key, this.isEmbedded = false});

  static const _hub = Color(0xFF0EA5E9);
  static const _blue = Color(0xFF3B82F6);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020810) : const Color(0xFFF0FAFF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'RELATIONSHIPS',
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
            child: Icon(Icons.hub_outlined, color: _hub, size: 22),
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
            'NETWORK OVERVIEW',
            Icons.hub_rounded,
            _hub,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildNetworkStats(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'RELATIONSHIP TYPES',
            Icons.category_rounded,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildRelTypeGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'RELATIONSHIP TOOLS',
            Icons.build_rounded,
            _teal,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildRelCard(
            context,
            isDark,
            Icons.account_tree_outlined,
            _hub,
            'Relationship Map',
            'Visualise your network as a graph of nodes and edges, colour-coded by relationship type and strength. '
                'Seeing the whole picture at once reveals clusters, bridges, and isolated contacts that need attention. '
                'The map distinguishes between strong ties (frequent, high-trust) and weak ties (occasional, lower-trust) — both are strategically valuable, and the balance between them determines both the depth and reach of your network.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.school_outlined,
            _violet,
            'Mentors & Sponsors',
            'Record the people who invest in your growth — their areas of expertise, how often you connect, and what you owe them. '
                'Tracking mentor relationships ensures you reciprocate value and keep the connection alive. '
                'Sponsor relationships are tracked separately because sponsors actively use their influence on your behalf — different from mentors who offer wisdom — requiring a different kind of nurturing and reciprocity.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.group_outlined,
            _blue,
            'Peers & Collaborators',
            'Log colleagues and co-creators you work alongside regularly, including shared projects and communication cadence. '
                'Strong peer ties are often the fastest path to new opportunities and honest feedback. '
                'Peer network health is assessed quarterly — who have you collaborated with, who has disappeared from your radar, and who is consistently adding value to your work that you may not have explicitly acknowledged.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.family_restroom,
            _green,
            'Dependents & Responsibilities',
            'Identify people who rely on you — team members, family, or community members — and what they need from you. '
                'Clarity about dependents helps you allocate time and energy without dropping anyone. '
                'The dependents log includes an escalation flag for people whose needs are increasing, so you can proactively adjust your capacity before a dependency becomes a crisis requiring reactive triage.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.diversity_3,
            _teal,
            'Allies & Advocates',
            'Track individuals who actively champion your work or share your goals in different arenas. '
                'Allies amplify your reach; knowing who they are lets you coordinate and support them in return. '
                'Advocacy is reciprocal — the allies log prompts you to record not just who advocates for you but the specific ways you are actively championing their work, ensuring the relationship flows both directions.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.favorite_border,
            _rose,
            'Relationship Health Score',
            'Rate each relationship on recency, reciprocity, and depth to surface connections that are fading or one-sided. '
                'A health score nudges you to reach out before a valuable tie goes cold. '
                'Health scores are calculated automatically from interaction log frequency, message sentiment, and your own quarterly ratings — giving you an objective view that corrects for the subjective bias of assuming a relationship is fine because you like the person.',
          ),
          const SizedBox(height: 10),
          _buildRelCard(
            context,
            isDark,
            Icons.chat_bubble_outline,
            _amber,
            'Interaction Log',
            'Keep a timestamped record of meaningful conversations, favours exchanged, and commitments made with each contact. '
                'The log becomes invaluable context before important meetings or when resolving misunderstandings. '
                'Interaction logs are exported automatically into pre-meeting briefing summaries — arriving at a meeting with a clear recap of your last three interactions with the person visibly elevates the quality and efficiency of the conversation.',
          ),
          const SizedBox(height: 20),
          _buildRelationshipQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF001A33), const Color(0xFF000D1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _hub.withValues(alpha: 0.35)),
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
                  color: _hub.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.hub_outlined, color: _hub, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RELATIONSHIP INTELLIGENCE',
                      style: TextStyle(
                        fontSize: 9,
                        color: _hub,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Map every important tie — mentors, peers, dependents, allies — so you understand your full network. AIR helps you nurture high-value connections and spot gaps before they become liabilities.',
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
              _stat('47', 'Contacts', _hub),
              const SizedBox(width: 16),
              _stat('8', 'Mentors', _violet),
              const SizedBox(width: 16),
              _stat('12', 'Allies', _teal),
              const SizedBox(width: 16),
              _stat('6', 'Fading', _amber),
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

  Widget _buildNetworkStats(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final metrics = [
      ('Strong Ties', 0.28, _green),
      ('Health Score', 0.74, _hub),
      ('Active', 0.62, _blue),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _hub.withValues(alpha: 0.14)),
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

  Widget _buildRelTypeGrid(BuildContext context, bool isDark, Color onSurface) {
    final types = [
      (Icons.school_outlined, 'Mentors', '8', _violet),
      (Icons.group_outlined, 'Peers', '19', _blue),
      (Icons.family_restroom, 'Dependents', '6', _green),
      (Icons.diversity_3, 'Allies', '12', _teal),
      (Icons.handshake_outlined, 'Partners', '5', _hub),
      (Icons.support_agent_rounded, 'Sponsors', '2', _amber),
    ];
    return GridView.count(
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: isEmbedded,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
      children: types
          .map(
            (t) => Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: t.$4.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: t.$4.withValues(alpha: 0.20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(t.$1, color: t.$4, size: 18),
                  const SizedBox(height: 5),
                  Text(
                    t.$3,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: t.$4,
                    ),
                  ),
                  Text(
                    t.$2,
                    style: TextStyle(
                      fontSize: 9,
                      color: onSurface.withValues(alpha: 0.60),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRelCard(
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

  Widget _buildRelationshipQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _hub.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _hub.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _hub, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"The quality of your life is the quality of your relationships." — Tony Robbins',
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
