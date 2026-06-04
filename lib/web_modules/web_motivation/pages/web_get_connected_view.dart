import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_get_connected_controller.dart';

class WebGetConnectedView extends GetView<WebGetConnectedController> {
  const WebGetConnectedView({super.key});

  static const String routeName = '/web-motivation/get-connected';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFFD946EF); // Fuchsia from Motivation
    final isDesktop = WBreak.isDesktop(context);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFDF4FF),
        body: Column(
          children: [
            // ── HERO BANNER ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              decoration: BoxDecoration(
                color: isDark ? WColors.cardDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_rounded, color: primary),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Get Connected',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Find mentors, join cohorts, and build your network within the AIR ecosystem. Connect with Mazeasta and Alifiyas across the globe.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 48),
                        _buildStatBox('Active Mentors', '142', primary, isDark),
                        const SizedBox(width: 16),
                        _buildStatBox('Open Cohorts', '28', primary, isDark),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // ── NETWORK GRID ──
            Expanded(
              child: WMaxWidth(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilters(primary, isDark),
                      const SizedBox(height: 32),
                      Expanded(
                        child: SingleChildScrollView(
                          child: AnimationLimiter(
                            child: WGrid(
                              children: List.generate(
                                8,
                                (index) => AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  columnCount: 4,
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: _NetworkCard(index: index, primary: primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
    );
  }

  Widget _buildStatBox(String label, String value, Color primary, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: primary,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(Color primary, bool isDark) {
    final filters = ['All Groups', 'Mazeasta', 'Alifiyas', 'Project Leads', 'Alumni'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((filter) {
        return Obx(() {
          final active = controller.activeFilter.value == filter;
          return InkWell(
            onTap: () => controller.setFilter(filter),
            borderRadius: BorderRadius.circular(100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: active ? primary : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: active ? primary : (isDark ? Colors.white30 : Colors.black26),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: active ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                  fontWeight: active ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}

class _NetworkCard extends StatefulWidget {
  final int index;
  final Color primary;
  const _NetworkCard({required this.index, required this.primary});

  @override
  State<_NetworkCard> createState() => _NetworkCardState();
}

class _NetworkCardState extends State<_NetworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final roles = ['Mazeasta', 'Alifiyas', 'Lead Developer', 'UX Designer'];
    final role = roles[widget.index % roles.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.primary.withValues(alpha: 0.5) : (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.primary.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.primary.withValues(alpha: 0.1),
                  ),
                  child: Icon(Icons.person, size: 40, color: widget.primary),
                ),
                if (_isHovered)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'User ${widget.index + 100}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.primary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildTag('Flutter', widget.primary),
                _buildTag('Firebase', widget.primary),
                _buildTag('UI/UX', widget.primary),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: widget.primary,
                  side: BorderSide(color: widget.primary.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: const Text('Connect', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
