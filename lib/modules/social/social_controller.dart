import 'package:get/get.dart';

class SocialController extends GetxController {
  final expandedIndex = RxnInt();

  void toggleSection(int index) {
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }
}
