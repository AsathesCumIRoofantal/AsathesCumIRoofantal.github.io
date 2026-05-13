import 'package:get/get.dart';
import 'situation_reaction_controller.dart';

class SituationReactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SituationReactionController>(() => SituationReactionController());
  }
}
