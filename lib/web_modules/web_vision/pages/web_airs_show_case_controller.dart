import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WebAirsShowCaseController extends GetxController {
  final pageController = PageController(viewportFraction: 0.8);
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (currentIndex.value != page) {
        currentIndex.value = page;
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void previousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
