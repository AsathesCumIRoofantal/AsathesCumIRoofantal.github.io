import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessStory {
  final String title;
  final String content;
  final IconData icon;

  SuccessStory({required this.title, required this.content, required this.icon});
}

class NeverGiveUpController extends GetxController {
  final stories = <SuccessStory>[
    SuccessStory(title: "The Phoenix Node", content: "After a 48-hour blackout, our team rebuilt the entire sector sync in record time.", icon: Icons.auto_awesome_rounded),
    SuccessStory(title: "Zero to Hero", content: "A small-scale registry that grew to handle 10 million daily transactions.", icon: Icons.trending_up_rounded),
  ].obs;
}
