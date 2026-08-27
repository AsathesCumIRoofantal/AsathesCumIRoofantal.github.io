import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';
import '../widgets/backend_toggle.dart';


import '../widgets/reconnect_banner.dart';
import '../widgets/reaction_overlay.dart';
import '../widgets/shortcuts_overlay.dart';
import '../mock/mock_data.dart';
import 'zoom_meeting_controller.dart';
import 'remote_control_overlay.dart';
import 'chat_panel.dart';
import 'participants_panel.dart';
import 'captions_overlay.dart';
import 'breakout_panel.dart';
import 'polls_panel.dart';
import 'qa_panel.dart';
import 'stats_panel.dart';
import 'reactions_bar.dart';
import 'screen_share_picker.dart';
import 'virtual_bg_picker.dart';
import 'whiteboard_view.dart';

/// Main in-meeting surface. Responsive video grid + toolbar + slide-out pane.
/// On desktop the pane sits to the right; on mobile it slides up as a sheet.
class ZoomMeetingView extends GetView<ZoomMeetingController> {
  const ZoomMeetingView({super.key});
  static const String routeName = ZoomRoutes.inMeeting;

  @override
  Widget build(BuildContext c) {
    final pane = 'none'.obs; // chat | people | breakout | polls | qa | stats | whiteboard
    return ShortcutsOverlay(
      child: Scaffold(
        backgroundColor: ZoomTheme.bg,
        body: SafeArea(
          child: LayoutBuilder(builder: (c, cons) {
            final wide = cons.maxWidth >= 900;
            return Column(children: [
              const ReconnectBanner(),
              _TopChrome(),
              Expanded(
                child: Row(children: [
                  Expanded(child: RemoteControlOverlay(child: Stack(children: const [
                    _VideoStage(),
                    CaptionsOverlay(),
                    ReactionOverlay(),
                  ]))),
                  if (wide)
                    Obx(() => AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      child: pane.value == 'none'
                        ? const SizedBox.shrink()
                        : _SidePane(pane: pane.value, onClose: () => pane.value = 'none'),
                    )),
                ]),
              ),
              _Toolbar(pane: pane, wide: wide),
            ]);
          }),
        ),
      ),
    );
  }
}

// ─── Top chrome (meeting title, id, copy, leave) ────────────────────────────
class _TopChrome extends GetView<ZoomMeetingController> {
  @override
  Widget build(BuildContext c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: const BoxDecoration(
        color: ZoomTheme.surface,
        border: Border(bottom: BorderSide(color: ZoomTheme.stroke)),
      ),
      child: Row(children: [
        Container(width: 8, height: 8,
          decoration: const BoxDecoration(color: ZoomTheme.danger, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        const Text('Live', style: TextStyle(color: ZoomTheme.danger, fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(width: 16),
        Flexible(child: Obx(() => Text(controller.meetingTitle.value,
          overflow: TextOverflow.ellipsis,
          style: ZoomTheme.h3.copyWith(fontWeight: FontWeight.w600)))),
        const SizedBox(width: 12),
        Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: ZoomTheme.surface2, borderRadius: BorderRadius.circular(8)),
          child: Text(controller.meetingId.value, style: ZoomTheme.mono.copyWith(fontSize: 12)))),
        const Spacer(),
        Obx(() => Row(children: [
          Icon(controller.connection.value == 'connected' ? Icons.wifi : Icons.wifi_off,
            size: 16, color: ZoomTheme.success),
          const SizedBox(width: 6),
          Text('${controller.stats.rxKbps.value} kbps', style: ZoomTheme.muted),
        ])),
        const SizedBox(width: 12),
        const BackendToggle(compact: true),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () async {
            await controller.leaveLiveMeeting();
            Get.offAllNamed(ZoomRoutes.home);
          },
          style: FilledButton.styleFrom(
            backgroundColor: ZoomTheme.danger,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: const Icon(Icons.call_end, size: 18),
          label: const Text('Leave'),
        ),
      ]),
    );
  }
}

