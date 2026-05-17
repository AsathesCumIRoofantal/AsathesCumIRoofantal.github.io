// ============================================================
// web_modules/web_community_page.dart
// Route: /web-community  →  WebCommunityPage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebCommunityPage extends StatefulWidget {
  const WebCommunityPage({super.key});

  static const String routeName = '/web-community';

  @override
  State<WebCommunityPage> createState() => _WebCommunityPageState();
}

class _WebCommunityPageState extends State<WebCommunityPage> {
  int _tab = 0;

  static final _discussions = [
    _Post(
      title: 'Understanding the Limit (0 or 1) principle in All-Space',
      author: 'Member#0042',
      replies: 14,
      views: 320,
      tag: 'AIR Aspects',
      color: WColors.violet,
      time: '2h ago',
    ),
    _Post(
      title: 'Best practices for Timeline of AIR documentation?',
      author: 'Member#0117',
      replies: 8,
      views: 176,
      tag: 'Timeline',
      color: WColors.teal,
      time: '5h ago',
    ),
    _Post(
      title: 'How do Entities differ from Unions in practical terms?',
      author: 'Member#0288',
      replies: 22,
      views: 540,
      tag: 'Foundations',
      color: WColors.indigo,
      time: '1d ago',
    ),
    _Post(
      title: 'Feedback on new Commerce module navigation flow',
      author: 'Member#0391',
      replies: 6,
      views: 98,
      tag: 'Feedback',
      color: WColors.amber,
      time: '2d ago',
    ),
    _Post(
      title: 'Group study: Beliefs & Values module — week 3 notes',
      author: 'Member#0055',
      replies: 31,
      views: 612,
      tag: 'Group Study',
      color: WColors.emerald,
      time: '3d ago',
    ),
  ];

  static final _events = [
    _Event('AIR Open Day — Q3', 'A live walkthrough of every new module added this quarter.', '28 May 2026', WColors.indigo, Icons.celebration_rounded),
    _Event('Wisdom Deep-Dive Workshop', 'Three-hour guided session on the four pillars of knowing.', '4 Jun 2026', WColors.violet, Icons.school_rounded),
    _Event('Community Governance Vote', 'Cast your vote on the proposed Limits (0–1) clarification.', '10 Jun 2026', WColors.rose, Icons.how_to_vote_rounded),
    _Event('Creator Showcase', 'Members present their best content contributions of the month.', '17 Jun 2026', WColors.amber, Icons.star_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'COMMUNITY', color: WColors.teal),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WHeroBanner(
              title: 'Connect. Discuss. Grow Together.',
              subtitle:
                  'The AIR community is the living pulse of All-Space — '
                  'questions answered, ideas debated, and events celebrated.',
              colorA: const Color(0xFF134E4A),
              colorB: const Color(0xFF0D9488),
              icon: Icons.groups_2_rounded,
            ),

            const SizedBox(height: 32),

            // Tab switcher
            WMaxWidth(
              child: Row(
                children: [
                  _TabBtn(label: 'Discussions', selected: _tab == 0, onTap: () => setState(() => _tab = 0), color: WColors.teal),
                  const SizedBox(width: 8),
                  _TabBtn(label: 'Events', selected: _tab == 1, onTap: () => setState(() => _tab = 1), color: WColors.teal),
                  const SizedBox(width: 8),
                  _TabBtn(label: 'Connect', selected: _tab == 2, onTap: () => setState(() => _tab = 2), color: WColors.teal),
                ],
              ),
            ),

            const SizedBox(height: 24),

            WMaxWidth(child: _buildTab(isDark)),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(bool isDark) {
    switch (_tab) {
      case 0:
        return _discussions_(isDark);
      case 1:
        return _events_(isDark);
      default:
        return _connect_(isDark);
    }
  }

  Widget _discussions_(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: WSectionHeader(
                eyebrow: 'Forum',
                title: 'Active Discussions',
                accent: WColors.teal,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: WColors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('New Post'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ..._discussions.map((p) => _PostTile(p: p, isDark: isDark)),
      ],
    );
  }

  Widget _events_(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Calendar',
          title: 'Upcoming Events',
          accent: WColors.teal,
        ),
        const SizedBox(height: 20),
        WGrid(
          forceColumns: WBreak.isMobile(context) ? 1 : 2,
          children: _events.map((e) => _EventCard(e: e, isDark: isDark)).toList(),
        ),
      ],
    );
  }

  Widget _connect_(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WSectionHeader(
          eyebrow: 'Network',
          title: 'Connect & Collaborate',
          subtitle: 'Find people whose goals align with yours in All-Space.',
          accent: WColors.teal,
        ),
        const SizedBox(height: 24),
        WGrid(
          children: const [
            WFeatureCard(icon: Icons.person_search_rounded, title: 'Find Members', body: 'Search for individuals by skill, module interest, or location within All-Space.', color: WColors.teal),
            WFeatureCard(icon: Icons.handshake_rounded, title: 'Collaboration Boards', body: 'Post what you need, offer what you have — project boards for real All-Space work.', color: WColors.indigo),
            WFeatureCard(icon: Icons.record_voice_over_rounded, title: 'Group Discussions', body: 'Join moderated groups focused on specific topics, regions, or AIR modules.', color: WColors.violet),
            WFeatureCard(icon: Icons.forum_rounded, title: 'Engagement Feeds', body: 'Stay updated with activity across your network — contributions, achievements, and posts.', color: WColors.amber),
          ],
        ),
      ],
    );
  }
}

// ── Data & widgets ────────────────────────────────────────────
class _TabBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  const _TabBtn({required this.label, required this.selected, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : (isDark ? WColors.cardDark : Colors.white),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? color : color.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : color,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _Post {
  final String title, author, tag, time;
  final int replies, views;
  final Color color;
  const _Post({
    required this.title, required this.author, required this.tag,
    required this.time, required this.replies, required this.views, required this.color,
  });
}

class _PostTile extends StatelessWidget {
  final _Post p;
  final bool isDark;
  const _PostTile({required this.p, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : WColors.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WBadge(label: p.tag, color: p.color),
              const Spacer(),
              Text(p.time, style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : Colors.black38)),
            ],
          ),
          const SizedBox(height: 8),
          Text(p.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5, color: isDark ? Colors.white : const Color(0xFF0F172A), height: 1.35)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person_rounded, size: 13, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text(p.author, style: TextStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.black38)),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline_rounded, size: 13, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text('${p.replies}', style: TextStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.black38)),
              const SizedBox(width: 12),
              Icon(Icons.visibility_outlined, size: 13, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text('${p.views}', style: TextStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.black38)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Event {
  final String title, desc, date;
  final Color color;
  final IconData icon;
  const _Event(this.title, this.desc, this.date, this.color, this.icon);
}

class _EventCard extends StatelessWidget {
  final _Event e;
  final bool isDark;
  const _EventCard({required this.e, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : WColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: e.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: e.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(e.icon, color: e.color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(child: WBadge(label: e.date, color: e.color)),
            ],
          ),
          const SizedBox(height: 12),
          Text(e.title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: isDark ? Colors.white : const Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Text(e.desc, style: TextStyle(fontSize: 13, height: 1.5, color: isDark ? Colors.white54 : Colors.black54)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: e.color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 38),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Register', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
