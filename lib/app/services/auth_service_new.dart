// ============================================================
//  AIR App – Enhanced Auth Service  (Supabase + Dummy mode)
// ============================================================
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/storage/secure_storage.dart';

class AirAuthService extends GetxService {
  static AirAuthService get to => Get.find();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading  = false.obs;

  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }

  // ── Session restore ──────────────────────────────────────
  Future<void> _restoreSession() async {
    if (AppConstants.isDummyMode) {
      if (LocalStorage.to.hasSession) {
        currentUser.value = UserModel.dummy;
        isLoggedIn.value  = true;
      }
      return;
    }
    final jwt = await SecureStorage.to.readJwt();
    if (jwt != null) {
      isLoggedIn.value = true;
      // TODO: re-fetch real user profile from Supabase
    }
  }

  // ── OTP Request ──────────────────────────────────────────
  Future<bool> sendEmailOtp(String email) async {
    isLoading.value = true;
    try {
      if (AppConstants.isDummyMode) {
        await Future.delayed(const Duration(seconds: 1));
        return true;
      }
      // Real: await supabase.auth.signInWithOtp(email: email);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> sendPhoneOtp(String phone) async {
    isLoading.value = true;
    try {
      if (AppConstants.isDummyMode) {
        await Future.delayed(const Duration(seconds: 1));
        return true;
      }
      // Real: await supabase.auth.signInWithOtp(phone: phone);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── OTP Verify ───────────────────────────────────────────
  Future<bool> verifyOtp({required String contact, required String otp}) async {
    isLoading.value = true;
    try {
      if (AppConstants.isDummyMode) {
        await Future.delayed(const Duration(seconds: 1));
        if (otp == '123456') {
          await _setDummySession();
          return true;
        }
        return false;
      }
      // Real: verify with Supabase
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Login (email + password fallback) ────────────────────
  Future<bool> loginWithPassword({required String email, required String password}) async {
    isLoading.value = true;
    try {
      if (AppConstants.isDummyMode) {
        await Future.delayed(const Duration(seconds: 1));
        await _setDummySession();
        return true;
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Signup ────────────────────────────────────────────────
  Future<bool> signup({required String name, required String mobile, required String email}) async {
    isLoading.value = true;
    try {
      if (AppConstants.isDummyMode) {
        await Future.delayed(const Duration(seconds: 1));
        await _setDummySession();
        return true;
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Logout ────────────────────────────────────────────────
  Future<void> logout() async {
    isLoading.value = true;
    try {
      if (!AppConstants.isDummyMode) {
        // Real: await supabase.auth.signOut();
      }
      currentUser.value = null;
      isLoggedIn.value  = false;
      await LocalStorage.to.clearSession();
      await SecureStorage.to.clearAll();
      Get.offAllNamed('/login');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Dummy session helper ──────────────────────────────────
  Future<void> _setDummySession() async {
    currentUser.value = UserModel.dummy;
    isLoggedIn.value  = true;
    LocalStorage.to.userId       = UserModel.dummy.userId;
    LocalStorage.to.accessToken  = 'dummy_jwt_token';
    LocalStorage.to.refreshToken = 'dummy_refresh_token';
    LocalStorage.to.userRole     = UserModel.dummy.userRole;
  }
}
