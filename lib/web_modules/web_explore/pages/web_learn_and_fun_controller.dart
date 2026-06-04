import 'package:get/get.dart';

class WebLearnAndFunController extends GetxController {
  // We can add state for the staggered animations or search
  final searchQuery = ''.obs;

  void setSearch(String val) => searchQuery.value = val;
}
