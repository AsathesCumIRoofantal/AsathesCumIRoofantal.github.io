import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WisdomController extends GetxController {
  // Data for Tab 1: Enlightened
  final enlightenedCategories = [
    {
      'title': 'Illusions',
      'icon': Icons.visibility_off,
      'color': Colors.pinkAccent,
      'shortDesc':
          'Imagination aspects suggested by an expert, but not believed to be realistic.',
      'longDesc':
          'Illusions are those imaginations aspects that are being there <as suggested by your expert, but you don\'t Believe in it To be realastic>. They challenge perception and help offspring understand the difference between objective truth and subjective processing of space data.',
    },
    {
      'title': 'Imagination',
      'icon': Icons.auto_awesome,
      'color': Colors.purpleAccent,
      'shortDesc': 'You Know in Thoughtfull Mind.',
      'longDesc':
          'Imagination is the ability to construct scenarios, entities, or unions within the cognitive network without physical stimuli. It allows for projection mapping and theoretical philosophy, a critical node in forming advanced intellect.',
    },
    {
      'title': 'Real',
      'icon': Icons.verified,
      'color': Colors.greenAccent,
      'shortDesc': 'All Validated and Verified',
      'longDesc':
          'Reality encompasses all validated and verified matrices of space. Entities and Unions mapped here possess measurable, constant attributes mathematically verifiable by the AIR Organization.',
    },
    {
      'title': 'Virtual',
      'icon': Icons.view_in_ar,
      'color': Colors.cyanAccent,
      'shortDesc': 'Not Being there',
      'longDesc':
          'The virtual state encompasses properties that simulate reality but fundamentally act as code configurations. They are <not Being there> physically, existing instead as structural abstractions.',
    },
  ].obs;

  // Track expanded state of cards
  var expandedCards = <int, bool>{}.obs;

  void toggleCardExpanded(int index) {
    if (expandedCards.containsKey(index)) {
      expandedCards[index] = !expandedCards[index]!;
    } else {
      expandedCards[index] = true;
    }
  }

  // Data for Tab 2: Task and Feed
  final expertTasks = [
    {
      'title': 'Verify Physics Document Comprehension',
      'confidential': true,
      'status': 'Pending Verification',
      'details':
          "Offspring must read 'Solar System Origins'. You must track their interpretation of gravity equations.",
    },
    {
      'title': 'Complete Identity Mapping Survey',
      'confidential': false,
      'status': 'In Progress',
      'details':
          "Ensure they complete the Get-As-Identified reflection truthfully to establish their node baseline.",
    },
  ].obs;

  // Data for Tab 3: Achievements
  final achievements = [
    {
      'title': 'First Philosophical Query',
      'date': '2 Days Ago',
      'icon': Icons.stars,
    },
    {
      'title': 'Understands Spatial Entropy',
      'date': '1 Week Ago',
      'icon': Icons.bolt,
    },
  ].obs;

  // Data for Tab 4: Things Considered
  final consideredResources = [
    'Monitor offspring\'s reaction to Abstract Entities.',
    'Plan a deep-dive on the AIR Organization hierarchy.',
    'Ensure exposure to Ethereal Light theme for minimal cognitive strain during reading.',
  ].obs;

  @override
  void onReady() {
    super.onReady();
    // Fire the specialized warning snackbar
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.snackbar(
        'EXPERT SUPERVISION REQUIRED',
        'Please do it under supervision of your Expert (Who recommended this to you to use it).',
        backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.warning, color: Colors.white),
        duration: const Duration(seconds: 5),
        isDismissible: false,
      );
    });
  }
}
