import 'package:get/get.dart';
class ReligionPrayerController extends GetxController {
  final expandedIndex = RxnInt();
  void toggleSection(int index) => expandedIndex.value = expandedIndex.value == index ? null : index;
}
