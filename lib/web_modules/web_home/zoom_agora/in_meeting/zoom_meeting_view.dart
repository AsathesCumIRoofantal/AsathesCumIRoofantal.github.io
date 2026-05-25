import 'package:air_app/web_modules/_shared/web_nav_data.dart';
import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:air_app/web_modules/web_home/zoom_agora/zoom_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
import 'chat_panel.dart';
import 'participants_panel.dart';
import 'reactions_bar.dart';
import 'captions_overlay.dart';
import 'breakout_panel.dart';
import 'polls_panel.dart';
import 'qa_panel.dart';
import 'stats_panel.dart';
import 'screen_share_picker.dart';
import 'virtual_bg_picker.dart';
import 'whiteboard_view.dart';
import 'annotation_layer.dart';
import '../widgets/reconnect_banner.dart';
import '../widgets/reaction_overlay.dart';
import '../widgets/shortcuts_overlay.dart';

/// Drop-in container that hosts your existing AgoraView body alongside every
/// Zoom-parity panel. Replace `_VideoArea` with your real `AgoraView`.
class ZoomMeetingView extends GetView<ZoomMeetingController> {
  const ZoomMeetingView({super.key});
  static const String routeName = ZoomRoutes.inMeeting;
  @override
  Widget build(BuildContext c) {
    final pane = 'none'
        .obs; // chat | people | breakout | polls | qa | stats | whiteboard
    return WebShell(
      currentRoute: routeName,
      child: ShortcutsOverlay(
        child: Scaffold(
          backgroundColor: const Color(0xFF1C1C1E),
          body: Column(
            children: [
              const ReconnectBanner(),
              Expanded(
                child: Row(
                  children: [
                    // ── main stage ─────────────────────────────────────────────────
                    Expanded(
                      child: Stack(
                        children: const [
                          _VideoArea(),
                          CaptionsOverlay(),
                          ReactionOverlay(),
                          // AnnotationLayer(),  // enable when annotating shared screen
                        ],
                      ),
                    ),
                    // ── right pane ─────────────────────────────────────────────────
                    Obx(
                      () => switch (pane.value) {
                        'chat' => const ChatPanel(),
                        'people' => const ParticipantsPanel(),
                        'breakout' => const BreakoutPanel(),
                        'polls' => const PollsPanel(),
                        'qa' => const QAPanel(),
                        'stats' => const StatsPanel(),
                        'whiteboard' => const SizedBox(
                          width: 600,
                          child: WhiteboardView(),
                        ),
                        _ => const SizedBox.shrink(),
                      },
                    ),
                  ],
                ),
              ),
              // ── bottom toolbar ──────────────────────────────────────────────
              Container(
                color: const Color(0xFF2C2C2E),
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.white),
                      onPressed: () {
                        /*toggle mic*/
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.white),
                      onPressed: () {
                        /*toggle cam*/
                      },
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.screen_share),
                      label: const Text('Share'),
                      onPressed: () async {
                        await Get.dialog(const ScreenSharePicker());
                      },
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.brush),
                      label: const Text('Effects'),
                      onPressed: () async {
                        await Get.dialog(const VirtualBgPicker());
                      },
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.front_hand),
                      label: const Text('Hand'),
                      onPressed: () => controller.react(0, '🙋'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.closed_caption),
                      label: const Text('CC'),
                      onPressed: controller.toggleCaptions,
                    ),
                    FilledButton.icon(
                      icon: const Icon(
                        Icons.fiber_manual_record,
                        color: Colors.red,
                      ),
                      label: const Text('Rec'),
                      onPressed: controller.startCloudRecording,
                    ),
                    const ReactionsBar(),
                    FilledButton.icon(
                      icon: const Icon(Icons.chat),
                      label: const Text('Chat'),
                      onPressed: () => pane.value = 'chat',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.people),
                      label: const Text('People'),
                      onPressed: () => pane.value = 'people',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.meeting_room),
                      label: const Text('Breakouts'),
                      onPressed: () => pane.value = 'breakout',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.poll),
                      label: const Text('Polls'),
                      onPressed: () => pane.value = 'polls',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Q&A'),
                      onPressed: () => pane.value = 'qa',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.bar_chart),
                      label: const Text('Stats'),
                      onPressed: () => pane.value = 'stats',
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.dashboard),
                      label: const Text('Whiteboard'),
                      onPressed: () => pane.value = 'whiteboard',
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      icon: const Icon(Icons.call_end),
                      label: const Text('End'),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Replace this with your existing AgoraView body (the gallery/speaker grid).
class _VideoArea extends StatelessWidget {
  const _VideoArea();
  @override
  Widget build(BuildContext c) => Container(
    color: Colors.black,
    alignment: Alignment.center,
    child: const Text(
      '▶ Replace _VideoArea with your existing AgoraView body',
      style: TextStyle(color: Colors.white54),
    ),
  );
}
