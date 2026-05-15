import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/air_home_context_strip.dart';
import 'learn_fun_controller.dart';

class LearnFunView extends GetView<LearnFunController> {
  const LearnFunView({Key? key}) : super(key: key);

  IconData _getIcon(String identifier) {
    switch (identifier) {
      case 'science': return Icons.science;
      case 'color_lens': return Icons.color_lens;
      case 'remove_red_eye': return Icons.remove_red_eye;
      case 'calculate': return Icons.calculate;
      default: return Icons.book;
    }
  }

  Color _getColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alifiyas's - Learn & Fun"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: AirHomeContextStrip(
                compact: true,
                extraLine:
                    'Tiles here pair with Learn Docs (by category) in the same EXPLORE drawer block when you want reading next to play.',
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.menus.length,
                itemBuilder: (context, index) {
                  final menu = controller.menus[index];
                  final Color menuColor = _getColor(menu.colorHex);

                  return InkWell(
                    onTap: () => controller.openCategory(menu.id, menu.title),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: menuColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: menuColor.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: menuColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getIcon(menu.iconIdentifier),
                                size: 40,
                                color: menuColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              menu.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
