import 'package:air_app/core/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_repository.dart';
import 'models/user_model.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  blocked,
  unapproved,
  error,
}

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  late final AuthRepository _repo;

  final authState = AuthState.initial.obs;

  final currentUser = Rxn<AirUser>();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    _repo = AuthRepository(Supabase.instance.client);

    await restoreSession();
  }

  // ==========================================================
  // Current User Helpers
  // ==========================================================

  bool get isLoggedIn => currentUser.value != null;

  String get userId => currentUser.value?.userId ?? '';

  String get mobile => currentUser.value?.mobile ?? '';

  String get userName => currentUser.value?.name ?? '';

  int get roleId => currentUser.value?.userRole ?? 0;

  bool get isSuperAdmin => currentUser.value?.isSuperAdmin ?? false;

  bool get isAdmin => currentUser.value?.isAdmin ?? false;

  bool get isManager => currentUser.value?.isManager ?? false;

  bool get isAgent => currentUser.value?.isAgent ?? false;

  bool get isMember => currentUser.value?.isMemberRole ?? false;

  // ==========================================================
  // Login
  // ==========================================================

  Future<bool> loginWithGoogle() async {
    try {
      authState.value = AuthState.loading;
      isLoading.value = true;

      final responseBool = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
      );

      if (!responseBool) {
        authState.value = AuthState.error;
        errorMessage.value = 'Google login failed';
        return false;
      }

      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        errorMessage.value = 'User not found in database';
        authState.value = AuthState.error;
        return false;
      }

      final userModel = await _repo.getUserById(user.id);

      if (userModel == null) {
        errorMessage.value = 'User not found in database';
        authState.value = AuthState.error;
        return false;
      }

      currentUser.value = userModel;
      await _saveSession(user.id);

      authState.value = AuthState.authenticated;
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      authState.value = AuthState.error;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loginWithApple() async {
    try {
      authState.value = AuthState.loading;
      isLoading.value = true;

      final responseBool = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.apple,
      );

      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        errorMessage.value = 'User not found in database';
        authState.value = AuthState.error;
        return false;
      }

      final userModel = await _repo.getUserById(user.id);

      if (userModel == null) {
        errorMessage.value = 'User not found in database';
        authState.value = AuthState.error;
        return false;
      }

      currentUser.value = userModel;
      await _saveSession(user.id);

      authState.value = AuthState.authenticated;

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      authState.value = AuthState.error;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loginWithPhone({
    required String mobile,
    required String password,
  }) async {
    try {
      authState.value = AuthState.loading;

      isLoading.value = true;

      final user = await _repo.getUserByMobile(mobile);

      if (user == null) {
        errorMessage.value = 'User not found';

        authState.value = AuthState.error;

        return false;
      }

      if (user.password != password) {
        errorMessage.value = 'Invalid password';

        authState.value = AuthState.error;

        return false;
      }

      if (user.isBlocked == 1) {
        authState.value = AuthState.blocked;

        return false;
      }

      if (user.isApproved == 0) {
        authState.value = AuthState.unapproved;

        return false;
      }

      currentUser.value = user;

      await _saveSession(user.userId);

      authState.value = AuthState.authenticated;

      return true;
    } catch (e) {
      errorMessage.value = e.toString();

      authState.value = AuthState.error;

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loginWithUserID({
    required String userID,
    required String password,
  }) async {
    try {
      authState.value = AuthState.loading;

      isLoading.value = true;

      final user = await _repo.getUserByUserID(userID);

      if (user == null) {
        errorMessage.value = 'User not found';

        authState.value = AuthState.error;

        return false;
      }

      if (user.password != password) {
        errorMessage.value = 'Invalid password';

        authState.value = AuthState.error;

        return false;
      }

      if (user.isBlocked == 1) {
        authState.value = AuthState.blocked;

        return false;
      }

      if (user.isApproved == 0) {
        authState.value = AuthState.unapproved;

        return false;
      }

      currentUser.value = user;

      await _saveSession(user.userId);

      authState.value = AuthState.authenticated;

      return true;
    } catch (e) {
      errorMessage.value = e.toString();

      authState.value = AuthState.error;

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> signupWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      authState.value = AuthState.loading;

      isLoading.value = true;
      await Supabase.instance.client.auth.signOut();
      await Future.delayed(const Duration(seconds: 1));
      if (Supabase.instance.client.auth.currentSession != null) {
        Get.snackbar(
          'Error',
          'User is already logged in! May redirecting to home screen...',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
          colorText: Colors.redAccent,
        );
        print("User is already logged in! Redirecting to home screen...");
        // Add your navigation router logic here to skip the form
        return false;
      }

      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) return false;

      // await Supabase.instance.client.auth.confirm;

      // final user = Supabase.instance.client.auth.currentUser;

      // if (user == null) return false;

      return true;
    } catch (e) {
      errorMessage.value = e.toString();

      authState.value = AuthState.error;

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> getLoggedIn({
    required String userID,
    required String password,
    required String email,
  }) async {
    try {
      authState.value = AuthState.loading;
      isLoading.value = true;

      final response = await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.signup,
        email: email,
        token: password,
      );

      if (response.user == null) return false;

      await _saveSession(response.user!.id);

      authState.value = AuthState.authenticated;

      return true;
    } catch (e) {
      errorMessage.value = e.toString();

      authState.value = AuthState.error;

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // OTP LOGIN
  // ==========================================================

  Future<void> sendOtp(String mobile) async {
    // TODO:
    // Twilio
    // MSG91
    // Firebase Auth
    // Supabase OTP
  }

  Future<bool> verifyOtp({required String mobile, required String otp}) async {
    // TODO
    return false;
  }

  // ==========================================================
  // Forgot Password
  // ==========================================================

  Future<void> forgotPassword(String mobile) async {
    // TODO

    // send sms

    // send email

    // generate reset token
  }

  Future<void> resetPassword({
    required String userId,
    required String password,
  }) async {
    final user = await _repo.getUserById(userId);

    if (user == null) return;
    user.password = password;
    await _repo.updateUser(user);
  }

  // ==========================================================
  // Session
  // ==========================================================

  Future<void> restoreSession() async {
    try {
      final box = Get.find<SecureStorage>();

      final String? uid = await box.readSupabaseUID();

      if (uid == null) {
        authState.value = AuthState.unauthenticated;

        return;
      }

      final user = await _repo.getUserById(uid);

      if (user == null) {
        authState.value = AuthState.unauthenticated;

        return;
      }

      currentUser.value = user;

      authState.value = AuthState.authenticated;
    } catch (_) {
      authState.value = AuthState.unauthenticated;
    }
  }

  Future<void> logout() async {
    final box = Get.find<SecureStorage>();

    await box.deleteSupabaseUID();

    currentUser.value = null;

    authState.value = AuthState.unauthenticated;
  }

  Future<void> _saveSession(String uid) async {
    final box = Get.find<SecureStorage>();

    await box.saveSupabaseUID(uid);
  }

  // ==========================================================
  // Profile
  // ==========================================================

  Future<void> refreshProfile() async {
    if (!isLoggedIn) return;

    final user = await _repo.getUserById(userId);

    if (user != null) {
      currentUser.value = user;
    }
  }

  Future<void> updateProfile(AirUser user) async {
    final updated = await _repo.updateUser(user);

    currentUser.value = updated;
  }

  // ==========================================================
  // FCM
  // ==========================================================

  Future<void> updateFcmToken(String token) async {
    if (!isLoggedIn) return;

    await _repo.updateFcmToken(userId: userId, token: token);
  }

  // ==========================================================
  // LOCATION
  // ==========================================================

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
  }) async {
    if (!isLoggedIn) return;

    await _repo.updateLocation(
      userId: userId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  // ==========================================================
  // Presence
  // ==========================================================

  Future<void> markOnline() async {
    // TODO
  }

  Future<void> markOffline() async {
    // TODO
  }

  // ==========================================================
  // Audit Logs
  // ==========================================================

  Future<void> logAction(String action) async {
    // TODO
  }

  // ==========================================================
  // Device Tracking
  // ==========================================================

  Future<void> registerDevice() async {
    // TODO
  }

  Future<void> unregisterDevice() async {
    // TODO
  }
}
