import 'package:get/get.dart';

class WebGetConnectedController extends GetxController {
  final activeFilter = 'All Groups'.obs;

  void setFilter(String filter) => activeFilter.value = filter;
}
