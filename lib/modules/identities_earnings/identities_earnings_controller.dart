import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum IdentityType { entity, union }

class IdentityEarningModel {
  final String id;
  final IdentityType type;
  final String title;
  final String earnings;
  final DateTime dateTime;
  final String jobDetail;

  IdentityEarningModel({
    required this.id,
    required this.type,
    required this.title,
    required this.earnings,
    required this.dateTime,
    required this.jobDetail,
  });
}

class IdentitiesEarningsController extends GetxController {
  var earningsList = <IdentityEarningModel>[].obs;
  var searchQuery = ''.obs;

  List<IdentityEarningModel> get filteredEarnings {
    if (searchQuery.value.isEmpty) {
      return earningsList;
    }
    return earningsList.where((item) {
      final query = searchQuery.value.toLowerCase();
      return item.title.toLowerCase().contains(query) ||
             item.jobDetail.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    earningsList.addAll([
      IdentityEarningModel(
        id: '1',
        type: IdentityType.entity,
        title: 'Atlas Mapping Expert',
        earnings: '2500 AIR Credits',
        dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
        jobDetail: 'Successfully mapped 50+ dormant entities in the sector 7 atlas refactor project.',
      ),
      IdentityEarningModel(
        id: '2',
        type: IdentityType.union,
        title: 'Galaxy Sync Group',
        earnings: '1200 Wisdom Points',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        jobDetail: 'Coordinated a massive union between 12 disparate educational entities for the Alifiyas tour.',
      ),
      IdentityEarningModel(
        id: '3',
        type: IdentityType.entity,
        title: 'Systemic Auditor',
        earnings: '500 Transparency Tokens',
        dateTime: DateTime.now().subtract(const Duration(hours: 5)),
        jobDetail: 'Audited the transparency logs for the latest batch of identity mappings.',
      ),
    ]);
  }

  void addEarning({
    required String title,
    required String earnings,
    required IdentityType type,
    required String jobDetail,
  }) {
    if (title.isEmpty || earnings.isEmpty || jobDetail.isEmpty) {
      Get.snackbar(
        'Incomplete Record',
        'All fields are essential for identity value mapping.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.1),
        colorText: Colors.orange,
      );
      return;
    }

    final newRecord = IdentityEarningModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      title: title,
      earnings: earnings,
      dateTime: DateTime.now(),
      jobDetail: jobDetail,
    );

    earningsList.insert(0, newRecord);
    Get.back(); // Close modal
    
    Get.snackbar(
      'Value Minted',
      'Accomplishment successfully bridged to your identity.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.tertiary.withOpacity(0.1),
      colorText: Get.theme.colorScheme.tertiary,
    );
  }

  double get totalCredits {
    // Simple mock parser for "Total Rewards" card
    return earningsList.length * 1000.0; 
  }
}
