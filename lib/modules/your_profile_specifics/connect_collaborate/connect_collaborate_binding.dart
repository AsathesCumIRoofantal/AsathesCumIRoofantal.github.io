import 'package:get/get.dart';
import 'connect_collaborate_controller.dart';

class ConnectCollaborateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectCollaborateController>(() => ConnectCollaborateController());
  }
}
