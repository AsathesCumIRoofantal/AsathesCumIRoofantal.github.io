import 'package:get/get.dart';
import 'marketing_promotion_controller.dart';

class MarketingPromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketingPromotionController>(() => MarketingPromotionController());
  }
}
