import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_identities_earnings_controller.dart';

class WebIdentitiesEarningsView
    extends GetView<WebIdentitiesEarningsController> {
  static const routeName = '/web-be_you/identities-earnings';
  const WebIdentitiesEarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF059669); // Be-You Emerald
    final secondaryColor = const Color(0xFF065F46);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF0FDF4),
        body: CustomScrollView(
          slivers: [
            // 1. SliverAppBar (Hero Gradient)
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Identities & Earnings',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        '\$ 600',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                      ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
                    ),
                  ),
                ),
              ),
            ),

            // 2. Filter Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: ['Month', 'Year', 'All Time'].map((p) {
                    return Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(p),
                          selected: controller.selectedPeriod.value == p,
                          onSelected: (_) {
                            controller.selectedPeriod.value = p;
                          },
                          selectedColor: primaryColor,
                          labelStyle: TextStyle(
                            color: controller.selectedPeriod.value == p
                                ? Colors.white
                                : (isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 3. Flutter 2026 Block (Required per Handbook Section 10)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        'On-Device AI',
                        'Categorizing earnings by identity persona automatically.',
                      ),
                      _buildFeatureRow(
                        'Sliver Architecture',
                        'Ultra-smooth scrolling for 1000+ transaction records.',
                      ),
                      _buildFeatureRow(
                        'Impeller Engine',
                        'Zero-jank transitions between earnings charts.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. Content Grid (Identity Cards)
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = controller.identities[index];
                  return Container(
                        decoration: BoxDecoration(
                          color: isDark ? WColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: primaryColor,
                              size: 40,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'id:1',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '\$ 5 amount}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideY(begin: 0.2);
                }, childCount: controller.identities.length),
              ),
            ),

            // Bottom Padding
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
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
