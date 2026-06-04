import 'package:get/get.dart';

class WebKnowledgeCenterController extends GetxController {
  final activeCategory = 'All Assets'.obs;
  
  void setCategory(String category) {
    activeCategory.value = category;
  }
}
