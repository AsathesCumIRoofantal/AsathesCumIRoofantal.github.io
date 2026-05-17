import 'package:air_app/modules/leadership/leadership_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Tab Navigation design wrapper for Leadership module
/// Features: Tab-based navigation, organized content sections, clear hierarchies
class LeadershipBestView extends StatefulWidget {
  const LeadershipBestView({super.key});

  @override
  State<LeadershipBestView> createState() => _LeadershipBestViewState();
}

class _LeadershipBestViewState extends State<LeadershipBestView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const leaderColor = Color(0xff1e88e5);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _TabHeader(isDark: isDark),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: isDark ? const Color(0xff1a1a1a) : Colors.white,
              child: Column(
                children: [
                  Container(
                    color: isDark
                        ? const Color(0xff252525)
                        : Colors.grey.shade50,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: leaderColor,
                      unselectedLabelColor: isDark
                          ? Colors.white60
                          : Colors.black54,
                      indicatorColor: leaderColor,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                      tabs: const [
                        Tab(text: 'OVERVIEW'),
                        Tab(text: 'QUALITIES'),
                        Tab(text: 'PRACTICES'),
                        Tab(text: 'IMPACT'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 800,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _OverviewTab(isDark: isDark),
                        _QualitiesTab(isDark: isDark),
                        _PracticesTab(isDark: isDark),
                        _ImpactTab(isDark: isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const LeadershipEnhancedView()),
        ],
      ),
    );
  }
}

class _TabHeader extends StatelessWidget {
  final bool isDark;
  const _TabHeader({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xff1e88e5).withValues(alpha: 0.08),
                const Color(0xff1565c0).withValues(alpha: 0.05),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff1e88e5).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xff1e88e5).withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: Color(0xff1e88e5),
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Leadership'.toUpperCase(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tab Navigation Design',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewTab extends StatelessWidget {
  final bool isDark;
  const _OverviewTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is Leadership?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Leadership is the ability to guide, inspire, and empower others toward a shared vision. It\'s not about authority—it\'s about influence and integrity.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            _TabCard(
              isDark: isDark,
              title: 'The Core',
              items: [
                'Vision & Purpose',
                'Integrity & Trust',
                'Empathy & Connection',
                'Continuous Growth',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QualitiesTab extends StatelessWidget {
  final bool isDark;
  const _QualitiesTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Essential Qualities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...[
              ('Visionary', 'See beyond today into tomorrow'),
              ('Communicator', 'Express clearly and listen deeply'),
              ('Courageous', 'Make difficult decisions with conviction'),
              ('Humble', 'Know your limits and learn continuously'),
              ('Ethical', 'Do right, not just what\'s easy'),
            ].map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _QualityItem(
                  title: item.$1,
                  description: item.$2,
                  isDark: isDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticesTab extends StatelessWidget {
  final bool isDark;
  const _PracticesTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Practices',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _TabCard(
              isDark: isDark,
              title: 'Develop Leadership',
              items: [
                'Reflect on your decisions daily',
                'Seek feedback from your team',
                'Mentor someone younger',
                'Read and learn constantly',
                'Lead by example',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactTab extends StatelessWidget {
  final bool isDark;
  const _ImpactTab({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Creating Impact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'True leadership creates ripples of positive change. Your actions inspire others to lead too.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            _TabCard(
              isDark: isDark,
              title: 'Measure Your Impact',
              items: [
                'Team growth & development',
                'Organizational culture',
                'Results & achievements',
                'Lives touched & inspired',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final List<String> items;
  const _TabCard({
    required this.isDark,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.blue.shade400,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QualityItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isDark;
  const _QualityItem({
    required this.title,
    required this.description,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff1e88e5).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: const Color(0xff1e88e5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
