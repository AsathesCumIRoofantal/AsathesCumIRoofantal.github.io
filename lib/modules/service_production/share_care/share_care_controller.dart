import 'package:get/get.dart';

class SupportTicket {
  final String user;
  final String issue;
  final String urgency;

  SupportTicket({required this.user, required this.issue, required this.urgency});
}

class ShareCareController extends GetxController {
  final activeTickets = <SupportTicket>[
    SupportTicket(user: "User_12", issue: "Locked out of vault.", urgency: "High"),
    SupportTicket(user: "User_45", issue: "Credits not showing.", urgency: "Medium"),
  ].obs;

  void provideSupport() {
    Get.snackbar("Support Initiated", "Connecting you to the help desk...");
  }
}
