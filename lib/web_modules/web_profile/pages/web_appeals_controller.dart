import 'package:get/get.dart';

class WebAppealsController extends GetxController {
  final isLoading = false.obs;
  final selectedTab = 'Pending'.obs;

  // Mock data for appeals with a multi-stage process
  final List<Map<String, dynamic>> appealsList = [
    {
      'id': 'APP-9021',
      'subject': 'Account Restriction Appeal',
      'category': 'Security',
      'status': 'Approved', // Approved, Rejected, Pending, Reviewing
      'submitted': 'Oct 12, 2023',
      'verdictDate': 'Oct 15, 2023',
      'evidenceCount': 3,
      'outcome': 'Full access restored to the Digitalize Hub.',
      'priority': 'High',
    },
    {
      'id': 'APP-4432',
      'subject': 'Credit Refund Request',
      'category': 'Financial',
      'status': 'Pending',
      'submitted': 'Nov 02, 2023',
      'verdictDate': null,
      'evidenceCount': 1,
      'outcome': null,
      'priority': 'Medium',
    },
    {
      'id': 'APP-1109',
      'subject': 'Badge Level Dispute',
      'category': 'Achievements',
      'status': 'Rejected',
      'submitted': 'Sept 20, 2023',
      'verdictDate': 'Sept 25, 2023',
      'evidenceCount': 5,
      'outcome': 'Insufficient evidence provided for Diamond Tier.',
      'priority': 'Low',
    },
  ].obs;

  List<Map<String, dynamic>> get filteredAppeals {
    if (selectedTab.value == 'All') return appealsList;
    return appealsList.where((a) => a['status'] == selectedTab.value).toList();
  }

  void setTab(String tab) => selectedTab.value = tab;
}
