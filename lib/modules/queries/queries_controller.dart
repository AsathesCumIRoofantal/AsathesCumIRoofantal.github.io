import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/query_model.dart';

class QueriesController extends GetxController {
  var allQueries = <QueryModel>[].obs;
  var displayQueries = <QueryModel>[].obs;
  
  var searchQuery = ''.obs;
  var dateFilterType = 'All Time'.obs; // All Time, Past 7 Days, Past 30 Days
  
  // Form controllers
  final subjectController = TextEditingController();
  final descController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadInitialMockQueries();
  }

  @override
  void onClose() {
    subjectController.dispose();
    descController.dispose();
    super.onClose();
  }

  void _loadInitialMockQueries() {
    allQueries.assignAll([
      QueryModel(
        id: 'q_1',
        subject: 'How does the AIR rating work for subsets?',
        description: 'I noticed some entities have higher classifications. Is this related to my Get-As-Identified phase?',
        dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Answered',
        attachedFiles: ['AIR_rating_screenshot.png'],
      ),
      QueryModel(
        id: 'q_2',
        subject: 'Where to find deeper philosophical nodes?',
        description: 'Searching for documentation regarding the consciousness entropy mappings. Could you guide me?',
        dateSubmitted: DateTime.now().subtract(const Duration(days: 14)),
        status: 'Pending',
      ),
    ]);
    _applyFilters();
  }

  void updateSearch(String val) {
    searchQuery.value = val;
    _applyFilters();
  }

  void updateDateFilter(String filter) {
    dateFilterType.value = filter;
    _applyFilters();
  }

  void _applyFilters() {
    var temp = allQueries.toList();
    
    // Apply Date Filter
    if (dateFilterType.value == 'Past 7 Days') {
      temp = temp.where((q) => q.dateSubmitted.isAfter(DateTime.now().subtract(const Duration(days: 7)))).toList();
    } else if (dateFilterType.value == 'Past 30 Days') {
      temp = temp.where((q) => q.dateSubmitted.isAfter(DateTime.now().subtract(const Duration(days: 30)))).toList();
    }

    // Apply String Filter
    if (searchQuery.value.isNotEmpty) {
      final s = searchQuery.value.toLowerCase();
      temp = temp.where((q) => 
        q.subject.toLowerCase().contains(s) || q.description.toLowerCase().contains(s)
      ).toList();
    }

    // Sort by Date Descending
    temp.sort((a, b) => b.dateSubmitted.compareTo(a.dateSubmitted));

    displayQueries.assignAll(temp);
  }

  void submitQuery() {
    if (subjectController.text.trim().isEmpty || descController.text.trim().isEmpty) {
      Get.snackbar('Input Required', 'Please fill in both Subject and Description fields.', 
        backgroundColor: Colors.redAccent.withOpacity(0.8), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Append to list directly
    allQueries.add(QueryModel(
      id: 'q_${DateTime.now().millisecondsSinceEpoch}',
      subject: subjectController.text.trim(),
      description: descController.text.trim(),
      dateSubmitted: DateTime.now(),
      status: 'Pending',
      attachedFiles: ['Mock_Attachment.pdf'] // We always pretend there's an attachment for the UX
    ));

    // Clear and update
    subjectController.clear();
    descController.clear();
    _applyFilters();

    Get.back(); // Close bottom sheet
    Get.snackbar('Query Submitted', 'Your request has been filed with the Wisdom Engine.',
      backgroundColor: Colors.teal.withOpacity(0.8), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
  }
}
