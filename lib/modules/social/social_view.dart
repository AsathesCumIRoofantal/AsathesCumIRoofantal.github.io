import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'social_controller.dart';

class SocialView extends GetView<SocialController> {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Social',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
                : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._socialSections.map((s) => _buildSection(context, s, isDark, onSurface)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.withOpacity(0.15), Colors.pink.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.purple.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.social_distance, color: Colors.purple, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Social',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurface)),
                    const SizedBox(height: 4),
                    Text('Connect, share, and engage',
                        style: TextStyle(fontSize: 13, color: onSurface.withOpacity(0.6))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Explore our community features designed to bring people together. '
            'Engage in meaningful conversations, share experiences, and build '
            'lasting relationships within our vibrant network.',
            style: TextStyle(fontSize: 14, color: onSurface.withOpacity(0.75), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, _SocialSection section, bool isDark, Color onSurface) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor.withOpacity(0.35) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
        boxShadow: isDark
            ? []
            : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(section.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: onSurface)),
          iconColor: onSurface.withOpacity(0.5),
          collapsedIconColor: onSurface.withOpacity(0.4),
          children: section.points
              .map((p) => _buildPoint(p, onSurface, section.color))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPoint(String point, Color onSurface, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(point,
                style: TextStyle(fontSize: 14, color: onSurface.withOpacity(0.75), height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _SocialSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _SocialSection({required this.title, required this.icon, required this.color, required this.points});
}

final List<_SocialSection> _socialSections = [
  _SocialSection(
    title: 'Community Forums',
    icon: Icons.forum_outlined,
    color: Colors.purple,
    points: [
      'Join topic-based discussion boards.',
      'Ask questions and get answers from experts.',
      'Share your knowledge with the community.',
    ],
  ),
  _SocialSection(
    title: 'Events & Meetups',
    icon: Icons.event_available_outlined,
    color: Colors.pink,
    points: [
      'Discover upcoming local and virtual events.',
      'RSVP and manage your event calendar.',
      'Host your own gatherings and invite others.',
    ],
  ),
  _SocialSection(
    title: 'Direct Messaging',
    icon: Icons.chat_bubble_outline,
    color: Colors.blue,
    points: [
      'Chat privately with connections.',
      'Create group chats for team collaboration.',
      'Share files and media securely.',
    ],
  ),
  _SocialSection(
    title: 'Content Feed',
    icon: Icons.dynamic_feed_outlined,
    color: Colors.deepOrange,
    points: [
      'Stay updated with personalized content.',
      'Like, comment, and share posts.',
      'Discover trending topics and creators.',
    ],
  ),
];
