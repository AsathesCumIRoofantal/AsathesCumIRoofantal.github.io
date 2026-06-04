import 'package:get/get.dart';

class VocabularyItem {
  final String term;
  final String definition;
  final String category;

  VocabularyItem({
    required this.term,
    required this.definition,
    required this.category,
  });
}

class VocabularyController extends GetxController {
  final searchQuery = ''.obs;
  
  final allItems = <VocabularyItem>[
    VocabularyItem(
      term: 'AIR (Artificial Intelligence Resources)',
      definition: 'The core ecosystem providing distributed intelligence and resource management.',
      category: 'System',
    ),
    VocabularyItem(
      term: 'Alifiyas',
      definition: 'Beginner level users or foundational modules within the AIR ecosystem.',
      category: 'Role',
    ),
    VocabularyItem(
      term: 'Mazeasta',
      definition: 'Expert level users or advanced governing modules within the AIR ecosystem.',
      category: 'Role',
    ),
    VocabularyItem(
      term: 'Anomalies',
      definition: 'Unexpected behaviors or data patterns within the system that require checking.',
      category: 'Technical',
    ),
    VocabularyItem(
      term: 'Wisdom Node',
      definition: 'A repository of verified knowledge and expert-level documentation.',
      category: 'Knowledge',
    ),
    VocabularyItem(
      term: 'Sync-Flow',
      definition: 'The protocol used for real-time data synchronization across AIR nodes.',
      category: 'Technical',
    ),
    VocabularyItem(
      term: 'Credit-Flux',
      definition: 'The dynamic reward system based on user contributions and system health.',
      category: 'Economic',
    ),
  ].obs;

  List<VocabularyItem> get filteredItems {
    if (searchQuery.value.isEmpty) return allItems;
    return allItems.where((item) {
      return item.term.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
             item.definition.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }
}
