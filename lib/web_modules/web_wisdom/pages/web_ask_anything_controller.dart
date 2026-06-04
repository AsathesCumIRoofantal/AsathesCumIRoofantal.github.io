import 'package:get/get.dart';
class WebAskAnythingController extends GetxController {
  final searchText = ''.obs;
  final activeCategory = 'All'.obs;
  final categories = ['All', 'Life', 'Work', 'Wisdom', 'Tech', 'Health'];
}
