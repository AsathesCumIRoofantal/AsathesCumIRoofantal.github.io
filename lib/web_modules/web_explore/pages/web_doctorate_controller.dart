import 'package:get/get.dart';

class WebDoctorateController extends GetxController {
  final activePhase = 'Research'.obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;

  final phases = [
    'Research',
    'Coursework',
    'Thesis',
    'Publication',
    'Defense',
    'Post-Doc',
  ];

  void setPhase(String p) => activePhase.value = p;
  void setQuery(String q) => searchQuery.value = q.toLowerCase();
}
