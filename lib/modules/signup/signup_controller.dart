import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/auth_service.dart';

class SignupController extends GetxController {
  final isLoading = false.obs;
  final isObscure = true.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final selectedRole = 'Alifiyas'.obs;
  final roles = [
    'Alifiyas',
    'Mazeasta',
    'Roofantal',
    'Asathes',
    'Diplomat',
    'Developer',
    'Devotee',
    'God',
    'Meritorious',
    'Perfect',
    'Media',
    'Celebrity',
    'Advocate',
    'Judge',
    'Jobist',
    'Bussnessman',
    'Teacher',
    'Student',
  ];
  final roleDescriptions = <String, String>{
    'Alifiyas': 'The New Beginner',
    'Mazeasta': 'The Expert',
    'Roofantal': 'The Peace Agent',
    'Asathes': 'The Field Agent',
    'Diplomat': 'Politics and Diplomacy',
    'Developer': 'Developer and Researcher',
    'Devotee': 'The Devoted One',
    'God': 'The Supreme Being',
    'Meritorious': 'The Meritorious',
    'Perfect': 'The Perfect One',
    'Media': 'The Media Specialist',
    'Celebrity': 'The atrist',
    'Advocate': 'The Lawyer',
    'Judge': 'The Judge',
    'Jobist': 'The Jobist',
    'Bussnessman': 'The Bussnessman',
    'Teacher': 'The Teacher',
    'Student': 'The Student',
  };

  void toggleObscure() => isObscure.value = !isObscure.value;
  void setRole(String role) => selectedRole.value = role;

  void signup() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    AuthService.to.login(usernameController.text, selectedRole.value);

    Get.offAllNamed('/');
    Get.snackbar(
      'Success',
      'Welcome to AIR, ${usernameController.text}!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
