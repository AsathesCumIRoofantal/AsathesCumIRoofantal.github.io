import 'package:get/get.dart';

class WebTimelineOfAirController extends GetxController {
  final activeYear = '2026'.obs;

  void setYear(String year) => activeYear.value = year;
}
