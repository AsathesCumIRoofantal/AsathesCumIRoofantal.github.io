import 'package:get/get.dart';

class WebProcessController extends GetxController {
  final activePipeline = 'Standard Delivery'.obs;

  void setPipeline(String pipeline) => activePipeline.value = pipeline;
}
