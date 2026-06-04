import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAskAnythingBController extends GetxController {
  final searchQuery = ''.obs;
  final isSearching = false.obs;
  final hasResults = false.obs;

  // Mock suggested questions for the user
  final RxList<dynamic> suggestions = [
    {'q': 'How to start a PhD in AI?', 'cat': 'Academic', 'icon': Icons.school},
    {
      'q': 'Best life hacks for productivity?',
      'cat': 'Lifestyle',
      'icon': Icons.bolt,
    },
    {
      'q': 'What is the AIR Space vision?',
      'cat': 'Organization',
      'icon': Icons.visibility,
    },
    {
      'q': 'Latest trends in Quantum Computing?',
      'cat': 'Science',
      'icon': Icons.science,
    },
    {
      'q': 'How to collaborate on AIR?',
      'cat': 'Networking',
      'icon': Icons.people,
    },
    {'q': 'Digitalize hub guide?', 'cat': 'Setup', 'icon': Icons.settings},
  ].obs;

  void performSearch(String query) {
    if (query.isEmpty) return;
    isSearching.value = true;

    // Simulate AI Search latency
    Future.delayed(const Duration(milliseconds: 800), () {
      isSearching.value = false;
      hasResults.value = true;
    });
  }
}
