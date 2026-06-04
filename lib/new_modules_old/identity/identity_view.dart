import 'package:air_app/widgets_specific/air_home_context_strip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/content_reviser.dart';
import 'identity_controller.dart';

class IdentityView extends GetView<IdentityController> {
  final bool isEmbedded;
  const IdentityView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Obx(
        () => controller.isLoading.value || controller.questionnaires.isEmpty
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: controller.reset,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                icon: Icon(Icons.refresh_rounded, color: Colors.white54),
                label: Text(
                  controller.isCompleted.value ? "RE-MAP" : "RECALIBRATE",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          );
        }

        if (controller.questionnaires.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No questionnaires available.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'When questionnaires arrive, this tab becomes your guided map of cognitive and existential coordinates. Until then, catalogue ENTITIES and UNIONS on the home screen, and skim drawer topics so the organisation can still learn your posture.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AirHomeContextStrip(
                    compact: true,
                    placement: AirHomeContextPlacement.homeTab,
                    extraLine:
                        'IDENTITY is the third home tab—once questionnaires load, answers here should align with ENTITIES and UNIONS and with drawer programmes you open from the menu (☰).',
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: AirHomeContextStrip(
                  compact: true,
                  placement: AirHomeContextPlacement.homeTab,
                  extraLine:
                      'IDENTITY tab: answers layer on top of ENTITIES and UNIONS—keep all three tabs truthful together.',
                ),
              ),
              _buildCollapsibleHeader(context),
              _buildIdentityInfoCard(context),
              controller.isCompleted.value
                  ? _buildResultView(context)
                  : _buildQuestionView(context),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCollapsibleHeader(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.tertiary;

    return Obx(() {
      final isExpanded = controller.isIdentityExpanded.value;
      return GestureDetector(
        onTap: () => controller.isIdentityExpanded.toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isExpanded
                  ? [
                      accent.withValues(alpha: 0.15),
                      accent.withValues(alpha: 0.05),
                    ]
                  : [
                      accent.withValues(alpha: 0.08),
                      accent.withValues(alpha: 0.03),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent.withValues(alpha: isExpanded ? 0.5 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              if (isExpanded)
                BoxShadow(
                  color: accent.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_rounded,
                      color: accent,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Identity is the 'Mapping of Coordinates in all-space'",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: theme.textTheme.bodyLarge?.color,
                            height: 1.3,
                          ),
                        ),
                        if (!isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "Identify your relationship to AIR",
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withValues(alpha: 0.6),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: accent,
                      size: 28,
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 14),
                Divider(height: 1, color: accent.withValues(alpha: 0.25)),
                const SizedBox(height: 12),
                Text(
                  'Expanded view — how this tab meets the drawer',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: accent.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Answers you give here do not replace entity or union records; they explain the observer behind those records. Drawer lanes such as BE-YOU & EARN LIVING, Motivation, and Profile Specifics assume this coordinate layer stays honest.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.82,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'If you change your mind later, use Recalibrate / Re-map—the FAB keeps your philosophical trail current without erasing earlier honesty.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.72,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildIdentityInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.tertiary;
    final bodyColor = theme.textTheme.bodyMedium?.color;

    Widget bullet(String text) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• ',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: bodyColor?.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 20, color: accent),
                const SizedBox(width: 8),
                Text(
                  'GET-AS-IDENTIFIED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: accent.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'This tab locates you within the all-space map. Through a guided philosophical questionnaire, your cognitive and existential coordinates are determined.',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: bodyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'HOW IT WORKS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: accent.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 8),
            bullet('You answer a sequence of reflective questions (phases).'),
            bullet(
              'Each answer steers the system toward your unique identity node.',
            ),
            bullet(
              'When complete, your identity is mapped and logged by the AIR Organisation.',
            ),
            bullet(
              'Use Recalibrate or Re-map anytime as your perspective evolves.',
            ),
            const SizedBox(height: 10),
            Text(
              'Your identity node anchors learning pathways and connects you to relevant entities and unions.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: bodyColor?.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Drawer tip: after mapping here, use the menu (☰) for BE-YOU & EARN LIVING, motivation, and profile specifics so your inner coordinates meet outward programmes in one flow.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: bodyColor?.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionView(BuildContext context) {
    if (controller.questionnaires.isEmpty) return const SizedBox.shrink();

    final question =
        controller.questionnaires[controller.currentQuestionIndex.value];
    final accent = Theme.of(context).colorScheme.tertiary;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<String>(question.id),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accent.withValues(alpha: 0.5)),
              ),
              child: Text(
                "PHASE ${controller.currentQuestionIndex.value + 1} // ${controller.questionnaires.length}",
                style: TextStyle(
                  fontSize: 12,
                  color: accent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            AirHomeContextStrip(
              compact: true,
              placement: AirHomeContextPlacement.homeTab,
              extraLine:
                  'Each choice advances this home tab only; swipe ENTITIES or UNIONS to check your catalogue, then use the menu (☰) for drawer programmes that consume a completed map.',
            ),
            const SizedBox(height: 24),
            Text(
              question.question,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ...question.options.map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () => controller.answerQuestion(question.id, option),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accent.withValues(alpha: 0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_unchecked, color: accent),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(BuildContext context) {
    final accent = Theme.of(context).colorScheme.tertiary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.1),
                border: Border.all(color: accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(Icons.hub_rounded, size: 80, color: accent),
            ),
            const SizedBox(height: 40),
            Text(
              "IDENTITY MAPPED",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                ContentReviser.revise(
                  "Your answers point to a highly organized systemic node. The AIR Organization has logged your coordinates effectively.",
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            AirHomeContextStrip(
              compact: true,
              placement: AirHomeContextPlacement.homeTab,
              extraLine:
                  'Next: open Identities Cum Earnings or Profile Specifics from the menu (☰) when you attach outward work and credits to this mapped node.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
