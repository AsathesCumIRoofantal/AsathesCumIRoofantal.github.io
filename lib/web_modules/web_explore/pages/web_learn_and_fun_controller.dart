import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatGptFavorItem {
  final String title;
  final String description;
  final IconData icon;

  const ChatGptFavorItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class WebLearnAndFunController extends GetxController {
  // We can add state for the staggered animations or search
  final searchQuery = ''.obs;

  void setSearch(String val) => searchQuery.value = val;

  final isLoadingConsent = false.obs;

  final chatGptsFavor = <ChatGptFavorItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getChatGptsConsent();
  }

  Future<void> getChatGptsConsent() async {
    try {
      isLoadingConsent.value = true;

      await Future.delayed(const Duration(milliseconds: 500));

      chatGptsFavor.assignAll([
        const ChatGptFavorItem(
          icon: Icons.account_tree_outlined,
          title: 'Think Like A System',
          description:
              'Everything can be observed as a system. Explore family, school, business and technology systems.',
        ),
        const ChatGptFavorItem(
          icon: Icons.visibility_outlined,
          title: 'Observe Your World',
          description:
              'Observe a tree, road, market or classroom and note what works and what can improve.',
        ),
        const ChatGptFavorItem(
          icon: Icons.lightbulb_outline,
          title: 'Innovation Corner',
          description: 'Choose any object and suggest 3 improvements.',
        ),
        const ChatGptFavorItem(
          icon: Icons.public,
          title: 'AIR Discovery',
          description:
              'Connect Nature, Technology, Humanity and History together.',
        ),
        const ChatGptFavorItem(
          icon: Icons.extension,
          title: 'Fun Challenge',
          description:
              'Create a short story using Tree, Robot, Friend and Moon.',
        ),
        const ChatGptFavorItem(
          icon: Icons.music_note_outlined,
          title: 'Music & Bhajan Starter',
          description: 'Write four lines of gratitude, hope or devotion.',
        ),
        const ChatGptFavorItem(
          icon: Icons.groups_outlined,
          title: 'Collaboration Challenge',
          description:
              'Find a friend and solve one real-world problem together.',
        ),
        const ChatGptFavorItem(
          icon: Icons.auto_awesome_outlined,
          title: 'Wisdom Seed',
          description: 'Ask not only what is possible, but what is right.',
        ),
      ]);
    } finally {
      isLoadingConsent.value = false;
    }
  }
}
