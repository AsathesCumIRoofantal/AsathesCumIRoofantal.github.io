import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final bool isEmbedded;
  const LoginView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          child: Center(
            child: SingleChildScrollView(
              physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: tertiary.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        color: tertiary.withValues(alpha: 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: tertiary.withValues(alpha: 0.2),
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
                  const SizedBox(height: 40),

                  // Role Selection
                  Text(
                    'CHOOSE YOUR PATH - AS GUEST',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tertiary.withValues(alpha: 0.7),
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: isEmbedded,
                          physics: isEmbedded
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          itemCount: controller.roles.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 2.2,
                              ),
                          itemBuilder: (context, index) {
                            final role = controller.roles[index];
                            final isSelected =
                                controller.selectedRole.value == role;

                            return GestureDetector(
                              onTap: () => controller.setRole(role),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? tertiary.withValues(alpha: 0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? tertiary
                                        : theme.dividerColor.withValues(
                                            alpha: 0.2,
                                          ),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? tertiary
                                            : theme.dividerColor,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      controller.roleDescriptions[role]!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSelected
                                            ? tertiary.withValues(alpha: 0.7)
                                            : theme.dividerColor.withValues(
                                                alpha: 0.5,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  TextField(
                    controller: controller.usernameController,
                    decoration: _inputDecoration(
                      'Username / Identity ID',
                      Icons.person_outline,
                      context,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.isObscure.value,
                      decoration: _inputDecoration(
                        'Secret Code',
                        Icons.lock_outline,
                        context,
                        suffix: IconButton(
                          icon: Icon(
                            controller.isObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: theme.dividerColor,
                          ),
                          onPressed: controller.toggleObscure,
                        ),
                      ),
                    ),
                  ),
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
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: tertiary.withValues(alpha: 0.5),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'ENTER ALL-SPACE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have a node? ",
                        style: TextStyle(color: theme.dividerColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.SIGNUP),
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
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context, {
    Widget? suffix,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: theme.dividerColor),
      prefixIcon: Icon(
        icon,
        color: theme.colorScheme.tertiary.withValues(alpha: 0.7),
      ),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }
}