// ─── Video stage: adaptive grid + speaker spotlight, or a screen-share ──────
// grid whenever one or more people are presenting. Up to
// ZoomMeetingController.maxConcurrentScreenShares people can share at once —
// see that constant's doc comment for the honest bandwidth caveat.
class _VideoStage extends GetView<ZoomMeetingController> {
  const _VideoStage();
  @override
  Widget build(BuildContext c) {
    return Obx(() {
      final all = controller.participants.values.toList();
      final shares = controller.activeScreenShares;

      if (shares.isNotEmpty) {
        return _ScreenShareStage(shares: shares, all: all);
      }

      final speakerUid = controller.activeSpeakerUid.value;
      final speaker = all.firstWhere((p) => p.uid == speakerUid,
        orElse: () => all.isNotEmpty ? all.first : all.first);
      final others = all.where((p) => p.uid != speaker.uid).toList();

      return LayoutBuilder(builder: (c, cons) {
        final wide = cons.maxWidth >= 900;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: wide
            ? Row(children: [
                Expanded(flex: 3, child: _Tile(p: speaker, big: true)),
                const SizedBox(width: 12),
                SizedBox(
                  width: 230,
                  child: ListView.separated(
                    itemCount: others.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => SizedBox(height: 140, child: _Tile(p: others[i])),
                  ),
                ),
              ])
            : Column(children: [
                Expanded(flex: 3, child: _Tile(p: speaker, big: true)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: others.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, i) => AspectRatio(aspectRatio: 16/10, child: _Tile(p: others[i])),
                  ),
                ),
              ]),
        );
      });
    });
  }
}

/// Shown whenever ≥1 participant is screen sharing. One sharer gets a big
/// single stage (classic screen-share look); 2+ sharers get an even grid so
/// no single presenter is arbitrarily favoured. Camera tiles for everyone
/// else collapse into a thin strip so shared screens keep the room.
class _ScreenShareStage extends StatelessWidget {
  const _ScreenShareStage({required this.shares, required this.all});
  final List<dynamic> shares; // List<Participant>
  final List<dynamic> all;    // List<Participant>

