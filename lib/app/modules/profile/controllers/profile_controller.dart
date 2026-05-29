// ============================================================
//  AIR App – Profile Controller
// ============================================================
import 'package:get/get.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service_new.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  Rx<UserModel?> get user => AirAuthService.to.currentUser;
  final RxBool isEditing  = false.obs;
  final RxBool isSaving   = false.obs;

  String get initials {
    final name = user.value?.name ?? 'U';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name[0].toUpperCase();
  }

  void toggleEdit() => isEditing.value = !isEditing.value;

  Future<void> saveProfile() async {
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 800)); // Dummy
    isSaving.value   = false;
    isEditing.value  = false;
    Get.snackbar('Profile Updated ✅', 'Your profile has been saved.',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> changeAvatar() async {
    Get.snackbar('Change Photo', 'Image picker integration in Phase 8.',
        snackPosition: SnackPosition.BOTTOM);
  }
}
