import 'package:get/get.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final isObscure = true.obs;

  void toggleObscure() => isObscure.value = !isObscure.value;

  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed('/');
  }
}
