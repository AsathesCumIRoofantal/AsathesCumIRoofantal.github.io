// ============================================================
// web_modules/web_setup_page.dart
// Route: /web-setup  →  WebSetupPage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebSetupPage extends StatelessWidget {
  const WebSetupPage({super.key});

  static const String routeName = '/web-setup';

  static final _tools = [
    _Tool(
      Icons.all_inclusive_rounded,
      'Digitalize Records',
      'Transform physical records, assets, and processes into verified digital entries within All-Space.',
      WColors.indigo,
      'Core',
    ),
    _Tool(
      Icons.assessment_rounded,
      'Projects & Assessments',
      'Plan, track, and evaluate projects with structured templates and peer-review workflows.',
      WColors.teal,
      'Productivity',
    ),
    _Tool(
      Icons.local_florist_rounded,
      'Category Tree',
      'Build and browse the living taxonomy of All-Space — every concept has a branch.',
      WColors.emerald,
      'Organisation',
    ),
    _Tool(
      Icons.handyman_rounded,
      'Ease Tools',
      'Utility toolkit — calculators, converters, templates, and quick-access helpers.',
      WColors.amber,
      'Utility',
    ),
    _Tool(
      Icons.wordpress_rounded,
      'Vocabulary',
      'AIR-specific glossary with definitions, usage examples, and community annotations.',
      WColors.violet,
      'Reference',
    ),
    _Tool(
      Icons.code_rounded,
      'Code & Conduct',
      'The complete code of conduct governing behaviour, contribution, and interaction in All-Space.',
      WColors.sky,
      'Governance',
    ),
    _Tool(
      Icons.video_collection_rounded,
      'Script & Strategy',
      'Communication templates, content scripts, and strategic playbooks.',
      WColors.rose,
      'Strategy',
    ),
    _Tool(
      Icons.safety_check_rounded,
      'Safety',
      'Protocols, emergency contacts, and risk frameworks for every layer of All-Space activity.',
      WColors.emerald,
      'Safety',
    ),
    _Tool(
      Icons.self_improvement_rounded,
      'Hospitality & Care',
      'Standards and practices for welcoming, supporting, and caring for every member.',
      WColors.teal,
      'People',
    ),
    _Tool(
      Icons.amp_stories_rounded,
      'Utility & Facilities',
      'Physical and digital facility management for AIR-affiliated spaces.',
      WColors.indigo,
      'Infrastructure',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'SETUP  A-ONE', color: WColors.teal),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WHeroBanner(
              title: 'Set Up Your Perfect Operation',
              subtitle:
                  'The A-One toolkit gives you everything you need to '
                  'digitise, organise, and run a flawless presence inside '
                  'All-Space — from vocabulary to safety protocols.',
              colorA: const Color(0xFF134E4A),
              colorB: const Color(0xFF0D9488),
              icon: Icons.settings_suggest_rounded,
            ),

            const SizedBox(height: 48),

            // Quick-start guide
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WSectionHeader(
                    eyebrow: 'Quick Start',
                    title: 'Three steps to A-One',
                    accent: WColors.teal,
                  ),
                  const SizedBox(height: 24),
                  WGrid(
                    forceColumns: WBreak.isMobile(context) ? 1 : 3,
                    children: [
                      _StepCard(
                        n: '01',
                        title: 'Digitalize',
                        body:
                            'Record your existing assets, content, and identity data into All-Space.',
                        color: WColors.teal,
                        isDark: isDark,
                      ),
                      _StepCard(
                        n: '02',
                        title: 'Organise',
                        body:
                            'Assign everything to the right branch of the Category Tree and apply your Code of Conduct.',
                        color: WColors.indigo,
                        isDark: isDark,
                      ),
                      _StepCard(
                        n: '03',
                        title: 'Operate',
                        body:
                            'Use Ease Tools, Scripts, and Safety protocols to run your presence smoothly.',
                        color: WColors.amber,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Tools grid
            Container(
              color: isDark ? const Color(0xFF0F2027) : const Color(0xFFF0FDFA),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  children: [
                    const WSectionHeader(
                      eyebrow: 'All Tools',
                      title: 'The A-One Toolkit',
                      accent: WColors.teal,
                    ),
                    const SizedBox(height: 28),
                    WGrid(
                      children: _tools
                          .map((t) => _ToolCard(t: t, isDark: isDark))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Checklist
            const SizedBox(height: 40),
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WSectionHeader(
                    eyebrow: 'Setup Checklist',
                    title: 'Are you A-One ready?',
                    accent: WColors.teal,
                  ),
                  const SizedBox(height: 20),
                  ..._CheckItem.items.map(
                    (c) => _CheckTile(c: c, isDark: isDark),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

// ── Data & widgets ────────────────────────────────────────────
class _Tool {
  final IconData icon;
  final String title, body, tag;
  final Color color;
  const _Tool(this.icon, this.title, this.body, this.color, this.tag);
}

class _ToolCard extends StatelessWidget {
  final _Tool t;
  final bool isDark;
  const _ToolCard({required this.t, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: t.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: t.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(t.icon, color: t.color, size: 20),
              ),
              const SizedBox(width: 8),
              WBadge(label: t.tag, color: t.color),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            t.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.5,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            t.body,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: t.color,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Open →',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String n, title, body;
  final Color color;
  final bool isDark;
  const _StepCard({
    required this.n,
    required this.title,
    required this.body,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            n,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: color.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckItem {
  final String label;
  final bool done;
  const _CheckItem(this.label, this.done);

  static const items = [
    _CheckItem('Create your All-Space identity profile', true),
    _CheckItem('Digitalize at least one record or asset', true),
    _CheckItem('Explore and bookmark three learning modules', false),
    _CheckItem('Review the Code & Conduct document', false),
    _CheckItem('Set up your business or project page', false),
    _CheckItem('Connect with at least two other members', false),
  ];
}

class _CheckTile extends StatelessWidget {
  final _CheckItem c;
  final bool isDark;
  const _CheckTile({required this.c, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : WColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: c.done
              ? WColors.teal.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            c.done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: c.done
                ? WColors.teal
                : (isDark ? Colors.white24 : Colors.black26),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              c.label,
              style: TextStyle(
                fontSize: 14,
                decoration: c.done ? TextDecoration.lineThrough : null,
                color: c.done
                    ? (isDark ? Colors.white38 : Colors.black38)
                    : (isDark ? Colors.white70 : const Color(0xFF0F172A)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
