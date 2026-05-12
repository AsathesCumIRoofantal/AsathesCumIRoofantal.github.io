import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notice {
  final String title;
  final String content;
  final String category;
  final DateTime date;

  Notice({required this.title, required this.content, required this.category, required this.date});
}

class NoticesController extends GetxController {
  final notices = <Notice>[
    Notice(
      title: "Holiday Announcement",
      content: "The office will be closed on Friday for the annual AIR festival.",
      category: "General",
      date: DateTime.now(),
    ),
  ].obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void createNotice() {
    if (titleController.text.isNotEmpty) {
      notices.insert(0, Notice(
        title: titleController.text,
        content: contentController.text,
        category: "Important",
        date: DateTime.now(),
      ));
      titleController.clear();
      contentController.clear();
      Get.back();
      Get.snackbar("Notice Published", "The notification has been broadcasted.");
    }
  }
}
