import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_tracks_and_traces_controller.dart';

class WebTracksAndTracesView extends GetView<WebTracksAndTracesController> {
  const WebTracksAndTracesView({super.key});

  static const String routeName = '/web-profile/tracks-and-traces';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF7C3AED); // Purple from Profile section
    final isDesktop = WBreak.isDesktop(context);

    // Terminal-like background for the audit console
    final bgColor = isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC);
    final cardColor = isDark ? const Color(0xFF0F172A) : Colors.white;

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            // ── CONSOLE HEADER ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              decoration: BoxDecoration(
                color: cardColor,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: primary),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primary.withValues(alpha: 0.3)),
                    ),
                    child: Icon(Icons.track_changes, color: primary),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tracks & Traces',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'System Audit Active',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: isDark ? Colors.greenAccent : Colors.green,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (isDesktop) _buildFilters(primary, isDark),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Export Logs', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // ── CONSOLE TABLE ──
            Expanded(
              child: WMaxWidth(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Table Header
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
                          border: Border(
                            bottom: BorderSide(
                              color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildHeaderCell('TIMESTAMP', flex: 2, isDark: isDark),
                            _buildHeaderCell('USER/ACTOR', flex: 2, isDark: isDark),
                            _buildHeaderCell('EVENT TYPE', flex: 2, isDark: isDark),
                            _buildHeaderCell('RESOURCE / DETAILS', flex: 4, isDark: isDark),
                            _buildHeaderCell('STATUS', flex: 1, isDark: isDark),
                          ],
                        ),
                      ),
                      
                      // Table Body
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: 12,
                          separatorBuilder: (context, index) => Divider(
                            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                verticalOffset: 20.0,
                                child: FadeInAnimation(
                                  child: _buildLogDataRow(index, isDark, primary),
                                ),
                              ),
                            );
                          },
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

  Widget _buildFilters(Color primary, bool isDark) {
    final tabs = ['All Logs', 'Security', 'Access', 'System'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: tabs.map((tab) {
          return Obx(() {
            final active = controller.activeTab.value == tab;
            return InkWell(
              onTap: () => controller.setTab(tab),
              borderRadius: BorderRadius.circular(6),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: active ? (isDark ? WColors.cardDark : Colors.white) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    if (active)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                      ),
                  ],
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                    color: active ? primary : (isDark ? Colors.white54 : Colors.black54),
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required int flex, required bool isDark}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white54 : Colors.black45,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildLogDataRow(int index, bool isDark, Color primary) {
    final actions = ['LOGIN_ATTEMPT', 'DATA_EXPORT', 'PERMISSION_CHANGE', 'RESOURCE_ACCESS'];
    final actors = ['admin@air.org', 'system_cron', 'user_7482', 'API_KEY_09X'];
    final statuses = ['SUCCESS', 'FAILED', 'WARNING', 'SUCCESS'];
    final statusColors = [Colors.green, Colors.red, Colors.orange, Colors.green];
    
    final i = index % 4;
    final status = statuses[i];
    final color = statusColors[i];

    return InkWell(
      onHover: (hovered) {}, // Add hover state if needed
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // Timestamp
            Expanded(
              flex: 2,
              child: Text(
                '2026-05-19 14:${10 + index}:42 UTC',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            // Actor
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(
                    actors[i].contains('@') ? Icons.person_outline : Icons.computer,
                    size: 16,
                    color: primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    actors[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // Event Type
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    actions[i],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            // Details
            Expanded(
              flex: 4,
              child: Text(
                'Accessed restricted payload /api/v2/module_data. Requested by active session token.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            // Status
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: color,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
