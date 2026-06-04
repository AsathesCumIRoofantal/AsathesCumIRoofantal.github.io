import 'package:get/get.dart';
import 'heigher_studies_controller.dart';
class HeigherStudiesBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => HeigherStudiesController());
}
