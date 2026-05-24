import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebPublicController extends GetxController {
  // --- Public Reach Metrics ---
  final totalViews = 12405.obs;
  final globalShares = 842.obs;
  final followerCount = 1200.obs;

  // --- Public Assets (The Showcase) ---
  final List<Map<String, dynamic>> publicAssets = [
    {
      'title': 'Research on AI Ethics',
      'type': 'Publication',
      'reach': '2.4k reads',
      'thumbnail': 'https://picsum.photos/400/600', // Mock image
      'color': const Color(0xFF7C3AED),
      'category': 'Academic',
      'isFeatured': true,
    },
    {
      'title': 'Sliver Architecture Guide',
      'type': 'Technical Doc',
      'reach': '5.1k reads',
      'thumbnail': 'https://picsum.photos/400/300',
      'color': const Color(0xFFC084FC),
      'category': 'Engineering',
      'isFeatured': false,
    },
    {
      'title': 'Collaboration Video',
      'type': 'Media',
      'reach': '12k views',
      'thumbnail': 'https://picsum.photos/400/400',
      'color': const Color(0xFF8B5CF6),
      'category': 'Creative',
      'isFeatured': false,
    },
    {
      'title': 'Open Source Contribution',
      'type': 'Code',
      'reach': '800 stars',
      'thumbnail': 'https://picsum.photos/400/500',
      'color': const Color(0xFF6D28D9),
      'category': 'Development',
      'isFeatured': false,
    },
    {
      'title': 'Philosophy of AIR Space',
      'type': 'Essay',
      'reach': '3.2k reads',
      'thumbnail': 'https://picsum.photos/400/700',
      'color': const Color(0xFF4C1D95),
      'category': 'Wisdom',
      'isFeatured': true,
    },
  ].obs;

  void incrementViews() => totalViews.value++;
}
