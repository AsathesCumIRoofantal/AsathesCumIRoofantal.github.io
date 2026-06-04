import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'resume_tour_controller.dart';

class ResumeTourView extends GetView<ResumeTourController> {
  final bool isEmbedded;
  const ResumeTourView({super.key, required this.isEmbedded});

  static const _mint = Color(0xFF10B981);
  static const _green = Color(0xFF059669);
  static const _lime = Color(0xFF84CC16);
  static const _sky = Color(0xFF0EA5E9);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020A06) : const Color(0xFFF0FDF4);

    return
    // Scaffold(
    //   backgroundColor: bg,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     foregroundColor: onSurface,
    //     title: const Text(
    //       'RESUME TOUR',
    //       style: TextStyle(
    //         letterSpacing: 2,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 14,
    //       ),
    //     ),
    //     centerTitle: true,
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(right: 16),
    //         child: Icon(Icons.play_circle_rounded, color: _mint, size: 22),
    //       ),
    //     ],
    //   ),
    //   body:
    ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      shrinkWrap: isEmbedded,
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      children: [
        _buildProgressHeader(context, isDark, onSurface),
        const SizedBox(height: 20),
        _buildSectionLabel(
          'YOUR JOURNEY STEPS',
          Icons.route_rounded,
          _mint,
          onSurface,
        ),
        const SizedBox(height: 14),
        ..._tourSteps.asMap().entries.map(
          (e) => _buildJourneyStep(context, isDark, onSurface, e.key, e.value),
        ),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'TOUR DETAILS',
          Icons.info_outline_rounded,
          _sky,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildDetailCard(
          context,
          isDark,
          Icons.flag_rounded,
          _mint,
          'Progress Checkpoint',
          'See a clear summary of which tour stages you have completed, which are in progress, and which are still ahead. '
              'The checkpoint prevents the disorientation of returning after a break — you always know exactly where you are in the journey. '
              'Checkpoints are saved automatically so you can switch devices and pick up seamlessly mid-tour.',
        ),
        const SizedBox(height: 10),
        _buildDetailCard(
          context,
          isDark,
          Icons.explore_rounded,
          _sky,
          'Module Deep-Dives',
          'Step through interactive walkthroughs of each AIR module — not just what it does, but how to use it effectively in real situations. '
              'Deep-dives are designed to be completed in 5–10 minutes each, making it easy to fit orientation into a busy schedule. '
              'Each deep-dive ends with a practical exercise so the knowledge is anchored through doing, not just watching.',
        ),
        const SizedBox(height: 10),
        _buildDetailCard(
          context,
          isDark,
          Icons.search_rounded,
          _lime,
          'Guided Feature Discovery',
          'Unlock hidden and advanced features through a structured discovery sequence that reveals capabilities in the order they become most useful. '
              'Discovery is paced to match your growing familiarity — you will not be shown features you are not yet ready to use. '
              'Feature unlocks are celebrated with a micro-achievement so the discovery process itself feels rewarding.',
        ),
        const SizedBox(height: 10),
        _buildDetailCard(
          context,
          isDark,
          Icons.quiz_rounded,
          _amber,
          'Orientation Quiz',
          'Test your understanding of key AIR concepts with a short quiz at the end of each tour section to reinforce what you have learned. '
              'Quizzes are low-stakes and immediately reviewed — they are learning tools, not assessments. '
              'Wrong answers reveal the correct reasoning immediately, turning errors into the deepest form of learning.',
        ),
        const SizedBox(height: 10),
        _buildDetailCard(
          context,
          isDark,
          Icons.route_rounded,
          _violet,
          'Personalised Tour Path',
          'Adjust the tour sequence based on your role, interests, and the modules most relevant to your immediate goals. '
              'A personalised path means you spend time on what matters most to you, not on a generic sequence designed for everyone. '
              'Your chosen path is saved and can be updated at any time as your priorities within AIR evolve.',
        ),
        const SizedBox(height: 10),
        _buildDetailCard(
          context,
          isDark,
          Icons.workspace_premium_rounded,
          _amber,
          'Tour Completion Certificate',
          'Earn a completion certificate when you finish the full orientation tour — a shareable credential that signals your readiness to contribute fully. '
              'The certificate is recorded in your AIR profile and visible to collaborators who want to know your level of platform fluency. '
              'Completing the tour also unlocks the first tier of the AIR Rewards system, crediting your account with orientation bonus points.',
        ),
        const SizedBox(height: 20),
        _buildCompletionBanner(context, isDark, onSurface),
      ],
    );
  }

  Widget _buildProgressHeader(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _green.withValues(alpha: 0.15),
            _sky.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _mint.withValues(alpha: 0.30)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.play_circle_rounded,
                  color: _mint,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ORIENTATION TOUR',
                      style: TextStyle(
                        fontSize: 10,
                        color: _mint,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pick up exactly where you left off. Complete every stage for full platform fluency.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: onSurface.withValues(alpha: 0.72),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 of 6 stages complete',
                style: TextStyle(
                  fontSize: 11,
                  color: onSurface.withValues(alpha: 0.60),
                ),
              ),
              const Text(
                '50%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _mint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [_green, _mint]),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: _mint.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
  ) {
    return Row(
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
  }

  Widget _buildJourneyStep(
    BuildContext context,
    bool isDark,
    Color onSurface,
    int index,
    _TourStep step,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.done
                        ? _mint.withValues(alpha: 0.20)
                        : step.active
                        ? _amber.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: step.done
                          ? _mint
                          : step.active
                          ? _amber
                          : Colors.white24,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    step.done
                        ? Icons.check_rounded
                        : step.active
                        ? Icons.play_arrow_rounded
                        : Icons.lock_outline_rounded,
                    color: step.done
                        ? _mint
                        : step.active
                        ? _amber
                        : Colors.white38,
                    size: 14,
                  ),
                ),
                if (index < _tourSteps.length - 1)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: step.done
                          ? _mint.withValues(alpha: 0.40)
                          : Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: step.done
                    ? _mint.withValues(alpha: 0.07)
                    : step.active
                    ? _amber.withValues(alpha: 0.06)
                    : Colors.white.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: step.done
                      ? _mint.withValues(alpha: 0.22)
                      : step.active
                      ? _amber.withValues(alpha: 0.20)
                      : Colors.white.withValues(alpha: 0.05),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (step.done
                                      ? _mint
                                      : step.active
                                      ? _amber
                                      : Colors.white24)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          step.done
                              ? 'DONE'
                              : step.active
                              ? 'IN PROGRESS'
                              : 'LOCKED',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: step.done
                                ? _mint
                                : step.active
                                ? _amber
                                : Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.description,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.duration,
                    style: TextStyle(
                      fontSize: 10,
                      color: step.done
                          ? _mint
                          : step.active
                          ? _amber
                          : Colors.white38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
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
              color: color.withValues(alpha: 0.15),
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

  Widget _buildCompletionBanner(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _violet.withValues(alpha: 0.12),
            _mint.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _violet.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium_rounded, color: _amber, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'COMPLETION REWARD',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: _amber,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Finish all 6 stages and earn your AIR Orientation Certificate plus 200 AIR-V credits added to your balance.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TourStep {
  final String title, description, duration;
  final bool done, active;
  const _TourStep(
    this.title,
    this.description,
    this.duration, {
    this.done = false,
    this.active = false,
  });
}

final _tourSteps = [
  _TourStep(
    'Platform Overview',
    'Understand the 10 drawer sections, their purpose, and how they connect to form the full AIR ecosystem.',
    '8 min',
    done: true,
  ),
  _TourStep(
    'Identity & Profile Setup',
    'Complete your philosophical identity questionnaire and configure your profile visibility settings.',
    '12 min',
    done: true,
  ),
  _TourStep(
    'Knowledge & Learning Modules',
    'Walk through the Learn & Fun grid, Knowledge Centre query system, and Higher Studies lane.',
    '10 min',
    done: true,
  ),
  _TourStep(
    'Be-You & Earn Living',
    'Log your first identity-linked earning entry and explore the Identities Cum Earnings dashboard.',
    '8 min',
    active: true,
  ),
  _TourStep(
    'Rewards Economy',
    'Understand the AIR-V credit system, tier progression, and redemption catalogue.',
    '6 min',
  ),
  _TourStep(
    'Contribution & Governance',
    'Discover how to contribute to AIR, participate in decisions, and claim your orientation certificate.',
    '10 min',
  ),
];
