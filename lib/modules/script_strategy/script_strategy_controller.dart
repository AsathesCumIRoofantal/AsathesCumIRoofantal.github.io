import 'package:get/get.dart';

class ScriptStrategyController extends GetxController {
  // Example observable list of strategy items
  final strategies = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: Load initial data or fetch from repository
    strategies.assignAll([
      'Video Script Templates',
      'Content Planning Framework',
      'Strategic Execution Checklist',
    ]);
  }

  void addStrategy(String strategy) {
    strategies.add(strategy);
  }
}
