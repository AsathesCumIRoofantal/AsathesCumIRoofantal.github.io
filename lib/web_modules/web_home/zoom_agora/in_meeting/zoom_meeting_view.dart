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
                  Expanded(child: Stack(children: const [
                    _VideoStage(),
                    CaptionsOverlay(),
                    ReactionOverlay(),
                  ])),
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
        Flexible(child: Text('Product weekly sync',
          overflow: TextOverflow.ellipsis,
          style: ZoomTheme.h3.copyWith(fontWeight: FontWeight.w600))),
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
          onPressed: () => Get.offAllNamed(ZoomRoutes.home),
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

// ─── Mock video stage with adaptive grid + speaker spotlight ────────────────
class _VideoStage extends GetView<ZoomMeetingController> {
  const _VideoStage();
  @override
  Widget build(BuildContext c) {
    return Obx(() {
      final all = controller.participants.values.toList();
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

class _Tile extends StatelessWidget {
  const _Tile({required this.p, this.big = false});
  final dynamic p; // Participant
  final bool big;
  @override
  Widget build(BuildContext c) {
    final color = MockMeetingSim.colorFor(p.uid);
    final isSpeaking = p.isSpeaking == true;
    return AnimatedContainer(
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
          // "Video" — gradient backdrop standing in for a real camera feed.
          DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(color).withOpacity(.85), Color(color).withOpacity(.35), const Color(0xFF14171F)],
            ))),
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
    );
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
            final me = controller.participants[0];
            final muted = me?.audioMuted ?? false;
            return _btn(muted ? Icons.mic_off : Icons.mic, muted ? 'Unmute' : 'Mute',
              danger: muted, onTap: () { me?.audioMuted = !muted; controller.participants.refresh(); });
          }),
          Obx(() {
            final me = controller.participants[0];
            final off = me?.videoOff ?? false;
            return _btn(off ? Icons.videocam_off : Icons.videocam, off ? 'Start video' : 'Stop video',
              danger: off, onTap: () { me?.videoOff = !off; controller.participants.refresh(); });
          }),
          _btn(Icons.screen_share_outlined, 'Share',
            onTap: () => Get.dialog(const ScreenSharePicker())),
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
            onTap: () => Get.dialog(const VirtualBgPicker())),
          _btn(Icons.bar_chart_outlined, 'Stats',
            onTap: () => _openPane(c, 'stats', const StatsPanel())),
          _btn(Icons.fiber_manual_record, 'Record', danger: true,
            onTap: controller.startCloudRecording),
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
