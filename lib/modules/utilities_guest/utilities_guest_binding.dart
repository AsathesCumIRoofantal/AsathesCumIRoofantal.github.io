import 'package:get/get.dart';

class UtilitiesGuestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilitiesGuestController>(() => UtilitiesGuestController());
  }
}

class UtilitiesGuestController extends GetxController {
  final utilities = [
    {'name': 'All-Space Search', 'icon': 'search', 'desc': 'Find any public entity or union.'},
    {'name': 'Identity Calculator', 'icon': 'calculate', 'desc': 'Estimate your systemic coordinates.'},
    {'name': 'Public Atlas', 'icon': 'map', 'desc': 'View non-confidential nodes.'},
    {'name': 'Global Stats', 'icon': 'analytics', 'desc': 'Real-time growth of the atlas.'},
  ].obs;
}
