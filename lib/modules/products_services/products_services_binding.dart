import 'package:get/get.dart';
import 'products_services_controller.dart';

class ProductsServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsServicesController>(
      () => ProductsServicesController(),
    );
  }
}
