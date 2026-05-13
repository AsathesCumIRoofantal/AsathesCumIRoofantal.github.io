import 'package:get/get.dart';
import 'ranking_orders_controller.dart';

class RankingOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingOrdersController>(() => RankingOrdersController());
  }
}
