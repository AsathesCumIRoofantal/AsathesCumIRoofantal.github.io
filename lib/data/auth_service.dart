import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final userRole = 'Alifiyas'.obs; // Default to Alifiyas
  final userName = ''.obs;

  void login(String name, String role) {
    userName.value = name;
    userRole.value = role;
  }

  bool get isExpert => userRole.value == 'Mazeasta';
}
