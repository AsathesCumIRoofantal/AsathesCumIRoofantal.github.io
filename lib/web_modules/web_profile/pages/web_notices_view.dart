import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_notices_controller.dart';

class WebNoticesView extends GetView<WebNoticesController> {
  static const routeName = '/web-profile/notices';
  const WebNoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF7C3AED);
    final secondaryColor = const Color(0xFF4C1D95);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF8FAFC),
        body: CustomScrollView(
          slivers: [
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
                  'Announcement Center',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
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
                    child:
                        Icon(
                              Icons.notifications_active_rounded,
                              size: 120,
                              color: Colors.white.withOpacity(0.2),
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .shake(duration: const Duration(seconds: 1), hz: 5),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _FilterHeaderDelegate(
                onFilterSelected: (val) => controller.setCategory(val),
                selectedCategory: controller.selectedCategory,
                isDark: isDark,
              ),
            ),
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
                        'Real-time Push Sync',
                        'Notices arrive via binary-stream sockets for zero-latency delivery.',
                      ),
                      _buildFeatureRow(
                        'Semantic Grouping',
                        'AI automatically groups notices by urgency and topic relevance.',
                      ),
                      _buildFeatureRow(
                        'Temporal Color-Sensing',
                        'Card borders shift color based on the time-decay of the notice.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final notice = controller.filteredNotices[index];
                  return _NoticeCard(notice: notice, isDark: isDark);
                }, childCount: controller.filteredNotices.length),
              ),
            ),
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

class _NoticeCard extends StatelessWidget {
  final Map<String, dynamic> notice;
  final bool isDark;
  const _NoticeCard({required this.notice, required this.isDark});

  Color _getPriorityColor() {
    switch (notice['priority']) {
      case 'Critical':
        return const Color(0xFFEF4444);
      case 'High':
        return const Color(0xFFF59E0B);
      case 'Medium':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF10B981);
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: priorityColor.withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: priorityColor.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!notice['isRead'])
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: priorityColor,
                shape: BoxShape.circle,
              ),
            ),
          if (!notice['isRead']) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notice['category'],
                      style: TextStyle(
                        color: priorityColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      notice['date'],
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  notice['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notice['content'],
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.1);
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function(String) onFilterSelected;
  final RxString selectedCategory;
  final bool isDark;

  _FilterHeaderDelegate({
    required this.onFilterSelected,
    required this.selectedCategory,
    required this.isDark,
  });

  @override
  Widget build(context, shrinkOffset, constraints) {
    final categories = ['All', 'Update', 'Event', 'Security', 'Achievement'];
    return Container(
      color: isDark ? WColors.surfaceDark : const Color(0xFFF8FA),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories
            .map(
              (cat) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: selectedCategory.value == cat,
                  onSelected: (_) => onFilterSelected(cat),
                  selectedColor: const Color(0xFF7C3AED),
                  labelStyle: TextStyle(
                    color: selectedCategory.value == cat
                        ? Colors.white
                        : (isDark ? Colors.white : Colors.black),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  double get maxExtent => 200;
  @override
  double get minExtent => 200;
  @override
  bool shouldRebuild(covariant _FilterHeaderDelegate oldDelegate) => true;
}
