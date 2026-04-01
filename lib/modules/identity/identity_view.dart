import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'identity_controller.dart';

class IdentityView extends GetView<IdentityController> {
  IdentityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary));
      }

      if (controller.questionnaires.isEmpty) {
        return Center(child: Text("No questionnaires available.", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)));
      }

      if (controller.isCompleted.value) {
        return _buildResultView(context);
      }

      return _buildQuestionView(context);
    });
  }

  Widget _buildQuestionView(BuildContext context) {
    final question = controller.questionnaires[controller.currentQuestionIndex.value];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(animation),
          child: child,
        ));
      },
      child: Container(
        key: ValueKey<String>(question.id),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.5)),
              ),
              child: Text(
                "PHASE ${controller.currentQuestionIndex.value + 1} // ${controller.questionnaires.length}",
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.tertiary, letterSpacing: 2, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              question.question,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ...question.options.map((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () => controller.answerQuestion(question.id, option),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.radio_button_unchecked, color: Theme.of(context).colorScheme.tertiary),
                          const SizedBox(width: 16),
                          Expanded(child: Text(option, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color))),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
                border: Border.all(color: Theme.of(context).colorScheme.tertiary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: 10,
                  )
                ]
              ),
              child: Icon(Icons.remove_red_eye, size: 80, color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(height: 40),
            Text(
              "IDENTITY MAPPED",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color, letterSpacing: 3),
            ),
            const SizedBox(height: 16),
            Text(
              "Your answers point to a highly organized systemic node. The AIR Organization has logged your coordinates effectively.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color, height: 1.5),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: controller.reset,
              style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.transparent,
                 shadowColor: Colors.transparent,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                   side: BorderSide(color: Theme.of(context).colorScheme.tertiary)
                 ),
                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)
              ),
              child: Text("RECALIBRATE", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, letterSpacing: 2)),
            )
          ],
        ),
      ),
    );
  }
}
