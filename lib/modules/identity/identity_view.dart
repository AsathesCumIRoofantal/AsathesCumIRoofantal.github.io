import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'identity_controller.dart';
import '../../core/utils/content_reviser.dart';
import '../../data/auth_service.dart';

class IdentityView extends GetView<IdentityController> {
  IdentityView({Key? key}) : super(key: key);

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
            child: Text(
              "No questionnaires available.",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildCollapsibleHeader(context),
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
                  ? [accent.withOpacity(0.15), accent.withOpacity(0.05)]
                  : [accent.withOpacity(0.08), accent.withOpacity(0.03)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent.withOpacity(isExpanded ? 0.5 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              if (isExpanded)
                BoxShadow(
                  color: accent.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
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
                                ?.withOpacity(0.6),
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
        ),
      );
    });
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
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accent.withOpacity(0.5)),
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
            const SizedBox(height: 32),
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
                      border: Border.all(color: accent.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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
                color: accent.withOpacity(0.1),
                border: Border.all(color: accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.2),
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
            Obx(() => Text(
              ContentReviser.revise("Your answers point to a highly organized systemic node. The AIR Organization has logged your coordinates effectively."),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                height: 1.5,
              ),
            )),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
