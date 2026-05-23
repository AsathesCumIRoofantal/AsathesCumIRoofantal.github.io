import 'package:get/get.dart';
class WebProductsServicesController extends GetxController {
  final viewMode = 'grid'.obs; // 'grid' | 'list'
  final filterIndex = 0.obs;
  final filters = ['All', 'Digital', 'Physical', 'Services', 'Resources'];
}
