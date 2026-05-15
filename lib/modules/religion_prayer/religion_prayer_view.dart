import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'religion_prayer_controller.dart';

class ReligionPrayerView extends GetView<ReligionPrayerController> {
  const ReligionPrayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Religion & Prayer',
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
              ..._sections.map(
                (s) => _buildSection(context, s, isDark, onSurface),
              ),
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
          colors: [
            Colors.purple.withOpacity(0.15),
            Colors.deepPurpleAccent.withOpacity(0.05),
          ],
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
                child: const Icon(
                  Icons.auto_fix_high,
                  color: Colors.purple,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Religion & Prayer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Spiritual guidance and mindfulness',
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'We respect and provide resources for various spiritual beliefs. '
            'Find peace, mindfulness content, and prayer schedules here.',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withOpacity(0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _Section section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
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
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: onSurface,
            ),
          ),
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
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_Section> _sections = [
  _Section(
    title: 'Prayer Rooms & Sacred Spaces',
    icon: Icons.mosque,
    color: Colors.teal,
    points: [
      'Locations of designated prayer areas within AIR facilities, with quiet-hours policy and usage guidelines.',
      'Schedules for congregational times across different faith traditions — Friday Jumu\'ah, Sunday services, daily Namaz, and more.',
      'Booking system for private reflection time so individuals can reserve a quiet space without conflict.',
      'Interfaith etiquette guide so all users feel welcome regardless of their tradition or practice.',
    ],
  ),
  _Section(
    title: 'Mindfulness & Meditation',
    icon: Icons.self_improvement,
    color: Colors.purple,
    points: [
      'Guided meditation audio sessions ranging from 5 to 30 minutes — breath-focused, body-scan, and loving-kindness styles.',
      'Stress relief techniques drawn from evidence-based practices: progressive muscle relaxation, box breathing, and grounding.',
      'Quiet hours policy that protects designated reflection windows from meetings and notifications.',
      'Daily mindfulness prompts delivered gently at a time you choose — no pressure, just an invitation.',
    ],
  ),
  _Section(
    title: 'Spiritual Education',
    icon: Icons.book,
    color: Colors.indigo,
    points: [
      'Religious texts study groups covering the Quran, Bible, Bhagavad Gita, Torah, and other sacred scriptures.',
      'Philosophy workshops exploring ethics, meaning, and the examined life across traditions and secular thought.',
      'Ethical teachings series that bridges spiritual principles with everyday decisions in work and relationships.',
      'Reading lists curated by tradition so you can go deep into your own path or explore others respectfully.',
    ],
  ),
  _Section(
    title: 'Community Events',
    icon: Icons.people,
    color: Colors.pink,
    points: [
      'Spiritual gatherings and satsangs open to all — no prior knowledge or affiliation required to attend.',
      'Festival celebrations across traditions: Eid, Diwali, Christmas, Hanukkah, Baisakhi, and more.',
      'Interfaith dialogues where practitioners share their path and listen to others without debate or conversion intent.',
      'Annual day of service where the community comes together across faiths to give back to the wider world.',
    ],
  ),
  _Section(
    title: 'Personal Spiritual Growth',
    icon: Icons.psychology,
    color: Colors.amber,
    points: [
      'Inner peace cultivation practices — journaling prompts, gratitude rituals, and evening reflection routines.',
      'Virtue development tracks: patience, generosity, honesty, and compassion as daily practice, not just ideals.',
      'Spiritual mentorship matching — connect with a senior practitioner in your tradition for guided growth.',
      'Progress is personal here: no leaderboards, no comparisons — just your own quiet deepening over time.',
    ],
  ),
  _Section(
    title: 'Prayer for Specific Needs',
    icon: Icons.volunteer_activism_outlined,
    color: Colors.green,
    points: [
      'Healing prayers for those facing illness — submit a name and the community holds them in collective intention.',
      'Prayers for peace in conflict zones, offered weekly in a shared moment of silence across all traditions.',
      'Gratitude prayers to mark milestones — births, completions, recoveries, and new beginnings.',
      'Prayers for the departed, offered with dignity and respect for the grieving family\'s tradition.',
    ],
  ),
  _Section(
    title: 'Respectful Boundaries',
    icon: Icons.balance_outlined,
    color: Colors.blueGrey,
    points: [
      'All spiritual content is optional — no user is required to engage with any religious material.',
      'Proselytising and conversion attempts are not permitted in AIR spaces — share your path, don\'t push it.',
      'Respectful curiosity is encouraged; mockery or dismissal of any tradition is a conduct violation.',
      'Feedback channel for spiritual content so the community can flag anything that feels exclusionary or harmful.',
    ],
  ),
];
