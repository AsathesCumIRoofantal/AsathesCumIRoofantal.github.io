import 'package:get/get.dart';
class AdvantageController extends GetxController {
  final expandedIndex = RxnInt();
  void toggleSection(int index) => expandedIndex.value = expandedIndex.value == index ? null : index;
}
