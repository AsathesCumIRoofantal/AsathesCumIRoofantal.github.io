// web_modules/web_home/web_home_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class WebHomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxInt activeItemIndex = 0.obs;
  final RxString searchQuery = ''.obs;

  void setActive(int i) => activeItemIndex.value = i;
  void setQuery(String q) => searchQuery.value = q.toLowerCase();

  @override
  void onInit() {
    super.onInit();

    // 🚀 DISMISS HERE: Removes the splash screen the moment this controller initializes
    FlutterNativeSplash.remove();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
