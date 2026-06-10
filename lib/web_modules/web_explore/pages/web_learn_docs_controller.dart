import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLearnDocsController extends GetxController {
  final selectedCategory = 0.obs;
  final searchQuery = ''.obs;
  final categories = <String>[
    'All',
    'Science',
    'Arts',
    'Tech',
    'Health',
    'History',
    'Philosophy',
  ];
}
