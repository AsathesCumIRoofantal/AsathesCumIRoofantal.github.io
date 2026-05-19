import 'package:get/get.dart';

class WebTracksAndTracesController extends GetxController {
  final activeTab = 'All Logs'.obs;

  void setTab(String tab) => activeTab.value = tab;
}
