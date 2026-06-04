import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostModel {
  final String id;
  final String title;
  final String content;
  final String category;
  final String mediaType;
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.mediaType,
    required this.timestamp,
  });
}

class RecordPostController extends GetxController {
  var posts = <PostModel>[].obs;

  final List<String> categories = [
    'Public',
    'Private',
    'System',
    'Philosophical',
  ];

  final List<Map<String, dynamic>> mediaTypes = [
    {'name': 'Text', 'icon': Icons.text_fields},
    {'name': 'Image', 'icon': Icons.image},
    {'name': 'PDF', 'icon': Icons.picture_as_pdf},
    {'name': 'Link', 'icon': Icons.link},
  ];

  var selectedCategory = 'Public'.obs;
  var selectedMediaType = 'Text'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    posts.addAll([
      PostModel(
        id: 'p1',
        title: 'Systemic Transparency',
        content:
            'Absolute transparency in all-space is the core guiding principle of the AIR Organization. This document outlines our commitment to decentralized mapping.',
        category: 'System',
        mediaType: 'PDF',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      PostModel(
        id: 'p2',
        title: 'The Be-You Manifesto',
        content:
            'Being yourself is the ultimate form of contribution to the global ecosystem. Each identity node is a unique treasure that must be protected and catalogued.',
        category: 'Philosophical',
        mediaType: 'Text',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PostModel(
        id: 'p3',
        title: 'New Node Finding: Alpha-7',
        content:
            'Our latest scans have identified a new digital node in the Beta sector. It appears to be a high-density cluster of abstract knowledge.',
        category: 'Public',
        mediaType: 'Link',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ]);
    // Sort newest to top
    posts.value = posts.reversed.toList();
  }

  void addPost(String title, String content) {
    if (title.isEmpty || content.isEmpty) {
      Get.snackbar(
        'Incomplete Record',
        'Title and content are required for all recordings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.1),
        colorText: Colors.orange,
      );
      return;
    }

    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      category: selectedCategory.value,
      mediaType: selectedMediaType.value,
      timestamp: DateTime.now(),
    );

    posts.insert(0, newPost);
    Get.back(); // Close modal

    Get.snackbar(
      'Recorded',
      'Your post has been successfully logged in the ecosystem.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.tertiary.withValues(alpha: 0.1),
      colorText: Get.theme.colorScheme.tertiary,
    );
  }
}
