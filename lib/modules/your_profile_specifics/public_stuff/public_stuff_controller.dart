import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicPost {
  final String author;
  final String content;
  final int likes;
  final DateTime time;

  PublicPost({required this.author, required this.content, required this.likes, required this.time});
}

class PublicStuffController extends GetxController {
  final posts = <PublicPost>[
    PublicPost(author: "Sarah J.", content: "Just saw the new satellite launch! Amazing views.", likes: 42, time: DateTime.now().subtract(const Duration(minutes: 15))),
    PublicPost(author: "Mike R.", content: "Anyone else joining the hackathon tomorrow?", likes: 12, time: DateTime.now().subtract(const Duration(hours: 2))),
  ].obs;

  final postController = TextEditingController();

  void createPost() {
    if (postController.text.isNotEmpty) {
      posts.insert(0, PublicPost(
        author: "Me",
        content: postController.text,
        likes: 0,
        time: DateTime.now(),
      ));
      postController.clear();
      Get.back();
      Get.snackbar("Posted", "Your update is now public.");
    }
  }

  @override
  void onClose() {
    postController.dispose();
    super.onClose();
  }
}
