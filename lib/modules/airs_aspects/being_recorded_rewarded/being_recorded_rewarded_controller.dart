import 'package:get/get.dart';

class RewardRecord {
  final String action;
  final String reward;
  final DateTime date;

  RewardRecord({required this.action, required this.reward, required this.date});
}

class BeingRecordedRewardedController extends GetxController {
  final records = <RewardRecord>[
    RewardRecord(action: "Data Verification", reward: "50 Credits", date: DateTime.now().subtract(const Duration(hours: 2))),
    RewardRecord(action: "Anomaly Report", reward: "100 Credits", date: DateTime.now().subtract(const Duration(days: 1))),
    RewardRecord(action: "Daily Sync", reward: "10 Credits", date: DateTime.now().subtract(const Duration(days: 2))),
  ].obs;
}
