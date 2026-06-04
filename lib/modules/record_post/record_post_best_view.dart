import 'dart:math' as math;

import 'package:air_app/modules/record_post/record_post_enhanced_view.dart';
import 'package:flutter/material.dart';

import 'record_post_view.dart';

/// RecordPostBestView
/// Auto-generated showcase view — Design Pattern: Aurora / hero:mesh / section:cards.
/// Wraps and preserves the original RecordPostView at the bottom so no
/// content is lost. Designed to demonstrate unique UI/UX per page.
class RecordPostBestView extends StatelessWidget {
  const RecordPostBestView({super.key});

  static const Color _primary = Color(0xFF6366F1);
  static const Color _secondary = Color(0xFFEC4899);
  static const Color _accent = Color(0xFFF59E0B);
  static const Color _bgLight = Color(0xFFF5F3FF);
  static const Color _bgDark = Color(0xFF0B0820);

  static const List<_Pillar> _pillars = [
    _Pillar(
      "Foundations",
      "The bedrock principles that make Record Post meaningful — clarified, named, and put to work in daily decisions.",
      Icons.explore_rounded,
    ),
    _Pillar(
      "Practices",
      "Repeatable habits and rituals that compound the impact of Record Post over weeks, months and years.",
      Icons.auto_awesome_rounded,
    ),
    _Pillar(
      "Outcomes",
      "Tangible markers that prove Record Post is alive in your life — not as theory, but as visible results.",
      Icons.loyalty_rounded,
    ),
    _Pillar(
      "Frontiers",
      "Where Record Post stretches into new territory — challenges to attempt, questions to sit with, and edges to push.",
      Icons.explore_rounded,
    ),
  ];
  static const List<_StepCard> _steps = [
    _StepCard(
      "Observe",
      "Watch Record Post carefully without rushing to judgement. The first move is noticing.",
    ),
    _StepCard(
      "Orient",
      "Place what you see inside the wider map of your goals, relationships and values.",
    ),
    _StepCard(
      "Decide",
      "Commit to one concrete next move. Indecision is a quiet cost.",
    ),
    _StepCard(
      "Act",
      "Do the smallest meaningful thing today — momentum beats perfection.",
    ),
    _StepCard(
      "Reflect",
      "At the end of the day, examine what worked and what didn't, kindly.",
    ),
    _StepCard(
      "Refine",
      "Iterate the practice. Drop what's noise; double the signal.",
    ),
  ];
  static const List<String> _actions = [
    "Spend 10 minutes today journaling on one aspect of Record Post.",
    "Share an insight about Record Post with one person who matters to you.",
    "Identify one obstacle currently blocking your progress.",
    "Schedule a weekly review specifically focused on Record Post.",
    "Read or watch one resource that deepens your understanding.",
    "Teach what you have learned — teaching anchors knowledge.",
  ];
  static const List<_Stat> _stats = [
    _Stat("87%", "of practitioners report measurable progress within 30 days"),
    _Stat("3x", "long-term impact when Record Post is paired with reflection"),
    _Stat("12", "core principles distilled from years of practice"),
    _Stat("∞", "compounding returns when the habit is sustained"),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? _bgDark : _bgLight;
    final onSurface = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            stretch: true,
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            title: const Text(
              'Record Post',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                fontSize: 16,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroMesh(
                primary: _primary,
                secondary: _secondary,
                accent: _accent,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: _Intro(
                title: 'Record Post',
                primary: _primary,
                secondary: _secondary,
                accent: _accent,
                onSurface: onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: _SectionLabel(
                label: 'CORE LANDSCAPE',
                icon: Icons.explore_rounded,
                color: _primary,
                onSurface: onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: _CardsRow(
                steps: _steps,
                primary: _primary,
                secondary: _secondary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: _SectionLabel(
                label: 'PRACTICE LOOP',
                icon: Icons.auto_awesome_rounded,
                color: _secondary,
                onSurface: onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: _ActionList(
                actions: _actions,
                primary: _primary,
                secondary: _secondary,
                accent: _accent,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: _SectionLabel(
                label: 'BY THE NUMBERS',
                icon: Icons.loyalty_rounded,
                color: _accent,
                onSurface: onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: _StatsBlock(
                stats: _stats,
                primary: _primary,
                secondary: _secondary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: _Quote(
                text:
                    'When record post becomes a practice rather than an idea, the whole story changes.',
                primary: _primary,
                secondary: _secondary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: _OriginalBanner(primary: _primary, secondary: _secondary),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          // Original page content embedded below — nothing is lost
          ...RecordPostEnhancedView(isEmbedded: true, isDark: isDark).slivers,
          SliverToBoxAdapter(child: RecordPostView(isEmbedded: true)),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ============================================================================
// SHARED MICRO-WIDGETS (kept in this file to keep the page self-contained)
// ============================================================================
class _Pillar {
  final String name;
  final String description;
  final IconData icon;
  const _Pillar(this.name, this.description, this.icon);
}

class _StepCard {
  final String name;
  final String description;
  const _StepCard(this.name, this.description);
}

class _Stat {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
}

class _Intro extends StatelessWidget {
  final String title;
  final Color primary, secondary, accent, onSurface;
  const _Intro({
    required this.title,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withValues(alpha: 0.08),
            secondary.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SHOWCASE',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'BEST VIEW',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A focused, opinionated tour of $title — distilled into four pillars, a practice loop, '
            'concrete actions you can take this week, and the data that proves it works. '
            'Original content is preserved further down the page.',
            style: TextStyle(
              color: onSurface.withValues(alpha: 0.78),
              fontSize: 14.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color, onSurface;
  const _SectionLabel({
    required this.label,
    required this.icon,
    required this.color,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: onSurface,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(height: 1, color: color.withValues(alpha: 0.25)),
        ),
      ],
    );
  }
}

class _ActionList extends StatelessWidget {
  final List<String> actions;
  final Color primary, secondary, accent;
  const _ActionList({
    required this.actions,
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        actions.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: primary.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [primary, secondary]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  actions[i],
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  final String text;
  final Color primary, secondary;
  const _Quote({
    required this.text,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primary, secondary]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: Colors.white70,
            size: 28,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OriginalBanner extends StatelessWidget {
  final Color primary, secondary;
  const _OriginalBanner({required this.primary, required this.secondary});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.archive_outlined, color: primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Original page content (preserved below)',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION VARIANTS
// ============================================================================
class _BentoGrid extends StatelessWidget {
  final List<_Pillar> pillars;
  final Color primary, secondary;
  const _BentoGrid({
    required this.pillars,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _cell(pillars[0], 140, primary, secondary),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: _cell(pillars[1], 140, secondary, primary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _cell(pillars[2], 140, secondary, primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _cell(pillars[3], 140, primary, secondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cell(_Pillar p, double h, Color a, Color b) => Container(
    height: h,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [a.withValues(alpha: 0.18), b.withValues(alpha: 0.08)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: a.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(p.icon, color: a, size: 22),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p.name,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              p.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                height: 1.35,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _TimelineBlock extends StatelessWidget {
  final List<_StepCard> steps;
  final Color primary, secondary;
  const _TimelineBlock({
    required this.steps,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        steps.length,
        (i) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: secondary, width: 2),
                    ),
                  ),
                  if (i != steps.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: primary.withValues(alpha: 0.3),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: primary.withValues(alpha: 0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[i].name,
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[i].description,
                        style: const TextStyle(fontSize: 13, height: 1.45),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabsBlock extends StatefulWidget {
  final List<_StepCard> steps;
  final Color primary, secondary;
  const _TabsBlock({
    required this.steps,
    required this.primary,
    required this.secondary,
  });
  @override
  State<_TabsBlock> createState() => _TabsBlockState();
}

class _TabsBlockState extends State<_TabsBlock> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.steps.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final selected = i == idx;
              return GestureDetector(
                onTap: () => setState(() => idx = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? widget.primary
                        : widget.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.steps[i].name,
                    style: TextStyle(
                      color: selected ? Colors.white : widget.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.primary.withValues(alpha: 0.08),
                widget.secondary.withValues(alpha: 0.04),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.primary.withValues(alpha: 0.15)),
          ),
          child: Text(
            widget.steps[idx].description,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _CardsRow extends StatelessWidget {
  final List<_StepCard> steps;
  final Color primary, secondary;
  const _CardsRow({
    required this.steps,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: steps.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => Container(
          width: 220,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primary, secondary],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white24,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[i].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    steps[i].description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccordionBlock extends StatefulWidget {
  final List<_Pillar> pillars;
  final Color primary, secondary;
  const _AccordionBlock({
    required this.pillars,
    required this.primary,
    required this.secondary,
  });
  @override
  State<_AccordionBlock> createState() => _AccordionBlockState();
}

class _AccordionBlockState extends State<_AccordionBlock> {
  int open = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.pillars.length, (i) {
        final p = widget.pillars[i];
        final isOpen = i == open;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: widget.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.primary.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => setState(() => open = isOpen ? -1 : i),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(p.icon, color: widget.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          p.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Icon(
                        isOpen ? Icons.expand_less : Icons.expand_more,
                        color: widget.primary,
                      ),
                    ],
                  ),
                ),
              ),
              if (isOpen)
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      p.description,
                      style: const TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _SplitBlock extends StatelessWidget {
  final List<_Pillar> pillars;
  final Color primary, secondary;
  const _SplitBlock({
    required this.pillars,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(pillars.length, (i) {
        final p = pillars[i];
        final left = i.isEven;
        final card = Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primary.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(p.icon, color: secondary),
                  const SizedBox(width: 8),
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                p.description,
                style: const TextStyle(fontSize: 13, height: 1.45),
              ),
            ],
          ),
        );
        final swatch = Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primary, secondary]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(p.icon, color: Colors.white),
        );
        return Row(
          children: left
              ? [swatch, const SizedBox(width: 12), Expanded(child: card)]
              : [Expanded(child: card), const SizedBox(width: 12), swatch],
        );
      }),
    );
  }
}

class _NumberedBlock extends StatelessWidget {
  final List<_StepCard> steps;
  final Color primary, secondary;
  const _NumberedBlock({
    required this.steps,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        steps.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (i + 1).toString().padLeft(2, '0'),
                style: TextStyle(
                  color: primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[i].description,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgesBlock extends StatelessWidget {
  final List<_Pillar> pillars;
  final Color primary, secondary;
  const _BadgesBlock({
    required this.pillars,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: pillars
          .map(
            (p) => Container(
              width: 170,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primary.withValues(alpha: 0.07),
                border: Border.all(color: primary.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(p.icon, color: secondary, size: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      height: 1.35,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _GalleryBlock extends StatelessWidget {
  final List<_Pillar> pillars;
  final Color primary, secondary;
  const _GalleryBlock({
    required this.pillars,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pillars.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) {
        final p = pillars[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: i.isEven ? [primary, secondary] : [secondary, primary],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(p.icon, color: Colors.white, size: 22),
              const Spacer(),
              Text(
                p.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                p.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsBlock extends StatelessWidget {
  final List<_Stat> stats;
  final Color primary, secondary;
  const _StatsBlock({
    required this.stats,
    required this.primary,
    required this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.35,
      children: stats
          .map(
            (s) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primary.withValues(alpha: 0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.value,
                    style: TextStyle(
                      color: primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.label,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ============================================================================
// HERO BACKGROUNDS — each is a unique visual signature
// ============================================================================
class _HeroBase extends StatelessWidget {
  final CustomPainter painter;
  final Color primary, secondary, accent;
  const _HeroBase({
    required this.painter,
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, secondary],
        ),
      ),
      child: CustomPaint(painter: painter, child: const SizedBox.expand()),
    );
  }
}

class _HeroWave extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroWave({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _WavePainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _WavePainter extends CustomPainter {
  final Color c;
  _WavePainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = c.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (int i = 0; i < 6; i++) {
      final path = Path()..moveTo(0, size.height * (0.3 + i * 0.1));
      for (double x = 0; x <= size.width; x += 6) {
        path.lineTo(
          x,
          size.height * (0.3 + i * 0.1) + math.sin((x + i * 30) / 30) * 12,
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroDiagonal extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroDiagonal({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _DiagPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _DiagPainter extends CustomPainter {
  final Color c;
  _DiagPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = c.withValues(alpha: 0.25);
    for (int i = -10; i < 30; i++) {
      final p = Path()
        ..moveTo(i * 30.0, 0)
        ..lineTo(i * 30.0 + 60, 0)
        ..lineTo(i * 30.0 + 100, size.height)
        ..lineTo(i * 30.0 + 40, size.height)
        ..close();
      canvas.drawPath(p, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroGrid extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroGrid({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _GridPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _GridPainter extends CustomPainter {
  final Color c;
  _GridPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = c.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (double x = 0; x <= size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroCircles extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroCircles({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _CirclesPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _CirclesPainter extends CustomPainter {
  final Color c;
  _CirclesPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = c.withValues(alpha: 0.18);
    for (int i = 0; i < 8; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.15 * i, size.height * 0.4),
        40.0 + i * 8,
        paint,
      );
    }
    final p2 = Paint()..color = c.withValues(alpha: 0.1);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 120, p2);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroPrism extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroPrism({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _PrismPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _PrismPainter extends CustomPainter {
  final Color c;
  _PrismPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = c.withValues(alpha: 0.22);
    for (int i = 0; i < 6; i++) {
      final p = Path()
        ..moveTo(size.width * 0.5, size.height * 0.5)
        ..lineTo(
          size.width * math.cos(i * math.pi / 3) * 0.6 + size.width * 0.5,
          size.height * math.sin(i * math.pi / 3) * 0.6 + size.height * 0.5,
        )
        ..lineTo(
          size.width * math.cos((i + 1) * math.pi / 3) * 0.6 + size.width * 0.5,
          size.height * math.sin((i + 1) * math.pi / 3) * 0.6 +
              size.height * 0.5,
        )
        ..close();
      canvas.drawPath(p, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroBeam extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroBeam({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _BeamPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _BeamPainter extends CustomPainter {
  final Color c;
  _BeamPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 16; i++) {
      final paint = Paint()..color = c.withValues(alpha: 0.06 + (i % 4) * 0.04);
      final p = Path()
        ..moveTo(size.width * 0.5, size.height * 0.5)
        ..lineTo(
          math.cos(i * math.pi / 8) * 1000 + size.width * 0.5,
          math.sin(i * math.pi / 8) * 1000 + size.height * 0.5,
        )
        ..lineTo(
          math.cos((i + 0.3) * math.pi / 8) * 1000 + size.width * 0.5,
          math.sin((i + 0.3) * math.pi / 8) * 1000 + size.height * 0.5,
        )
        ..close();
      canvas.drawPath(p, paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroMesh extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroMesh({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _MeshPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _MeshPainter extends CustomPainter {
  final Color c;
  _MeshPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = c.withValues(alpha: 0.25)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final rand = math.Random(7);
    final pts = List.generate(
      16,
      (_) => Offset(
        rand.nextDouble() * size.width,
        rand.nextDouble() * size.height,
      ),
    );
    for (var a in pts)
      for (var b in pts) {
        if ((a - b).distance < 120) canvas.drawLine(a, b, paint);
      }
    for (var p in pts) {
      canvas.drawCircle(p, 3, Paint()..color = c.withValues(alpha: 0.6));
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroStripes extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroStripes({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _StripesPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _StripesPainter extends CustomPainter {
  final Color c;
  _StripesPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = c.withValues(alpha: 0.18);
    for (double y = 0; y < size.height; y += 16) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 6), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroOrb extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroOrb({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _OrbPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _OrbPainter extends CustomPainter {
  final Color c;
  _OrbPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.7, size.height * 0.55);
    for (int i = 8; i > 0; i--) {
      canvas.drawCircle(
        center,
        30.0 * i,
        Paint()..color = c.withValues(alpha: 0.03 * i),
      );
    }
    canvas.drawCircle(center, 40, Paint()..color = c.withValues(alpha: 0.7));
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroSplit extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroSplit({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(child: Container(color: primary)),
            Expanded(child: Container(color: secondary)),
          ],
        ),
        Center(
          child: Container(width: 4, height: double.infinity, color: accent),
        ),
      ],
    );
  }
}

class _HeroArch extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroArch({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _ArchPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _ArchPainter extends CustomPainter {
  final Color c;
  _ArchPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 5; i++) {
      final paint = Paint()
        ..color = c.withValues(alpha: 0.1 + i * 0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width * 0.5, size.height + 40),
          radius: size.width * 0.4 + i * 20.0,
        ),
        math.pi,
        math.pi,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroSpiral extends StatelessWidget {
  final Color primary, secondary, accent;
  const _HeroSpiral({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) => _HeroBase(
    painter: _SpiralPainter(accent),
    primary: primary,
    secondary: secondary,
    accent: accent,
  );
}

class _SpiralPainter extends CustomPainter {
  final Color c;
  _SpiralPainter(this.c);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = c.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    for (double t = 0; t < 8 * math.pi; t += 0.1) {
      final r = t * 5;
      final x = size.width * 0.5 + r * math.cos(t);
      final y = size.height * 0.5 + r * math.sin(t);
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
