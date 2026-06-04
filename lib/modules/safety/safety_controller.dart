import 'package:get/get.dart';

class SafetyController extends GetxController {
  // Expandable state per section index
  final expandedIndex = RxnInt();

  void toggleSection(int index) {
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }
}
