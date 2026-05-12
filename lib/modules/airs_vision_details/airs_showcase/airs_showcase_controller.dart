import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowcaseItem {
  final String title;
  final String category;
  final String imageUrl;
  final String description;

  ShowcaseItem({required this.title, required this.category, required this.imageUrl, required this.description});
}

class AirsShowcaseController extends GetxController {
  final items = <ShowcaseItem>[
    ShowcaseItem(
      title: "Smart City Sync",
      category: "Infrastructure",
      imageUrl: "https://example.com/city.jpg",
      description: "Successfully integrated the entire municipal energy grid into AIR.",
    ),
    ShowcaseItem(
      title: "Lunar Mining Log",
      category: "Space Ops",
      imageUrl: "https://example.com/moon.jpg",
      description: "First automated registry of lunar mineral extraction assets.",
    ),
    ShowcaseItem(
      title: "Global Supply Chain",
      category: "Logistics",
      imageUrl: "https://example.com/supply.jpg",
      description: "Real-time tracking of 5 million intercontinental shipments.",
    ),
  ].obs;
}
