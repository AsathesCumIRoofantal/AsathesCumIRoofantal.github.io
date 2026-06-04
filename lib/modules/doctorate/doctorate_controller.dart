import 'package:get/get.dart';
class DoctorateController extends GetxController {
  final expandedIndex = RxnInt();
  void toggleSection(int index) => expandedIndex.value = expandedIndex.value == index ? null : index;
}
