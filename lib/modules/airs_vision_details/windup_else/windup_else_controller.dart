import 'package:get/get.dart';

class WindupItem {
  final String title;
  final String value;

  WindupItem({required this.title, required this.value});
}

class WindupElseController extends GetxController {
  final stats = <WindupItem>[
    WindupItem(title: "Session Duration", value: "45 mins"),
    WindupItem(title: "Data Consumed", value: "124 MB"),
    WindupItem(title: "Credits Earned", value: "250"),
  ].obs;

  void windup() {
    Get.snackbar("Winding Up", "Saving session data and preparing for safe exit...");
  }
}
