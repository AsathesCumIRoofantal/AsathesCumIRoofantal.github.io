import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum KnowledgeStatus { approved, pending, rejected }

class KnowledgeEntry {
  final String id;
  final String title;
  final String detail;
  final String? query;
  final String? solution;
  final KnowledgeStatus status;
  final DateTime timestamp;
  final List<String> attachments;

  KnowledgeEntry({
    required this.id,
    this.title = '',
    this.detail = '',
    this.query,
    this.solution,
    required this.status,
    required this.timestamp,
    this.attachments = const [],
  });
}

class KnowledgeCenterController extends GetxController {
  var historyList = <KnowledgeEntry>[].obs;
  var isThinking = false.obs;
  var searchQuery = ''.obs;

  List<KnowledgeEntry> get filteredHistory {
    if (searchQuery.value.isEmpty) {
      return historyList;
    }
    final query = searchQuery.value.toLowerCase();
    return historyList.where((entry) {
      return entry.title.toLowerCase().contains(query) ||
             (entry.query?.toLowerCase().contains(query) ?? false) ||
             entry.detail.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    historyList.addAll([
      KnowledgeEntry(
        id: '1',
        title: 'Mission of AIR',
        query: 'What is the primary mission of the AIR Organization?',
        solution: 'The AIR Organization aims to establish absolute transparency in all-space by mapping every entity and union, ensuring accountability through a decentralized ecosystem.',
        status: KnowledgeStatus.approved,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
      KnowledgeEntry(
        id: '2',
        title: 'Alifiyas Mapping Specs',
        detail: 'Technical specifications for mapping dormant entities in the Alifiyas sector.',
        status: KnowledgeStatus.approved,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ]);
  }

  Future<void> submitQuery(String text) async {
    if (text.isEmpty) return;

    isThinking.value = true;
    
    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 2));

    final newEntry = KnowledgeEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      query: text,
      solution: 'Based on the AIR Knowledge Graph, your query regarding "$text" indicates a high correlation with decentralized mapping protocols. We suggest cross-referencing with the Alifiyas Atlas for deeper context.',
      status: KnowledgeStatus.approved,
      timestamp: DateTime.now(),
    );

    historyList.insert(0, newEntry);
    isThinking.value = false;
    
    Get.snackbar(
      'AI Solution Generated',
      'The AIR intelligence node has processed your query.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.1),
      colorText: Get.theme.colorScheme.primary,
    );
  }

  void addKnowledge({
    required String title,
    required String detail,
    required List<String> attachments,
  }) {
    if (title.isEmpty || detail.isEmpty) {
      Get.snackbar(
        'Warning',
        'Title and details are required for knowledge cataloging.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newEntry = KnowledgeEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      detail: detail,
      status: KnowledgeStatus.pending,
      attachments: attachments,
      timestamp: DateTime.now(),
    );

    historyList.insert(0, newEntry);
    Get.back(); // Close modal
    
    Get.snackbar(
      'Submitted',
      'Knowledge entry logged for Administrative Review.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.amber.withOpacity(0.1),
      colorText: Colors.amber,
    );
  }
}
