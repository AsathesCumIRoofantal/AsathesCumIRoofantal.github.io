import 'package:get/get.dart';

class WebHigherStudiesController extends GetxController {
  final selectedLevel = 'Undergraduate'.obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;

  final levels = [
    'Undergraduate',
    'Postgraduate',
    'Doctoral',
    'Post-Doctoral',
    'Certification',
  ];

  void setLevel(String level) => selectedLevel.value = level;
  void setQuery(String q) => searchQuery.value = q.toLowerCase();
}
