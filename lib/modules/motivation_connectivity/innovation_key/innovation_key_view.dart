import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'innovation_key_controller.dart';

class InnovationKeyView extends GetView<InnovationKeyController> {
  final bool isEmbedded;
  const InnovationKeyView({super.key, this.isEmbedded = false});

  static const _yellow = Color(0xFFEAB308);
  static const _amber = Color(0xFFF59E0B);
  static const _lime = Color(0xFF84CC16);
  static const _orange = Color(0xFFEA580C);
  static const _violet = Color(0xFF7C3AED);
  static const _pink = Color(0xFFEC4899);
  static const _cyan = Color(0xFF06B6D4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF080600) : const Color(0xFFFFFBEB);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      shrinkWrap: isEmbedded,
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      children: [
        _buildHeroHeader(context, isDark, onSurface),
        const SizedBox(height: 20),
        _buildSectionLabel(
          'INNOVATION PIPELINE',
          Icons.linear_scale_rounded,
          _amber,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildPipelineStages(context, isDark, onSurface),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'IDEATION SPARKS',
          Icons.lightbulb_rounded,
          _yellow,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildIdeationGrid(context, isDark, onSurface),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'CAPABILITIES',
          Icons.settings_rounded,
          _lime,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildCapCard(
          context,
          isDark,
          Icons.lightbulb_rounded,
          _yellow,
          'Idea Generation Studio',
          'Use structured brainstorming prompts, constraint-based thinking, and analogical reasoning to generate novel solutions. '
              'Ideas are captured in a shared studio so the best ones can be developed collaboratively rather than in isolation. '
              'The studio runs timed ideation sprints — 20 minutes of divergent thinking followed by structured convergence — proven to produce more usable ideas than free-form brainstorming.',
        ),
        const SizedBox(height: 10),
        _buildCapCard(
          context,
          isDark,
          Icons.verified_user_rounded,
          _orange,
          'Integrity Stress Test',
          'Before advancing any innovation, stress-test it against AIR\'s core values and non-negotiable commitments. '
              'An idea that only works by cutting ethical corners is not innovation — it is a liability dressed up as progress. '
              'The stress test generates a written integrity assessment you can share with stakeholders as evidence that the innovation has been vetted against principle, not just performance.',
        ),
        const SizedBox(height: 10),
        _buildCapCard(
          context,
          isDark,
          Icons.science_rounded,
          _cyan,
          'Rapid Prototype Lab',
          'Build lightweight prototypes of promising ideas in 48 hours or less using AIR\'s modular component library. '
              'Fast prototyping surfaces real-world friction early, when changes are cheap and learning is fast. '
              'Every prototype run is logged with hypotheses, observations, and conclusions — building a knowledge base that prevents teams from re-running experiments already completed by others.',
        ),
        const SizedBox(height: 10),
        _buildCapCard(
          context,
          isDark,
          Icons.analytics_rounded,
          _violet,
          'Innovation Metrics',
          'Track the health of your innovation pipeline — ideas generated, experiments run, pilots launched, and innovations scaled. '
              'Metrics reveal whether the culture is genuinely innovative or just talking about innovation. '
              'Conversion ratios at each pipeline stage highlight where ideas are dying and why, enabling targeted interventions to unblock the specific constraint limiting your innovation throughput.',
        ),
        const SizedBox(height: 10),
        _buildCapCard(
          context,
          isDark,
          Icons.shuffle_rounded,
          _pink,
          'Cross-Domain Pollination',
          'Deliberately import ideas from fields outside your domain and test whether they solve problems in new ways. '
              'The most disruptive innovations in history came from applying a known solution to an unexpected context. '
              'AIR curates a weekly "out-of-domain" brief drawn from science, art, sport, and philosophy that surfaces analogies applicable to the challenges your team is currently working on.',
        ),
        const SizedBox(height: 10),
        _buildCapCard(
          context,
          isDark,
          Icons.emoji_events_rounded,
          _amber,
          'Innovation Recognition',
          'Celebrate and attribute every innovation that ships — from the original idea through to the team that scaled it. '
              'Recognition reinforces the behaviours that produce innovation and signals to the whole community that novelty is valued. '
              'Innovation attributions are publicly visible in the AIR Showcase, giving inventors lasting credit in the community record regardless of organisational changes.',
        ),
        const SizedBox(height: 20),
        _buildInnovationQuote(context, isDark, onSurface),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D2A00), const Color(0xFF1A0E00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _amber.withValues(alpha: 0.40)),
        boxShadow: [
          BoxShadow(color: _amber.withValues(alpha: 0.12), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.key_rounded, color: _yellow, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'INNOVATION ENGINE',
                      style: TextStyle(
                        fontSize: 10,
                        color: _yellow,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Real innovation is disciplined creativity — it solves genuine problems in ways that hold up under scrutiny, not just under applause.',
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
              _stat('34', 'Ideas', _yellow),
              const SizedBox(width: 16),
              _stat('8', 'Prototyping', _lime),
              const SizedBox(width: 16),
              _stat('3', 'In Pilot', _cyan),
              const SizedBox(width: 16),
              _stat('2', 'Scaled', _orange),
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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c),
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

  Widget _buildPipelineStages(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final stages = [
      ('Concept', '12', _yellow),
      ('Feasibility', '8', _amber),
      ('Prototype', '8', _lime),
      ('Pilot', '3', _cyan),
      ('Scale', '2', _orange),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stages.asMap().entries.map((e) {
          final s = e.value;
          return Row(
            children: [
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: s.$3.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: s.$3.withValues(alpha: 0.25)),
                ),
                child: Column(
                  children: [
                    Text(
                      s.$2,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: s.$3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s.$1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        color: s.$3.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              if (e.key < stages.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: _amber.withValues(alpha: 0.50),
                    size: 20,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIdeationGrid(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final sparks = [
      ('What if we reversed it?', Icons.swap_vert_rounded, _yellow),
      ('Who else solved this?', Icons.search_rounded, _lime),
      ('What constraint can we remove?', Icons.remove_circle_rounded, _orange),
      ('What would a child do?', Icons.child_care_rounded, _pink),
      ('What is the 10x version?', Icons.zoom_out_map_rounded, _cyan),
      ('What is the 1/10th version?', Icons.compress_rounded, _violet),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.0,
      children: sparks
          .map(
            (s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: s.$3.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: s.$3.withValues(alpha: 0.20)),
              ),
              child: Row(
                children: [
                  Icon(s.$2, color: s.$3, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s.$1,
                      style: TextStyle(
                        fontSize: 10,
                        color: onSurface,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
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

  Widget _buildCapCard(
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

  Widget _buildInnovationQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _amber.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _amber.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _yellow, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"Innovation is not about having a new idea. It is about stopping having an old idea." — Edwin Land',
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
