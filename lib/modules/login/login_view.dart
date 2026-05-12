import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final tertiary = theme.colorScheme.tertiary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface,
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: tertiary.withOpacity(0.5), width: 2),
                      color: tertiary.withOpacity(0.05),
                      boxShadow: [
                        BoxShadow(
                          color: tertiary.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(Icons.air, color: tertiary, size: 64),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'Welcome to AIR',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to access your all-space node.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.dividerColor,
                  ),
                ),
                const SizedBox(height: 48),
                TextField(
                  decoration: _inputDecoration('Email / Identity ID', Icons.person_outline, context),
                ),
                const SizedBox(height: 24),
                Obx(() => TextField(
                  obscureText: controller.isObscure.value,
                  decoration: _inputDecoration(
                    'Secret Code',
                    Icons.lock_outline,
                    context,
                    suffix: IconButton(
                      icon: Icon(
                        controller.isObscure.value ? Icons.visibility_off : Icons.visibility,
                        color: theme.dividerColor,
                      ),
                      onPressed: controller.toggleObscure,
                    ),
                  ),
                )),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Identity?',
                      style: TextStyle(color: tertiary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: tertiary.withOpacity(0.5),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'ENTER ALL-SPACE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              letterSpacing: 2,
                            ),
                          ),
                  ),
                )),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a node? ",
                      style: TextStyle(color: theme.dividerColor),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Request Identity",
                        style: TextStyle(
                          color: tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, BuildContext context, {Widget? suffix}) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: theme.colorScheme.tertiary.withOpacity(0.7)),
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withOpacity(0.5),
    );
  }
}
