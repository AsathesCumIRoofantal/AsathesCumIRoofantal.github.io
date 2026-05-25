// web_modules/web_home/web_home_controller.dart
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as webHndle;

class WebHomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxInt activeItemIndex = 0.obs;
  final RxString searchQuery = ''.obs;

  void setActive(int i) => activeItemIndex.value = i;
  void setQuery(String q) => searchQuery.value = q.toLowerCase();

  @override
  void onInit() {
    super.onInit();
    _listenForUpdates();
  }

  void _listenForUpdates() {
    webHndle.window.addEventListener(
      'flutter_version_update',
      ((webHndle.Event event) {
            _showUpdateNotification();
          }).toJS
          as webHndle.EventListener,
    );
  }

  void _showUpdateNotification() {
    // GetX snackbar runs independently of context, bypassing layout size errors completely
    Get.snackbar(
      'Update Available',
      'A new version of the app has been deployed.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(days: 1), // Keeps it open
      isDismissible: false,
      mainButton: TextButton(
        onPressed: () {
          webHndle.window.location.reload(); // Hard reload browser
        },
        child: const Text(
          'Refresh',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
