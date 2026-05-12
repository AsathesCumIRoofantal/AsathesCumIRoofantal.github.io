import 'package:get/get.dart';
class ChallengeController extends GetxController {
  final expandedIndex = RxnInt();
  void toggleSection(int index) => expandedIndex.value = expandedIndex.value == index ? null : index;
}
