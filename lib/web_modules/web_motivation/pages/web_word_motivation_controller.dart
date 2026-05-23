import 'package:get/get.dart';
class WebWordMotivationController extends GetxController {
  final activeQuote = 0.obs;
  final liked = <int>{}.obs;
  void nextQuote(int total) => activeQuote.value = (activeQuote.value + 1) % total;
  void toggleLike(int i) {
    if (liked.contains(i)) liked.remove(i); else liked.add(i);
  }
}
