// ============================================================
// web_modules/web_profile_page.dart
// Route: /web-profile  →  WebProfilePage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebProfilePage extends StatefulWidget {
  const WebProfilePage({super.key});

  static const String routeName = '/web-profile';

  @override
  State<WebProfilePage> createState() => _WebProfilePageState();
}

class _WebProfilePageState extends State<WebProfilePage> {
  int _selected = 0;

  static const _tabs = [
    'Overview',
    'Achievements',
    'Business',
    'Rewards',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'PROFILE', color: WColors.emerald),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile hero
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF064E3B), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: WMaxWidth(
                child: WBreak.isMobile(context)
                    ? _profileInfoMobile()
                    : _profileInfoDesktop(),
              ),
            ),

            // Tabs
            Container(
              color: isDark ? WColors.cardDark : Colors.white,
              child: WMaxWidth(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final sel = i == _selected;
                      return GestureDetector(
                        onTap: () => setState(() => _selected = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: sel
                                    ? WColors.emerald
                                    : Colors.transparent,
                                width: 2.5,
                              ),
                            ),
                          ),
                          child: Text(
                            _tabs[i],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: sel
                                  ? WColors.emerald
                                  : (isDark
                                      ? Colors.white54
                                      : Colors.black45),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Tab content
            WMaxWidth(child: _buildTab(isDark)),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _profileInfoMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(),
        const SizedBox(height: 16),
        ..._profileText(),
      ],
    );
  }

  Widget _profileInfoDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _avatar(),
        const SizedBox(width: 28),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: _profileText())),
      ],
    );
  }

  Widget _avatar() {
    return CircleAvatar(
      radius: 44,
      backgroundColor: Colors.white.withValues(alpha: 0.2),
      child: const Icon(Icons.person_rounded, color: Colors.white, size: 48),
    );
  }

  List<Widget> _profileText() {
    return [
      const Text('Alifiyas Member',
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      Text('AsathesCumIRoofantal · All-Space',
          style:
              TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          WBadge(label: 'Verified Identity', color: Colors.white),
          WBadge(label: 'Level 4', color: Colors.white),
          WBadge(label: 'Explorer', color: Colors.white),
        ],
      ),
    ];
  }

  Widget _buildTab(bool isDark) {
    switch (_selected) {
      case 0:
        return _overview(isDark);
      case 1:
        return _achievements(isDark);
      case 2:
        return _business(isDark);
      case 3:
        return _rewards(isDark);
      default:
        return const SizedBox();
    }
  }

  Widget _overview(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Profile Overview',
          title: 'Your All-Space Presence',
          accent: WColors.emerald,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: WStatChip(value: '42', label: 'Modules\nVisited', color: WColors.emerald)),
            const SizedBox(width: 12),
            Expanded(child: WStatChip(value: '12', label: 'Items\nPosted', color: WColors.teal)),
            const SizedBox(width: 12),
            Expanded(child: WStatChip(value: '830', label: 'Space\nCredits', color: WColors.amber)),
          ],
        ),
        const SizedBox(height: 28),
        WGrid(
          forceColumns: WBreak.isMobile(context) ? 1 : 2,
          children: [
            WFeatureCard(
                icon: Icons.event_rounded,
                title: 'Events',
                body: 'View upcoming and past events on your profile timeline.',
                color: WColors.indigo),
            WFeatureCard(
                icon: Icons.notifications_active_rounded,
                title: 'Notices',
                body: 'Important announcements and governance notices addressed to you.',
                color: WColors.rose),
            WFeatureCard(
                icon: Icons.track_changes_rounded,
                title: 'Tracks & Traces',
                body: 'A full audit log of your activity and contributions.',
                color: WColors.teal),
            WFeatureCard(
                icon: Icons.lock_rounded,
                title: 'Private / Confidential',
                body: 'Manage what is visible to others and what remains yours alone.',
                color: WColors.violet),
          ],
        ),
      ],
    );
  }

  Widget _achievements(bool isDark) {
    final items = [
      _Ach(Icons.stars_rounded, 'First Query Posted', '3 days ago', WColors.amber),
      _Ach(Icons.bolt_rounded, 'Spatial Entropy Certified', '1 week ago', WColors.violet),
      _Ach(Icons.explore_rounded, 'Explorer Badge Earned', '2 weeks ago', WColors.teal),
      _Ach(Icons.school_rounded, 'Higher Studies Module Complete', '1 month ago', WColors.indigo),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Your Milestones',
          title: 'Achievements',
          accent: WColors.emerald,
        ),
        const SizedBox(height: 24),
        ...items.map((a) => _AchTile(a: a, isDark: isDark)),
      ],
    );
  }

  Widget _business(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Entrepreneurship',
          title: 'Your Business in All-Space',
          subtitle: 'Connect, manage, and grow your business entity within AIR.',
          accent: WColors.emerald,
        ),
        const SizedBox(height: 24),
        WGrid(
          children: [
            WFeatureCard(icon: Icons.storefront_rounded, title: 'Products & Services', body: 'List what you offer and let the AIR community discover you.', color: WColors.emerald),
            WFeatureCard(icon: Icons.analytics_rounded, title: 'Managements', body: 'Track operational metrics, team structure, and outputs.', color: WColors.indigo),
            WFeatureCard(icon: Icons.build_rounded, title: 'Maintenance', body: 'Schedule, log, and delegate operational maintenance tasks.', color: WColors.teal),
            WFeatureCard(icon: Icons.api_rounded, title: 'Network & APIs', body: 'Connect your systems to All-Space through the AIR API layer.', color: WColors.violet),
          ],
        ),
      ],
    );
  }

  Widget _rewards(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Incentives',
          title: 'Rewards & Credits',
          subtitle: 'Earn, redeem, and share value within All-Space.',
          accent: WColors.emerald,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [WColors.amber.withValues(alpha: 0.1), WColors.emerald.withValues(alpha: 0.05)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: WColors.amber.withValues(alpha: 0.25)),
          ),
          child: Column(
            children: [
              const Icon(Icons.wallet_rounded, color: WColors.amber, size: 40),
              const SizedBox(height: 12),
              Text('830 Credits',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: isDark ? WColors.amber : const Color(0xFF92400E))),
              const SizedBox(height: 4),
              Text('Available to redeem',
                  style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.black45,
                      fontSize: 13)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: WColors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 13),
                ),
                child: const Text('Redeem Credits',
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Ach {
  final IconData icon;
  final String title;
  final String when;
  final Color color;
  const _Ach(this.icon, this.title, this.when, this.color);
}

class _AchTile extends StatelessWidget {
  final _Ach a;
  final bool isDark;
  const _AchTile({required this.a, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : WColors.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: a.color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: a.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(a.icon, color: a.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A))),
                Text(a.when,
                    style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.black38)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: isDark ? Colors.white24 : Colors.black26),
        ],
      ),
    );
  }
}
