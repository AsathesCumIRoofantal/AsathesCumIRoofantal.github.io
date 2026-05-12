import 'package:get/get.dart';
import 'solution_controller.dart';
class SolutionBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => SolutionController());
}
