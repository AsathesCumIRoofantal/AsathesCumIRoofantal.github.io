import 'package:get/get.dart';
import 'web_products_services_controller.dart';
class WebProductsServicesBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebProductsServicesController>(() => WebProductsServicesController());
}
