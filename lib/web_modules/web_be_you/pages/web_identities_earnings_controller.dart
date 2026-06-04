import 'package:get/get.dart';

class WebIdentitiesEarningsController extends GetxController {
  final selectedPeriod = 'Month'.obs;
  final selectedIdentity = 'All'.obs;
  final isLoading = false.obs;

  final periods = ['Week', 'Month', 'Quarter', 'Year', 'All Time'];
  final identities = [
    'All',
    'Professional',
    'Freelance',
    'Entity',
    'Union',
    'Community',
  ];

  void setPeriod(String p) => selectedPeriod.value = p;
  void setIdentity(String id) => selectedIdentity.value = id;
}
