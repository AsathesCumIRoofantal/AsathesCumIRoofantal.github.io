import 'package:get/get.dart';
import 'trade_import_export_controller.dart';

class TradeImportExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradeImportExportController>(() => TradeImportExportController());
  }
}
