// ============================================================
// web_modules/web_home_page.dart
// Route: /web-home  →  WebHomePage
// Responsive landing page for AIR – All-Space Web
// ============================================================

import 'package:air_app/routes/app_pages.dart';
import 'package:air_app/routes/web_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_web_layout.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  static const String routeName = '/web-home';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(
        title: 'ALL-SPACE · AIR',
        color: WColors.indigo,
        actions: [
          TextButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 15,
            ),
            label: const Text('Back', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Hero ──────────────────────────────────────────
            WHeroBanner(
              title: 'Everything in One Space',
              subtitle:
                  'AIR — Alifiyas Integrated Reality — is a living platform '
                  'where knowledge, identity, creativity, and community '
                  'converge into a single All-Space.',
              colorA: WColors.indigo,
              colorB: WColors.violet,
              icon: Icons.public_rounded,
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed("/");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: WColors.indigo,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.explore_rounded),
                  label: const Text(
                    'Explore AIR Base',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.offNamed(AppRoutes.LOGIN);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.login_rounded),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            // ── Stats row ──────────────────────────────────────
            Container(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: WMaxWidth(
                child: Row(
                  children: [
                    Expanded(
                      child: WStatChip(
                        value: '100+',
                        label: 'Learning\nModules',
                        color: WColors.indigo,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WStatChip(
                        value: '8',
                        label: 'Core\nSections',
                        color: WColors.teal,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WStatChip(
                        value: '∞',
                        label: 'Space for\nGrowth',
                        color: WColors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WStatChip(
                        value: '1',
                        label: 'Unified\nPlatform',
                        color: WColors.violet,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Core sections ─────────────────────────────────
            const SizedBox(height: 48),
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WSectionHeader(
                    eyebrow: 'What AIR Offers',
                    title: 'Everything you need,\none platform',
                    subtitle:
                        'Eight interconnected pillars that cover every dimension '
                        'of personal and collective growth in All-Space.',
                    accent: WColors.indigo,
                  ),
                  const SizedBox(height: 32),
                  WGrid(
                    children: [
                      WFeatureCard(
                        // routeName: WebRoutes.explore,
                        icon: Icons.lightbulb_outline,
                        title: 'Explore & Learn',
                        body:
                            'Curated learning docs, fun modules, higher studies, '
                            'doctorate tracks, and life hacks — all in one place.',
                        color: WColors.amber,
                      ),
                      WFeatureCard(
                        routeName: "", // WebRoutes.wisdom,
                        icon: Icons.gavel_rounded,
                        title: 'Rule & Wisdom',
                        body:
                            'Mazeasta — the governing layer of expert knowledge, '
                            'wisdom traditions, and informed rule-making.',
                        color: WColors.indigo,
                      ),
                      WFeatureCard(
                        // routeName:WebRoutes.profile,
                        icon: Icons.person_pin_rounded,
                        title: 'Be You & Earn',
                        body:
                            'Share your experience, record posts, and build your '
                            'identity while generating real living opportunities.',
                        color: WColors.emerald,
                      ),
                      WFeatureCard(
                        // routeName: WebRoutes.airVision,
                        icon: Icons.hub_rounded,
                        title: "AIR's Aspects",
                        body:
                            'Timeline, communication, beliefs, entertainment, '
                            'skills — the full cultural and operational fabric of AIR.',
                        color: WColors.violet,
                      ),
                      WFeatureCard(
                        // routeName: WebRoutes.setup,
                        icon: Icons.settings_suggest_rounded,
                        title: 'Setup A-One',
                        body:
                            'Digitalize records, ease tools, vocabulary, code of '
                            'conduct, and every resource to set up a flawless operation.',
                        color: WColors.teal,
                      ),
                      WFeatureCard(
                        // routeName: WebRoutes.v,
                        icon: Icons.favorite_rounded,
                        title: 'Human Values',
                        body:
                            'Kindness, respect, loyalty, empathy, affection — '
                            'the emotional and ethical backbone of All-Space.',
                        color: WColors.rose,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Call to action ─────────────────────────────────
            const SizedBox(height: 56),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D9488), Color(0xFF0284C7)],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  children: [
                    const Text(
                      'Ready to enter All-Space?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Join AIR and become part of the community that is '
                      'shaping the future of integrated living.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: WColors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Get Started — It\'s Free',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
