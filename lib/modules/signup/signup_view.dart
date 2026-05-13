import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new, color: tertiary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Create Identity',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join the AIR network and explore the all-space.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.dividerColor,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Role Selection
                  Text(
                    'CHOOSE YOUR INITIAL PATH',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tertiary.withOpacity(0.7),
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: controller.roles
                              .where((e) => e == 'Alifiyas' || e == 'Mazeasta')
                              .map((role) {
                                final isSelected =
                                    controller.selectedRole.value == role;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.setRole(role),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: role == 'Alifiyas' ? 8 : 0,
                                        left: role == 'Mazeasta' ? 8 : 0,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? tertiary.withOpacity(0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected
                                              ? tertiary
                                              : theme.dividerColor.withOpacity(
                                                  0.2,
                                                ),
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
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
                                          Text(
                                            controller.roleDescriptions[role]!,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isSelected
                                                  ? tertiary.withOpacity(0.7)
                                                  : theme.dividerColor
                                                        .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: controller.roles
                              .where((e) => e == 'Roofantal' || e == 'Asathes')
                              .map((role) {
                                final isSelected =
                                    controller.selectedRole.value == role;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.setRole(role),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: role == 'Roofantal' ? 8 : 0,
                                        left: role == 'Asathes' ? 8 : 0,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? tertiary.withOpacity(0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected
                                              ? tertiary
                                              : theme.dividerColor.withOpacity(
                                                  0.2,
                                                ),
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
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
                                          Text(
                                            controller.roleDescriptions[role]!,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isSelected
                                                  ? tertiary.withOpacity(0.7)
                                                  : theme.dividerColor
                                                        .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  TextField(
                    controller: controller.usernameController,
                    decoration: _inputDecoration(
                      'Username',
                      Icons.person_outline,
                      context,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.emailController,
                    decoration: _inputDecoration(
                      'Email Address',
                      Icons.email_outlined,
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
                  const SizedBox(height: 40),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: tertiary.withOpacity(0.5),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'REQUEST IDENTITY',
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
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have a node? ",
                          style: TextStyle(color: theme.dividerColor),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
        color: theme.colorScheme.tertiary.withOpacity(0.7),
      ),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.dividerColor.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.dividerColor.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withOpacity(0.5),
    );
  }
}
