import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebEntertainmentController extends GetxController {
  final selectedMood = 'Chill'.obs; // Chill, Hyper, Focus

  // Entertainment categories with associated mood tags
  final List<Map<String, dynamic>> entertainmentHubs = [
    {
      'title': 'Neural-Symphonies',
      'desc':
          'AI-generated soundscapes that adapt to your current cognitive load.',
      'mood': 'Chill',
      'icon': Icons.music_note_rounded,
      'color': const Color(0xFFE11D48),
      'type': 'Audio',
    },
    {
      'title': 'Sliver-Cinema',
      'desc': 'Immersive 8K documentaries on the evolution of the AIR Space.',
      'mood': 'Focus',
      'icon': Icons.movie_filter_rounded,
      'color': const Color(0xFFFB7185),
      'type': 'Video',
    },
    {
      'title': 'Quantum Gaming',
      'desc': 'Zero-latency strategy games played across multi-identity nodes.',
      'mood': 'Hyper',
      'icon': Icons.sports_esports_rounded,
      'color': const Color(0xFFF43F5E),
      'type': 'Gaming',
    },
    {
      'title': 'VR Imagination',
      'desc':
          'Walk through the conceptual blueprints of the 2026 architecture.',
      'mood': 'Chill',
      'icon': Icons.view_in_ar_rounded,
      'color': const Color(0xFFB91C1C),
      'type': 'Experience',
    },
    {
      'title': 'Sovereign Podcasts',
      'desc': 'Conversations with the architects of the AIR-Sliver pipeline.',
      'mood': 'Focus',
      'icon': Icons.podcasts_rounded,
      'color': const Color(0xFFE11D48),
      'type': 'Audio',
    },
  ].obs;

  List<Map<String, dynamic>> get filteredHubs {
    if (selectedMood.value == 'All') return entertainmentHubs;
    return entertainmentHubs
        .where((h) => h['mood'] == selectedMood.value)
        .toList();
  }

  void setMood(String mood) => selectedMood.value = mood;
}
