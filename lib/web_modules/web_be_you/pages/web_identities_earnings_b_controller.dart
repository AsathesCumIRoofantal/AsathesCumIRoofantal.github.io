import 'package:get/get.dart';

class WebIdentitiesEarningsBController extends GetxController {
  // Reactive state for earnings and filters
  final totalEarnings = 12450.75.obs;
  final selectedPeriod = 'All Time'.obs;
  final isLoading = false.obs;

  // Mock data for identity-based earnings
  final List<Map<String, dynamic>> identityEarnings = [
    {'id': 'Professional', 'amount': 8000.0, 'percentage': 0.64},
    {'id': 'Creative', 'amount': 3000.0, 'percentage': 0.24},
    {'id': 'Academic', 'amount': 1450.75, 'percentage': 0.12},
  ].obs;

  void updatePeriod(String period) {
    selectedPeriod.value = period;
    // In real app: fetch updated data from API here
  }
}
