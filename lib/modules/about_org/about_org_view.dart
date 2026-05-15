import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_org_binding.dart';

class AboutOrgView extends GetView<AboutOrgController> {
  const AboutOrgView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AIR Organization',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
                : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primary.withOpacity(0.18),
                        primary.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: primary.withOpacity(0.25)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary.withOpacity(0.12),
                          border: Border.all(
                              color: primary.withOpacity(0.3), width: 2),
                        ),
                        child: Icon(Icons.corporate_fare,
                            color: primary, size: 56),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'The AIR Organisation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Steward of All-Space',
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 2,
                          color: onSurface.withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '"Mapping all-space. Ensuring absolute transparency."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: primary.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Dual council banner
                Row(
                  children: [
                    Expanded(
                      child: _councilCard(
                        'Alifiyas\nCouncil',
                        'EXPLORE domain — learning, identity, and public interactions.',
                        Icons.explore_outlined,
                        Colors.amberAccent,
                        isDark,
                        context,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _councilCard(
                        'Mazeasta\nCouncil',
                        'RULE domain — wisdom, expert supervision, and earned privileges.',
                        Icons.gavel_outlined,
                        Colors.purpleAccent,
                        isDark,
                        context,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Org sections
                ..._orgSections.map(
                  (s) => _buildSection(context, s, isDark, onSurface),
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '© 2026 AIR Organization',
                        style: TextStyle(
                          fontSize: 12,
                          color: onSurface.withOpacity(0.5),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Distributed across all-space, with core nodes globally synchronised.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: onSurface.withOpacity(0.4),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _councilCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    bool isDark,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: color,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurface.withOpacity(0.65),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _OrgSection section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: onSurface,
            ),
          ),
          iconColor: onSurface.withOpacity(0.5),
          collapsedIconColor: onSurface.withOpacity(0.4),
          children: section.points
              .map((p) => _buildPoint(p, onSurface, section.color))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPoint(String point, Color onSurface, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrgSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _OrgSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_OrgSection> _orgSections = [
  _OrgSection(
    title: 'Who We Are',
    icon: Icons.groups_outlined,
    color: Colors.blue,
    points: [
      'The AIR Organisation is a global collective of researchers, experts, and systemic architects dedicated to the Alifiyas-Mazeasta mission.',
      'We are not a corporation — we are a knowledge stewardship body whose primary obligation is to the accuracy and completeness of the all-space atlas.',
      'Members range from domain experts and philosophers to technologists, educators, and community builders across every continent.',
      'The organisation operates on a principle of radical transparency: every decision, policy, and structural change is documented and accessible.',
    ],
  ),
  _OrgSection(
    title: 'Governance Structure',
    icon: Icons.account_balance_outlined,
    color: Colors.purple,
    points: [
      'Managed by dual councils: Alifiyas (Public/Explore) and Mazeasta (Expert/Rule), ensuring a balanced ecosystem of learning and wisdom.',
      'The Alifiyas Council oversees all public-facing modules — learning, identity, community, and open knowledge.',
      'The Mazeasta Council governs expert-tier operations — philosophical frameworks, wisdom mode, and earned privileges.',
      'Decisions affecting both domains require a joint council session with documented rationale and community notification.',
      'An independent Ethics Board reviews any policy that touches privacy, identity, or community safety.',
    ],
  ),
  _OrgSection(
    title: 'Our Mission',
    icon: Icons.flag_outlined,
    color: Colors.teal,
    points: [
      'To build and maintain the definitive, real-time atlas of all existence — empowering individuals to locate themselves within the cosmic order.',
      'To ensure that every entity and union in all-space is known, mapped, and held completely transparent.',
      'To reward transparency, service, and contribution so that the act of knowing and sharing knowledge is economically sustainable.',
      'To create a world where no node of existence is uncharted, no relationship untracked, and no accountability gap unclosed.',
    ],
  ),
  _OrgSection(
    title: 'Core Values',
    icon: Icons.diamond_outlined,
    color: Colors.amber,
    points: [
      'Absolute Transparency — No hidden nodes, no concealed unions, no undisclosed conflicts of interest.',
      'Verified Knowledge — Every claim in the atlas is rated, validated, and attributed to a responsible source.',
      'Identity Respect — Each being\'s node is treated with dignity, precision, and cultural sensitivity.',
      'Continuous Evolution — The atlas grows as all-space grows; stagnation is treated as a form of inaccuracy.',
      'Universal Inclusion — From atoms to galaxies, from individuals to civilisations, no entity is excluded.',
    ],
  ),
  _OrgSection(
    title: 'Membership & Roles',
    icon: Icons.badge_outlined,
    color: Colors.green,
    points: [
      'Alifiyas Members — Public learners and explorers who engage with the knowledge ecosystem in the Explore domain.',
      'Mazeasta Members — Expert-tier participants who have earned the right to operate in the Rule domain through demonstrated wisdom.',
      'Roofantal Members — Specialist contributors who bridge the Explore and Rule domains with domain-specific expertise.',
      'Joining AIR is open to all — the path from Alifiyas to Mazeasta is earned through consistent, verified contribution over time.',
      'Membership carries responsibilities: accuracy, respect, and active participation in the atlas\'s growth.',
    ],
  ),
  _OrgSection(
    title: 'The 4-Phase Roadmap',
    icon: Icons.timeline_outlined,
    color: Colors.orange,
    points: [
      'Phase 1 — MAP: Build the complete entity and union database. Categorise all nodes in all-space with verified accuracy.',
      'Phase 2 — IDENTIFY: Deploy the Identity system globally. Every individual locates their unique node in the atlas.',
      'Phase 3 — EARN: Activate the Be-You & Earn Living economy. Users are rewarded for sharing, posting, and contributing.',
      'Phase 4 — GOVERN: Full AIR Organisation governance. Products, services, and knowledge economy operating at full scale.',
    ],
  ),
  _OrgSection(
    title: 'Location & Presence',
    icon: Icons.public_outlined,
    color: Colors.cyan,
    points: [
      'Distributed across all-space, with core nodes globally synchronised — the organisation has no single headquarters.',
      'Regional coordinators operate in each major geography to ensure cultural accuracy and local community engagement.',
      'Digital presence is the primary mode of operation — all governance, collaboration, and knowledge work happens through AIR.',
      'Physical gatherings are organised annually for deep collaboration, retrospectives, and community celebration.',
    ],
  ),
  _OrgSection(
    title: 'Contact & Engagement',
    icon: Icons.contact_mail_outlined,
    color: Colors.pinkAccent,
    points: [
      'Formal enquiries to the AIR Organisation can be submitted through the Query & Discussion module in the app.',
      'Contribution proposals — ideas, content, code, or time — are submitted through the Contribute to AIR drawer section.',
      'Partnership and integration requests are reviewed by the joint council on a quarterly basis.',
      'Community feedback that affects organisational policy is reviewed in the monthly governance session.',
    ],
  ),
];
