import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:air_app/web_modules/_shared/web_nav_data.dart';
import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:air_app/web_modules/web_home/agora_rtc_controller_design1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AgoraViewDesign1 extends GetView<AgoraRtcControllerDesign1> {
  const AgoraViewDesign1({super.key});

  static const String routeName = WebNavData.homeAgoraRoute;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey[950] : Colors.grey[50],
        appBar: AppBar(
          title: const Text('Next-Gen AI RTC Dashboard'),
          actions: [
            // Status Indicator for AI Copilot / Cloud Transcription Engine
            Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: controller.isAiTranscribing.value
                      ? Colors.green.withAlpha(30)
                      : Colors.amber.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: controller.isAiTranscribing.value
                        ? Colors.green
                        : Colors.amber,
                  ),
                ),
                child: Center(
                  child: Text(
                    controller.isAiTranscribing.value
                        ? '● AI Live Captions Active'
                        : '○ AI Subtitles Idle',
                    style: TextStyle(
                      color: controller.isAiTranscribing.value
                          ? Colors.greenAccent
                          : Colors.amber[800],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1100;

            return Row(
              children: [
                // 1. MAIN FEED AREA (Left side)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Core Video Streams Grid
                        Expanded(
                          child: Obx(() {
                            final totalFeeds =
                                1 + controller.remoteUsers.length;
                            int crossAxisCount = isDesktop
                                ? 3
                                : (constraints.maxWidth > 700 ? 2 : 1);

                            return GridView.builder(
                              itemCount: totalFeeds,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                    childAspectRatio: 16 / 10,
                                  ),
                              itemBuilder: (_, index) =>
                                  _buildVideoTile(index, isDark),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        // Real-time Dashboard Controls Bar
                        _buildDynamicControlPanel(context),
                      ],
                    ),
                  ),
                ),

                // 2. LIVE AI SUBTITLES & CHAT SIDEBAR (Right side on Desktop Layouts)
                if (isDesktop)
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: isDark ? Colors.grey[850]! : Colors.grey[200]!,
                        ),
                      ),
                      color: isDark ? Colors.grey[900] : Colors.white,
                    ),
                    child: _buildSidebarPanel(isDark),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Individual Video Tile Builder with Built-in Overlays
  Widget _buildVideoTile(int index, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        color: isDark ? Colors.black : Colors.grey[300],
        child: Stack(
          children: [
            // Agora Video Track Render Canvas
            Positioned.fill(
              child: AgoraVideoView(
                controller: index == 0
                    ? VideoViewController(
                        rtcEngine: controller.engine,
                        canvas: const VideoCanvas(uid: 0),
                      )
                    : VideoViewController.remote(
                        rtcEngine: controller.engine,
                        canvas: VideoCanvas(
                          uid: controller.remoteUsers[index - 1],
                        ),
                        connection: RtcConnection(
                          channelId: controller.channelId,
                        ),
                      ),
              ),
            ),

            // Dynamic User Profile Label & Stream Quality Metrics Badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      index == 0 ? Icons.person : Icons.supervised_user_circle,
                      color: Colors.blue,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      index == 0
                          ? 'Local Host (You)'
                          : 'Client: \${controller.remoteUsers[index - 1]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Video Action Control Bar Overlay (Mute specific tracks / Pin Video)
            Positioned(
              bottom: 12,
              right: 12,
              child: Row(
                children: [
                  _buildMiniOverlayButton(Icons.volume_up, () {}),
                  const SizedBox(width: 8),
                  _buildMiniOverlayButton(Icons.fullscreen, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 250.ms).scale(begin: const Offset(0.98, 0.98));
  }

  // Interactive Live Call Stream Operations Panel
  Widget _buildDynamicControlPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Audio Toggle Action
            _buildActionButton(
              icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
              color: controller.isMuted.value ? Colors.red : Colors.blue,
              onTap: () => controller.toggleMute(),
            ),
            const SizedBox(width: 16),
            // Video Camera Track Toggle Action
            _buildActionButton(
              icon: controller.isVideoDisabled.value
                  ? Icons.videocam_off
                  : Icons.videocam,
              color: controller.isVideoDisabled.value
                  ? Colors.red
                  : Colors.blue,
              onTap: () => controller.toggleVideo(),
            ),
            const SizedBox(width: 16),
            // Screen Sharing Stream Pipeline Engine
            _buildActionButton(
              icon: controller.isScreenSharing.value
                  ? Icons.stop_screen_share
                  : Icons.screen_share,
              color: controller.isScreenSharing.value
                  ? Colors.deepPurple
                  : Colors.grey[600]!,
              onTap: () => controller.toggleScreenShare(),
            ),
            const SizedBox(width: 16),
            // Virtual Background Preset Engine Configuration
            _buildActionButton(
              icon: controller.isVirtualBgActive.value
                  ? Icons.blur_on
                  : Icons.blur_off,
              color: controller.isVirtualBgActive.value
                  ? Colors.teal
                  : Colors.grey[600]!,
              onTap: () => controller.toggleVirtualBackground(),
            ),
            const SizedBox(width: 24),
            // Terminate Connection Button
            _buildActionButton(
              icon: Icons.call_end,
              color: Colors.red[700]!,
              onTap: () => controller.leaveStreamChannel(),
            ),
          ],
        ),
      ),
    );
  }

  // Sidebar for AI Live Translations and Real-Time Chat Transcription Logs
  Widget _buildSidebarPanel(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.psychology, color: Colors.purple[400]),
              const SizedBox(width: 8),
              const Text(
                'AI Copilot Logs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.transcriptionLines.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.transcriptionLines[index],
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 200.ms).fade();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniOverlayButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
