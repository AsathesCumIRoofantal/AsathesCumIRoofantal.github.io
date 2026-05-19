import 'package:get/get.dart';
import '../shell/web_shell.dart';

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