  @override
  Widget build(BuildContext c) {
    final shareUids = shares.map((p) => p.uid).toSet();
    final cameraOnly = all.where((p) => !shareUids.contains(p.uid)).toList();

    return LayoutBuilder(builder: (c, cons) {
      final wide = cons.maxWidth >= 900;
      final shareArea = shares.length == 1
        ? _Tile(p: shares.first, big: true)
        : GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: shares.length <= 2 ? 1 : (shares.length <= 6 ? 2 : 3),
              mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 16 / 9,
            ),
            itemCount: shares.length,
            itemBuilder: (_, i) => _Tile(p: shares[i], big: true),
          );

      final cameraStrip = cameraOnly.isEmpty
        ? const SizedBox.shrink()
        : (wide
            ? SizedBox(
                width: 200,
                child: ListView.separated(
                  itemCount: cameraOnly.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => SizedBox(height: 120, child: _Tile(p: cameraOnly[i])),
                ),
              )
            : SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cameraOnly.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) => AspectRatio(aspectRatio: 16 / 10, child: _Tile(p: cameraOnly[i])),
                ),
              ));

      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          if (shares.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Align(alignment: Alignment.centerLeft, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: ZoomTheme.surface2, borderRadius: BorderRadius.circular(8)),
                child: Text('${shares.length} people sharing their screen', style: ZoomTheme.muted),
              )),
            ),
          Expanded(
            child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Expanded(flex: 4, child: shareArea),
                  if (cameraOnly.isNotEmpty) ...[const SizedBox(width: 12), cameraStrip],
                ])
              : Column(children: [
                  Expanded(flex: 4, child: shareArea),
                  if (cameraOnly.isNotEmpty) ...[const SizedBox(height: 10), cameraStrip],
                ]),
          ),
        ]),
      );
    });
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.p, this.big = false});
  final dynamic p; // Participant
  final bool big;

  /// If we've been granted control of this (shared-screen) tile, forward
  /// local taps/drags as normalised (0-1) mouse events over the data
  /// channel. This only ever reaches the app on the far end — see
  /// WEBRTC_SETUP.md for why that's the honest scope of in-app control.
  Widget _withControlForwarding(BuildContext c, Widget child) {
    if (!big) return child;
    final controller = Get.find<ZoomMeetingController>();
    final rc = controller.remoteControl;
    if (rc == null) return child;
    return Obx(() {
      if (rc.controllingUid.value != p.uid) return child;
      return LayoutBuilder(builder: (ctx, box) {
        void sendAt(Offset local, {bool isClick = false}) {
          final nx = (local.dx / box.maxWidth).clamp(0.0, 1.0);
          final ny = (local.dy / box.maxHeight).clamp(0.0, 1.0);
          if (isClick) {
            rc.sendMouseClick(controller.localUid, nx, ny);
          } else {
            rc.sendMouseMove(controller.localUid, nx, ny);
          }
        }
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (d) => sendAt(d.localPosition, isClick: true),
            onPanUpdate: (d) => sendAt(d.localPosition),
            child: Stack(fit: StackFit.expand, children: [
              child,
              Positioned(top: 8, left: 8, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: ZoomTheme.primary, borderRadius: BorderRadius.circular(20)),
                child: const Text('Controlling', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
              )),
            ]),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    final color = MockMeetingSim.colorFor(p.uid);
    final isSpeaking = p.isSpeaking == true;
    return _withControlForwarding(c, AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: ZoomTheme.surface2,
        borderRadius: BorderRadius.circular(big ? 18 : 12),
        border: Border.all(
          color: isSpeaking ? ZoomTheme.success : ZoomTheme.stroke,
          width: isSpeaking ? 2 : 1),
        boxShadow: isSpeaking
          ? [const BoxShadow(color: Color(0x552EE6A6), blurRadius: 18)]
          : const [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(big ? 18 : 12),
        child: Stack(fit: StackFit.expand, children: [
          Builder(builder: (ctx) {
            final controller = Get.find<ZoomMeetingController>();
            final engine = controller.engine;
            if (engine != null && p.videoOff != true) {
              // Real feed: local uid renders the camera/screen preview,
              // any other uid renders that peer's incoming WebRTC stream.
              return p.uid == controller.localUid
                  ? engine.buildLocalVideoView()
                  : engine.buildRemoteVideoView(p.uid);
            }
            // Demo mode (no engine attached) or camera off — gradient
            // backdrop stands in for a real feed.
            return DecoratedBox(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(color).withOpacity(.85), Color(color).withOpacity(.35), const Color(0xFF14171F)],
              )));
          }),
          if (p.videoOff == true)
            Center(child: InitialsAvatar(name: p.name, colorHex: color, size: big ? 96 : 48)),
          // Bottom label bar
          Positioned(left: 8, right: 8, bottom: 8, child: Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(p.audioMuted == true ? Icons.mic_off : Icons.mic,
                  size: 12, color: p.audioMuted == true ? ZoomTheme.danger : Colors.white),
                const SizedBox(width: 6),
                Flexible(child: Text(p.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
              ]),
            ),
            const Spacer(),
            if (p.handRaised == true)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text('✋', style: TextStyle(fontSize: 16)),
              ),
          ])),
          if (p.isPinned == true)
            const Positioned(top: 8, right: 8, child: Icon(Icons.push_pin, color: Colors.white, size: 14)),
        ]),
      ),
    ));
  }
}

// ─── Side pane host ─────────────────────────────────────────────────────────
class _SidePane extends StatelessWidget {
  const _SidePane({required this.pane, required this.onClose});
  final String pane;
  final VoidCallback onClose;
  @override
  Widget build(BuildContext c) {
    return SizedBox(
      width: 360,
      child: Container(
        decoration: const BoxDecoration(
          color: ZoomTheme.surface,
          border: Border(left: BorderSide(color: ZoomTheme.stroke)),
        ),
        child: switch (pane) {
          'chat'       => const ChatPanel(),
          'people'     => const ParticipantsPanel(),
          'breakout'   => const BreakoutPanel(),
          'polls'      => const PollsPanel(),
          'qa'         => const QAPanel(),
          'stats'      => const StatsPanel(),
          'whiteboard' => const WhiteboardView(),
          _            => const SizedBox.shrink(),
        },
      ),
    );
  }
}

