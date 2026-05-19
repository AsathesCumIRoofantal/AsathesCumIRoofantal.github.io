import 'package:get/get.dart';

class WebCategoryTreeController extends GetxController {
  final expandedNodes = <String>{}.obs;

  void toggleNode(String nodeId) {
    if (expandedNodes.contains(nodeId)) {
      expandedNodes.remove(nodeId);
    } else {
      expandedNodes.add(nodeId);
    }
  }
}
