import 'package:get/get.dart';

class WebAppSettingController extends GetxController {
  final pushNotifications = true.obs;
  final emailUpdates = false.obs;
  final autoSync = true.obs;
  final dataSaver = false.obs;
  final advancedMode = false.obs;

  void togglePushNotifications() => pushNotifications.toggle();
  void toggleEmailUpdates() => emailUpdates.toggle();
  void toggleAutoSync() => autoSync.toggle();
  void toggleDataSaver() => dataSaver.toggle();
  void toggleAdvancedMode() => advancedMode.toggle();
}
