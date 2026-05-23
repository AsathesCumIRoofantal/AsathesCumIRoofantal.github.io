import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebHigherStudiesController extends GetxController {
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  // Mock data for academic paths
  final List<Map<String, dynamic>> studyPaths = [
    {
      'title': 'Master of Science (MSc)',
      'duration': '2 Years',
      'focus': 'Research & Tech',
      'icon': Icons.school,
    },
    {
      'title': 'MBA / Management',
      'duration': '2 Years',
      'focus': 'Leadership',
      'icon': Icons.business_center,
    },
    {
      'title': 'Professional Certification',
      'duration': '6 Months',
      'focus': 'Skill Acquisition',
      'icon': Icons.verified,
    },
    {
      'title': 'Post-Grad Diploma',
      'duration': '1 Year',
      'focus': 'Specialization',
      'icon': Icons.architecture,
    },
  ].obs;

  void updateSearch(String val) {
    searchQuery.value = val;
  }
}
