// ============================================
// RESPONSIVE UNIVERSAL SETUP VIEW
// web_setup_aone_view.dart
// ============================================

import 'package:air_app/web_modules/_shared/web_nav_data.dart';
import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:air_app/web_modules/web_setup/pages/web_setup_master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebSetupMasterView extends GetView<WebSetupMasterController> {
  const WebSetupMasterView({super.key});
  static const String routeName = "/web-setup/setup_aone_master_view";

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return WebShell(
      currentRoute: routeName,
      child: SingleChildScrollView(
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: getContentListWidget(isMobile),
          ),
        ),
      ),
    );
  }

  List<Widget> getContentListWidget(bool isMobile) {
    final dataItem = controller.setupData;
    return ((dataItem.entries.map((MapEntry<String, Map<String, dynamic>> e) {
      final String title = e.key;
      final Map<String, dynamic> data = e.value;
      final Color color = data['color'];

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HERO SECTION
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: 50,
                  child: Icon(
                    data['icon'],
                    size: 260,
                    color: Colors.white.withOpacity(.08),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white.withOpacity(.15),
                        child: Icon(
                          data['icon'],
                          size: 42,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        data['title'],
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Universal Setup Architecture',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.85),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: isMobile
                ? Column(
                    children: [
                      // MAIN CONTENT
                      _buildMainContent(data: data, color: color),

                      const SizedBox(height: 24),

                      // SIDE CONTENT
                      _buildSidePanel(color),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildMainContent(data: data, color: color),
                      ),

                      const SizedBox(width: 24),

                      Expanded(child: _buildSidePanel(color)),
                    ],
                  ),
          ),
        ],
      );
    }).toList()));
  }

  // ==========================================
  // MAIN CONTENT
  // ==========================================

  Widget _buildMainContent({
    required Map<String, dynamic> data,
    required Color color,
  }) {
    return Column(
      children: [
        // FEATURES
        _buildGlassCard(
          color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Core Features',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              ...List.generate(data['features'].length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: color),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          data['features'][index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // OPERATIONAL LAYERS
        _buildGlassCard(
          color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Operational Layers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              ...List.generate(data['items'].length, (index) {
                final item = data['items'][index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.06),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['h'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              item['d'],
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SIDE PANEL
  // ==========================================

  Widget _buildSidePanel(Color color) {
    return Column(
      children: [
        _buildAnalyticsCard(color),

        const SizedBox(height: 24),

        _buildTimelineCard(color),

        const SizedBox(height: 24),

        _buildStatusCard(color),
      ],
    );
  }

  Widget _buildGlassCard(Color color, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: color.withOpacity(.12)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildAnalyticsCard(Color color) {
    return _buildGlassCard(
      color,
      child: Column(
        children: [
          Icon(Icons.analytics, size: 64, color: color),

          const SizedBox(height: 18),

          const Text(
            'Realtime Analytics',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),

          const SizedBox(height: 18),

          LinearProgressIndicator(
            value: .82,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(30),
          ),

          const SizedBox(height: 12),

          const Text('82% Symmetry Completion'),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(Color color) {
    return _buildGlassCard(
      color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),

          const SizedBox(height: 24),

          ...List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      'Phase ${index + 1} synchronized successfully.',
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatusCard(Color color) {
    return _buildGlassCard(
      color,
      child: Column(
        children: [
          Icon(Icons.verified, size: 72, color: color),

          const SizedBox(height: 18),

          const Text(
            'System Stable',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            'All neural synchronization layers are active and operating within acceptable thresholds.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade700, height: 1.5),
          ),
        ],
      ),
    );
  }
}
