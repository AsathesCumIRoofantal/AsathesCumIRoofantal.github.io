import 'package:get/get.dart';

class WebNoticesController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  final List<Map<String, dynamic>> allNotices = [
    {
      'title': 'System Upgrade v4.0',
      'content':
          'The AIR Space is upgrading to a new Impeller-based rendering engine. Expect 20% faster load times.',
      'date': '2 mins ago',
      'category': 'Update',
      'priority': 'High',
      'isRead': false,
    },
    {
      'title': 'Collaborative Event',
      'content':
          'Join the "Be-You" identity workshop this Friday at 10 AM. Registration is now open in the events tab.',
      'date': '2 hours ago',
      'category': 'Event',
      'priority': 'Medium',
      'isRead': false,
    },
    {
      'title': 'Security Patch',
      'content':
          'All users are advised to rotate their API keys for the Network Stuff module to maintain security.',
      'date': '1 day ago',
      'category': 'Security',
      'priority': 'Critical',
      'isRead': true,
    },
    {
      'title': 'New Utility Added',
      'content':
          'Check out the "Utilities as Guest" section in Air Space for new real-time conversion tools.',
      'date': '3 days ago',
      'category': 'Update',
      'priority': 'Low',
      'isRead': true,
    },
    {
      'title': 'Profile Badge Awarded',
      'content':
          'Congratulations! You have earned the "Sliver Master" badge for completing 10 profile modules.',
      'date': '1 week ago',
      'category': 'Achievement',
      'priority': 'Low',
      'isRead': true,
    },
  ].obs;

  List<Map<String, dynamic>> get filteredNotices {
    if (selectedCategory.value == 'All') return allNotices;
    return allNotices
        .where((n) => n['category'] == selectedCategory.value)
        .toList();
  }

  void setCategory(String cat) => selectedCategory.value = cat;
}
