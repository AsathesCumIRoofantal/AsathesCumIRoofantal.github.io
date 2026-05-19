// web_modules/web_service/web_service_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebServiceController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxInt activeItemIndex = 0.obs;
  final RxString searchQuery = ''.obs;

  void setActive(int i) => activeItemIndex.value = i;
  void setQuery(String q) => searchQuery.value = q.toLowerCase();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
