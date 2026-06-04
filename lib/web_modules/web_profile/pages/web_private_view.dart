import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_private_controller.dart';

class WebPrivateView extends GetView<WebPrivateController> {
  static const routeName = '/web-profile/private';
  const WebPrivateView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF7C3AED); // Profile Violet
    final obsidianColor = const Color(0xFF0F172A);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF1F5F9),
        body: Stack(
          children: [
            // THE MAIN CONTENT (Slivers)
            CustomScrollView(
              slivers: [
                // 1. THE VAULT DOOR HEADER
                SliverAppBar(
                  expandedHeight: 350,
                  pinned: true,
                  backgroundColor: obsidianColor,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Confidential Vault',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [obsidianColor, Color(0xFF1E293B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child:
                            Icon(
                                  Icons.lock_outline_rounded,
                                  size: 160,
                                  color: primaryColor.withValues(alpha: 0.3),
                                )
                                .animate(onPlay: (c) => c.repeat())
                                .shimmer(duration: Duration(seconds: 2)),
                      ),
                    ),
                  ),
                ),

                // 2. BIOMETRIC UNLOCK AREA
                SliverToBoxAdapter(
                  child: Center(
                    child: Obx(
                      () => AnimatedSwitcher(
                        duration: 500.ms,
                        child: !controller.isUnlocked.value
                            ? _buildUnlockConsole(primaryColor)
                            : _buildUnlockedHeader(primaryColor),
                      ),
                    ),
                  ),
                ),

                // 3. THE ENCRYPTED FILES (Blurred until unlocked)
                Obx(
                  () => SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final file = controller.secureFiles[index];
                        return _SecureFileCard(
                          file: file,
                          isUnlocked: controller.isUnlocked.value,
                          isDark: isDark,
                        );
                      }, childCount: controller.secureFiles.length),
                    ),
                  ),
                ),

                // 4. FLUTTER 2026 BLOCK
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFFA78BFA),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Flutter 2026 Powers This',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildFeatureRow(
                            'Zero-Knowledge Proofs',
                            'Verification of identity without exposing raw biometric data.',
                          ),
                          _buildFeatureRow(
                            'Frosted Glass Redaction',
                            'GPU-accelerated blur filters that lift only on authenticated hover.',
                          ),
                          _buildFeatureRow(
                            'Sliver-Symmetric Encryption',
                            'Data blocks that decrypt on-the-fly as they enter the viewport.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 60)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnlockConsole(Color color) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'SENSITIVE AREA',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => controller.authenticate(),
            child: Obx(
              () => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isAuthenticating.value
                      ? Colors.white24
                      : color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child:
                    Icon(
                          controller.isAuthenticating.value
                              ? Icons.sync
                              : Icons.fingerprint,
                          color: Colors.white,
                          size: 50,
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .rotate(duration: Duration(seconds: 4)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            controller.isAuthenticating.value
                ? 'SCANNING BIOMETRICS...'
                : 'TAP TO UNLOCK VAULT',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockedHeader(Color color) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.lock_open_rounded, color: Colors.greenAccent),
              SizedBox(width: 10),
              Text(
                'VAULT UNLOCKED',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => controller.lockVault(),
            child: const Text(
              'LOCK VAULT',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Color(0xFFA78BFA),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecureFileCard extends StatelessWidget {
  final Map<String, dynamic> file;
  final bool isUnlocked;
  final bool isDark;
  const _SecureFileCard({
    required this.file,
    required this.isUnlocked,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: isUnlocked
              ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
              : ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: file['color'].withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.description_rounded, color: file['color']),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file['fileName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        file['description'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  file['size'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.05);
  }
}