// ─── Bottom toolbar — also opens the pane as a sheet on mobile ──────────────
class _Toolbar extends GetView<ZoomMeetingController> {
  const _Toolbar({required this.pane, required this.wide});
  final RxString pane;
  final bool wide;

  void _openPane(BuildContext c, String name, Widget child) {
    if (wide) { pane.value = pane.value == name ? 'none' : name; return; }
    showModalBottomSheet(
      context: c, isScrollControlled: true, backgroundColor: ZoomTheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SizedBox(height: MediaQuery.of(c).size.height * .8, child: child),
    );
  }

  @override
  Widget build(BuildContext c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: ZoomTheme.surface,
        border: Border(top: BorderSide(color: ZoomTheme.stroke)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          Obx(() {
            final me = controller.participants[controller.localUid];
            final muted = me?.audioMuted ?? false;
            return _btn(muted ? Icons.mic_off : Icons.mic, muted ? 'Unmute' : 'Mute',
              danger: muted, onTap: controller.toggleLocalAudio);
          }),
          Obx(() {
            final me = controller.participants[controller.localUid];
            final off = me?.videoOff ?? false;
            return _btn(off ? Icons.videocam_off : Icons.videocam, off ? 'Start video' : 'Stop video',
              danger: off, onTap: controller.toggleLocalVideo);
          }),
          Obx(() {
            final sharing = controller.participants[controller.localUid]?.isScreenSharing ?? false;
            final activeCount = controller.activeScreenShares.length;
            // Small live count once more than one person is presenting, so
            // it's obvious this isn't a single-presenter tool anymore.
            return _btn(Icons.screen_share_outlined,
              sharing ? 'Stop share' : (activeCount > 0 ? 'Share ($activeCount/${ZoomMeetingController.maxConcurrentScreenShares})' : 'Share'),
              danger: sharing,
              onTap: () async {
                if (sharing) { await controller.toggleScreenShare(); return; }
                if (activeCount >= ZoomMeetingController.maxConcurrentScreenShares) {
                  // Same message toggleScreenShare would show — surfaced
                  // here too so we don't even bother opening the OS-level
                  // picker dialog for a share that's guaranteed to be
                  // rejected.
                  Get.snackbar('Screen-share limit reached',
                    'Up to ${ZoomMeetingController.maxConcurrentScreenShares} people can share at once. '
                    'Ask someone to stop sharing first.', snackPosition: SnackPosition.TOP);
                  return;
                }
                final choice = await Get.dialog<String>(const ScreenSharePicker());
                if (choice == null) return;
                if (choice == 'whiteboard') { _openPane(c, 'whiteboard', const WhiteboardView()); return; }
                await controller.toggleScreenShare();
              });
          }),
          _btn(Icons.chat_bubble_outline, 'Chat',
            badge: controller.chat.length,
            onTap: () => _openPane(c, 'chat', const ChatPanel())),
          _btn(Icons.people_outline, 'People',
            badge: controller.participants.length,
            onTap: () => _openPane(c, 'people', const ParticipantsPanel())),
          _btn(Icons.poll_outlined, 'Polls',
            onTap: () => _openPane(c, 'polls', const PollsPanel())),
          _btn(Icons.help_outline, 'Q & A',
            onTap: () => _openPane(c, 'qa', const QAPanel())),
          _btn(Icons.meeting_room_outlined, 'Breakouts',
            onTap: () => _openPane(c, 'breakout', const BreakoutPanel())),
          _btn(Icons.dashboard_customize_outlined, 'Whiteboard',
            onTap: () => _openPane(c, 'whiteboard', const WhiteboardView())),
          Obx(() => _btn(Icons.closed_caption_outlined,
            controller.captionsOn.value ? 'CC on' : 'CC',
            active: controller.captionsOn.value,
            onTap: controller.toggleCaptions)),
          _btn(Icons.emoji_emotions_outlined, 'React', onTap: () {
            showModalBottomSheet(context: c, backgroundColor: Colors.transparent,
              builder: (_) => const Padding(padding: EdgeInsets.all(16), child: ReactionsBar()));
          }),
          _btn(Icons.image_outlined, 'Background',
            onTap: () async {
              final choice = await Get.dialog<String>(const VirtualBgPicker());
              if (choice == null || choice == 'None') return;
              await controller.engine?.enableVirtualBackground(true);
              Get.snackbar('Not available yet',
                'Virtual backgrounds need an ML segmentation model that '
                "isn't wired up yet — see enableVirtualBackground() in "
                'webrtc_service.dart.');
            }),
          Obx(() {
            final raised = controller.participants[controller.localUid]?.handRaised ?? false;
            return _btn(Icons.pan_tool_alt_outlined, raised ? 'Lower hand' : 'Raise hand',
              active: raised, onTap: controller.toggleHandRaise);
          }),
          _btn(Icons.bar_chart_outlined, 'Stats',
            onTap: () => _openPane(c, 'stats', const StatsPanel())),
          Obx(() => _btn(
            controller.isLocalRecording.value || controller.isCloudRecording.value
              ? Icons.stop_circle_outlined : Icons.fiber_manual_record,
            controller.isLocalRecording.value || controller.isCloudRecording.value
              ? 'Stop rec' : 'Record',
            danger: true,
            active: controller.isLocalRecording.value || controller.isCloudRecording.value,
            onTap: () async {
              if (controller.isLocalRecording.value) {
                final path = await controller.stopLocalRecording();
                Get.snackbar('Recording saved',
                  path == null ? 'Recording stopped.' : 'Saved to $path');
                return;
              }
              if (controller.isCloudRecording.value) {
                await controller.stopRecording();
                Get.snackbar('Cloud recording stopped', 'Upload finalizing.');
                return;
              }
              final choice = await Get.dialog<String>(AlertDialog(
                backgroundColor: ZoomTheme.surface2,
                title: const Text('Start recording', style: TextStyle(color: Colors.white)),
                content: const Text(
                  'Local: saves a file on this device, free, no server. '
                  'Cloud: uploads to your Supabase-brokered R2 bucket so '
                  'everyone can access it after the call — needs the '
                  'recording_manager Edge Function deployed (see '
                  'supabase/functions/recording_manager).',
                  style: TextStyle(color: ZoomTheme.textMuted)),
                actions: [
                  TextButton(onPressed: () => Get.back(result: 'local'), child: const Text('Local')),
                  TextButton(onPressed: () => Get.back(result: 'cloud'), child: const Text('Cloud')),
                  TextButton(onPressed: () => Get.back(result: null), child: const Text('Cancel')),
                ],
              ));
              if (choice == 'local') {
                await controller.startLocalRecording();
                if (controller.localRecordingError.value != null) {
                  Get.snackbar('Recording failed', controller.localRecordingError.value!,
                    duration: const Duration(seconds: 6));
                } else {
                  Get.snackbar('Recording started', 'Saving locally on this device.');
                }
              } else if (choice == 'cloud') {
                try {
                  await controller.startCloudRecording();
                  Get.snackbar('Cloud recording started', 'Uploading to R2.');
                } catch (e) {
                  Get.snackbar('Cloud recording failed', e.toString(),
                    duration: const Duration(seconds: 6));
                }
              }
            })),
        ]),
      ),
    );
  }

  Widget _btn(IconData i, String label, {VoidCallback? onTap, bool danger=false, bool active=false, int? badge}) {
    final color = danger ? ZoomTheme.danger : active ? ZoomTheme.success : ZoomTheme.text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 72,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: active ? ZoomTheme.success.withOpacity(.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(clipBehavior: Clip.none, children: [
              Icon(i, color: color),
              if (badge != null && badge > 0)
                Positioned(right: -8, top: -6, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(color: ZoomTheme.primary, borderRadius: BorderRadius.circular(8)),
                  child: Text('$badge', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                )),
            ]),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis, maxLines: 1),
          ]),
        ),
      ),
    );
  }
}
