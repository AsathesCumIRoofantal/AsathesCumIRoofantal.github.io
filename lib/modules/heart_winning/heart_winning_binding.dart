import 'package:get/get.dart';
import 'heart_winning_controller.dart';

class HeartWinningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeartWinningController>(() => HeartWinningController());
  }
}
