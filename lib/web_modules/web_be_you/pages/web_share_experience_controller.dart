import 'package:get/get.dart';

class WebShareExperienceController extends GetxController {
  final postText = ''.obs;

  void updatePostText(String text) => postText.value = text;
}
