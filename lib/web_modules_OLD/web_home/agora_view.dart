import 'dart:math' as math;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:air_app/web_modules_OLD/_shared/web_nav_data.dart';
import 'package:air_app/web_modules_OLD/_shared/web_shell.dart';
import 'package:air_app/web_modules_OLD/web_home/agora_rtc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN TOKENS
// ─────────────────────────────────────────────────────────────────────────────
class _Z {
  // Zoom-dark palette
  static const bg = Color(0xFF1C1C1E);
  static const surface = Color(0xFF2C2C2E);
  static const surfaceHigh = Color(0xFF3A3A3C);
  static const border = Color(0xFF48484A);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF8E8E93);
  static const blue = Color(0xFF0A84FF);
  static const green = Color(0xFF30D158);
  static const red = Color(0xFFFF3B30);
  static const amber = Color(0xFFFF9F0A);
  static const purple = Color(0xFFBF5AF2);
  static const teal = Color(0xFF5AC8FA);

  // Tile avatar gradient pairs per index
  static const avatarGrads = [
    [Color(0xFF0A84FF), Color(0xFF30D158)],
    [Color(0xFFBF5AF2), Color(0xFF0A84FF)],
    [Color(0xFFFF9F0A), Color(0xFFFF3B30)],
    [Color(0xFF30D158), Color(0xFF5AC8FA)],
    [Color(0xFFFF3B30), Color(0xFFBF5AF2)],
    [Color(0xFF5AC8FA), Color(0xFF30D158)],
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// VIEW
// ─────────────────────────────────────────────────────────────────────────────
class AgoraView extends GetView<AgoraRtcController> {
  const AgoraView({super.key});

  static const String routeName = WebNavData.homeAgoraRoute;

  @override
  Widget build(BuildContext context) {
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: _Z.bg,
        body: SafeArea(child: _Body(controller: controller)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BODY — layout orchestrator
// ─────────────────────────────────────────────────────────────────────────────
class _Body extends StatelessWidget {
  final AgoraRtcController controller;
  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final showSidebar = w >= 900;

    return Column(
      children: [
        // ── Top bar ───────────────────────────────────────────────────────
        _TopBar(controller: controller),
        // ── Main area ─────────────────────────────────────────────────────
        Expanded(
          child: Row(
            children: [
              // Video area
              Expanded(
                child: Obx(() {
                  if (controller.viewMode.value == 'speaker') {
                    return _SpeakerLayout(controller: controller);
                  }
                  return _GalleryLayout(controller: controller);
                }),
              ),
              // Sidebar (desktop)
              if (showSidebar)
                Obx(() {
                  if (!controller.isChatOpen.value &&
                      !controller.isParticipantsOpen.value) {
                    return const SizedBox.shrink();
                  }
                  return _Sidebar(controller: controller);
                }),
            ],
          ),
        ),
        // ── Control bar ───────────────────────────────────────────────────
        _ControlBar(controller: controller),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final AgoraRtcController controller;
  const _TopBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: _Z.surface,
        border: Border(bottom: BorderSide(color: _Z.border, width: 0.5)),
      ),
      child: Row(
        children: [
          // Meeting name
          const Icon(Icons.videocam_rounded, color: _Z.blue, size: 20),
          const SizedBox(width: 8),
          Obx(
            () => Text(
              controller.isLocalJoined.value
                  ? 'AIR Space — Live Session'
                  : 'Connecting…',
              style: const TextStyle(
                color: _Z.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Duration chip
          Obx(() {
            if (!controller.isLocalJoined.value) return const SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _Z.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _Z.green.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.fiber_manual_record,
                    color: _Z.green,
                    size: 8,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.formattedDuration,
                    style: const TextStyle(
                      color: _Z.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
          const Spacer(),
          // AI caption status
          Obx(
            () => AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: controller.isAiTranscribing.value
                    ? _Z.purple.withValues(alpha: 0.15)
                    : _Z.surfaceHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: controller.isAiTranscribing.value
                      ? _Z.purple.withValues(alpha: 0.5)
                      : _Z.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.psychology_rounded,
                    color: controller.isAiTranscribing.value
                        ? _Z.purple
                        : _Z.textSecondary,
                    size: 13,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.isAiTranscribing.value
                        ? 'AI Live Captions'
                        : 'AI Idle',
                    style: TextStyle(
                      color: controller.isAiTranscribing.value
                          ? _Z.purple
                          : _Z.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Participant count
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _Z.surfaceHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.group_rounded,
                    color: _Z.textSecondary,
                    size: 13,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${controller.participantCount}',
                    style: const TextStyle(
                      color: _Z.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // View mode toggle
          Obx(
            () => _TinyButton(
              icon: controller.viewMode.value == 'gallery'
                  ? Icons.view_sidebar_rounded
                  : Icons.grid_view_rounded,
              label: controller.viewMode.value == 'gallery'
                  ? 'Speaker'
                  : 'Gallery',
              onTap: controller.toggleViewMode,
            ),
          ),
        ],
      ),
    );
  }
}

class _TinyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _TinyButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _Z.surfaceHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _Z.textSecondary, size: 13),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: _Z.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GALLERY LAYOUT
// ─────────────────────────────────────────────────────────────────────────────
class _GalleryLayout extends StatelessWidget {
  final AgoraRtcController controller;
  const _GalleryLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total = 1 + controller.remoteUsers.length;
      final w = MediaQuery.sizeOf(context).width;
      final cols = w >= 1200
          ? 4
          : w >= 800
          ? 3
          : w >= 500
          ? 2
          : 1;

      return Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: total,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 16 / 10,
          ),
          itemBuilder: (_, i) =>
              _VideoTile(index: i, controller: controller, isLarge: false)
                  .animate()
                  .fade(duration: 300.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    duration: 300.ms,
                    curve: Curves.easeOutCubic,
                  ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SPEAKER LAYOUT
// ─────────────────────────────────────────────────────────────────────────────
class _SpeakerLayout extends StatelessWidget {
  final AgoraRtcController controller;
  const _SpeakerLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pinned = controller.pinnedUserId.value;
      final total = 1 + controller.remoteUsers.length;
      // Determine main speaker index: pinned takes priority, else first remote
      int mainIndex = 0;
      if (pinned != null) {
        if (pinned == 0) {
          mainIndex = 0;
        } else {
          final idx = controller.remoteUsers.indexOf(pinned);
          mainIndex = idx == -1 ? 0 : idx + 1;
        }
      } else if (controller.remoteUsers.isNotEmpty) {
        mainIndex = 1;
      }

      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Large main speaker
            Expanded(
              child: _VideoTile(
                index: mainIndex,
                controller: controller,
                isLarge: true,
              ).animate().fade(duration: 250.ms),
            ),
            const SizedBox(height: 10),
            // Thumbnail strip
            if (total > 1)
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: total,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    if (i == mainIndex) return const SizedBox.shrink();
                    return SizedBox(
                      width: 140,
                      child: _VideoTile(
                        index: i,
                        controller: controller,
                        isLarge: false,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VIDEO TILE — the core widget with all overlays
// ─────────────────────────────────────────────────────────────────────────────
class _VideoTile extends StatefulWidget {
  final int index;
  final AgoraRtcController controller;
  final bool isLarge;
  const _VideoTile({
    required this.index,
    required this.controller,
    required this.isLarge,
  });

  @override
  State<_VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<_VideoTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _speakCtrl;
  late Animation<double> _speakAnim;

  AgoraRtcController get c => widget.controller;
  bool get isLocal => widget.index == 0;
  int get uid => isLocal ? 0 : c.remoteUsers[widget.index - 1];
  String get name => c.participantNames[uid] ?? 'Participant $uid';
  bool get muted => isLocal ? c.isMuted.value : c.isRemoteMuted(uid);
  bool get videoOff => isLocal ? c.isVideoDisabled.value : false;
  bool get speaking => c.isSpeaking(uid);
  bool get isPinned => c.pinnedUserId.value == uid;
  List<Color> get grad => _Z.avatarGrads[widget.index % _Z.avatarGrads.length];

  @override
  void initState() {
    super.initState();
    _speakCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _speakAnim = CurvedAnimation(parent: _speakCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _speakCtrl.dispose();
    super.dispose();
  }

  void _onTap() {
    // Single tap = mute/unmute
    if (isLocal) {
      c.toggleMute();
    } else {
      c.muteRemoteAudio(uid);
    }
  }

  void _onLongPress() {
    // Long press = pin/unpin
    c.togglePin(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final speaking_ = c.isSpeaking(uid);
      final muted_ = isLocal ? c.isMuted.value : c.isRemoteMuted(uid);
      final videoOff_ = isLocal ? c.isVideoDisabled.value : false;
      final isPinned_ = c.pinnedUserId.value == uid;

      return GestureDetector(
        onTap: _onTap,
        onLongPress: _onLongPress,
        child: AnimatedBuilder(
          animation: _speakAnim,
          builder: (_, child) {
            final glow = speaking_
                ? _Z.green.withValues(alpha: 0.4 + 0.3 * _speakAnim.value)
                : Colors.transparent;
            final borderW = speaking_ ? 2.5 + _speakAnim.value * 1.5 : 1.5;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.isLarge ? 16 : 10),
                border: Border.all(
                  color: isPinned_
                      ? _Z.blue
                      : speaking_
                      ? _Z.green
                      : _Z.border,
                  width: borderW,
                ),
                boxShadow: speaking_
                    ? [BoxShadow(color: glow, blurRadius: 12, spreadRadius: 2)]
                    : null,
              ),
              child: child,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.isLarge ? 14 : 8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Video feed / avatar ─────────────────────────────────
                if (!videoOff_ && c.isLocalJoined.value)
                  AgoraVideoView(
                    controller: isLocal
                        ? VideoViewController(
                            rtcEngine: c.engine,
                            canvas: const VideoCanvas(uid: 0),
                          )
                        : VideoViewController.remote(
                            rtcEngine: c.engine,
                            canvas: VideoCanvas(uid: uid),
                            connection: RtcConnection(channelId: c.channelId),
                          ),
                  )
                else
                  _AvatarPlaceholder(name: name, grad: grad),

                // ── Mute overlay (red tint flash when just muted) ────────
                if (muted_)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(color: _Z.red.withValues(alpha: 0.06)),
                    ),
                  ),

                // ── Top-left: name tag ───────────────────────────────────
                Positioned(
                  top: 8,
                  left: 8,
                  child: _NameTag(
                    name: name,
                    muted: muted_,
                    isPinned: isPinned_,
                  ),
                ),

                // ── Bottom-right: overlay buttons ────────────────────────
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mute toggle
                      _OverlayButton(
                        icon: muted_
                            ? Icons.mic_off_rounded
                            : Icons.mic_rounded,
                        color: muted_ ? _Z.red : Colors.white,
                        tooltip: muted_ ? 'Unmute' : 'Mute',
                        onTap: _onTap,
                      ),
                      const SizedBox(width: 6),
                      // Pin toggle
                      _OverlayButton(
                        icon: isPinned_
                            ? Icons.push_pin_rounded
                            : Icons.push_pin_outlined,
                        color: isPinned_ ? _Z.blue : Colors.white,
                        tooltip: isPinned_ ? 'Unpin' : 'Pin',
                        onTap: _onLongPress,
                      ),
                    ],
                  ),
                ),

                // ── Hand raised badge ────────────────────────────────────
                if (isLocal && c.isHandRaised.value)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _Z.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('✋', style: TextStyle(fontSize: 14)),
                    ).animate().shake(duration: 600.ms),
                  ),

                // ── Speaking ring (outer pulse, for large tile) ──────────
                if (speaking_ && widget.isLarge)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _speakAnim,
                        builder: (_, __) => CustomPaint(
                          painter: _SpeakingRingPainter(
                            progress: _speakAnim.value,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ── Screen share badge ───────────────────────────────────
                if (isLocal && c.isScreenSharing.value)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _Z.teal.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.screen_share_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Sharing',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Avatar placeholder when video is off
class _AvatarPlaceholder extends StatelessWidget {
  final String name;
  final List<Color> grad;
  const _AvatarPlaceholder({required this.name, required this.grad});

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            grad[0].withValues(alpha: 0.25),
            grad[1].withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: _Z.surface,
      ),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: grad,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Name tag overlay
class _NameTag extends StatelessWidget {
  final String name;
  final bool muted;
  final bool isPinned;
  const _NameTag({
    required this.name,
    required this.muted,
    required this.isPinned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (muted)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.mic_off_rounded, color: _Z.red, size: 11),
            ),
          if (isPinned)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.push_pin_rounded, color: _Z.blue, size: 11),
            ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Small overlay icon button on tile
class _OverlayButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;
  const _OverlayButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
      ),
    );
  }
}

// Speaking ring CustomPainter
class _SpeakingRingPainter extends CustomPainter {
  final double progress;
  const _SpeakingRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _Z.green.withValues(alpha: 0.15 + 0.2 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3 + progress * 3;
    final r = math.min(size.width, size.height) / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), r - 4, paint);
  }

  @override
  bool shouldRepaint(_SpeakingRingPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTROL BAR — Zoom-style bottom bar with labels
// ─────────────────────────────────────────────────────────────────────────────
class _ControlBar extends StatelessWidget {
  final AgoraRtcController controller;
  const _ControlBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: _Z.surface,
        border: Border(top: BorderSide(color: _Z.border, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Mic ───────────────────────────────────────────────────────
            _CtrlBtn(
              icon: controller.isMuted.value
                  ? Icons.mic_off_rounded
                  : Icons.mic_rounded,
              label: controller.isMuted.value ? 'Unmute' : 'Mute',
              active: controller.isMuted.value,
              activeColor: _Z.red,
              onTap: controller.toggleMute,
            ),
            const SizedBox(width: 8),
            // ── Video ─────────────────────────────────────────────────────
            _CtrlBtn(
              icon: controller.isVideoDisabled.value
                  ? Icons.videocam_off_rounded
                  : Icons.videocam_rounded,
              label: controller.isVideoDisabled.value
                  ? 'Start Video'
                  : 'Stop Video',
              active: controller.isVideoDisabled.value,
              activeColor: _Z.red,
              onTap: controller.toggleVideo,
            ),
            const SizedBox(width: 8),
            // ── Screen Share ──────────────────────────────────────────────
            _CtrlBtn(
              icon: controller.isScreenSharing.value
                  ? Icons.stop_screen_share_rounded
                  : Icons.screen_share_rounded,
              label: controller.isScreenSharing.value
                  ? 'Stop Share'
                  : 'Share Screen',
              active: controller.isScreenSharing.value,
              activeColor: _Z.teal,
              onTap: controller.toggleScreenShare,
            ),
            const SizedBox(width: 8),
            // ── Virtual BG ────────────────────────────────────────────────
            _CtrlBtn(
              icon: controller.isVirtualBgActive.value
                  ? Icons.blur_on_rounded
                  : Icons.blur_off_rounded,
              label: controller.isVirtualBgActive.value
                  ? 'BG On'
                  : 'Background',
              active: controller.isVirtualBgActive.value,
              activeColor: _Z.purple,
              onTap: controller.toggleVirtualBackground,
            ),
            const SizedBox(width: 8),
            // ── Hand Raise ────────────────────────────────────────────────
            _CtrlBtn(
              icon: Icons.back_hand_rounded,
              label: controller.isHandRaised.value
                  ? 'Lower Hand'
                  : 'Raise Hand',
              active: controller.isHandRaised.value,
              activeColor: _Z.amber,
              onTap: controller.toggleHandRaise,
            ),
            const SizedBox(width: 8),
            // ── Participants ──────────────────────────────────────────────
            _CtrlBtn(
              icon: Icons.people_alt_rounded,
              label: 'Participants\n${controller.participantCount}',
              active: controller.isParticipantsOpen.value,
              activeColor: _Z.blue,
              onTap: controller.toggleParticipants,
            ),
            const SizedBox(width: 8),
            // ── Chat / AI Logs ────────────────────────────────────────────
            _CtrlBtn(
              icon: Icons.psychology_rounded,
              label: 'AI Copilot',
              active: controller.isChatOpen.value,
              activeColor: _Z.blue,
              onTap: controller.toggleChat,
            ),

            const Spacer(),

            // ── End Call ──────────────────────────────────────────────────
            _EndCallBtn(
              onTap: () async {
                await controller.leaveStreamChannel();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CtrlBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;
  const _CtrlBtn({
    required this.icon,
    required this.label,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? activeColor.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: active
                ? Border.all(color: activeColor.withValues(alpha: 0.4))
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: active ? activeColor : _Z.textSecondary,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label.split('\n').first,
                style: TextStyle(
                  color: active ? activeColor : _Z.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EndCallBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _EndCallBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _Z.red,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _Z.red.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.call_end_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'End Call',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SIDEBAR — AI logs + Participants
// ─────────────────────────────────────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  final AgoraRtcController controller;
  const _Sidebar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: _Z.surface,
        border: Border(left: BorderSide(color: _Z.border, width: 0.5)),
      ),
      child: Obx(() {
        if (controller.isParticipantsOpen.value) {
          return _ParticipantsPanel(controller: controller);
        }
        return _AiLogsPanel(controller: controller);
      }),
    );
  }
}

// AI Copilot logs panel
class _AiLogsPanel extends StatelessWidget {
  final AgoraRtcController controller;
  const _AiLogsPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PanelHeader(
          icon: Icons.psychology_rounded,
          title: 'AI Copilot Logs',
          iconColor: _Z.purple,
          onClose: controller.toggleChat,
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(12),
              itemCount: controller.transcriptionLines.length,
              itemBuilder: (_, i) {
                final line = controller.transcriptionLines[i];
                final isError = line.contains('🔴') || line.contains('Error');
                final isSuccess = line.contains('✅') || line.contains('joined');
                final isAi = line.contains('AI');
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isError
                        ? _Z.red.withValues(alpha: 0.08)
                        : isAi
                        ? _Z.purple.withValues(alpha: 0.08)
                        : _Z.surfaceHigh,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isError
                          ? _Z.red.withValues(alpha: 0.25)
                          : isAi
                          ? _Z.purple.withValues(alpha: 0.2)
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    line,
                    style: TextStyle(
                      color: isError
                          ? _Z.red
                          : isAi
                          ? _Z.purple
                          : _Z.textSecondary,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ).animate().slideY(begin: -0.1, duration: 200.ms).fade();
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Participants panel with individual mute controls
class _ParticipantsPanel extends StatelessWidget {
  final AgoraRtcController controller;
  const _ParticipantsPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PanelHeader(
          icon: Icons.people_alt_rounded,
          title: 'Participants (${controller.participantCount})',
          iconColor: _Z.blue,
          onClose: controller.toggleParticipants,
        ),
        Expanded(
          child: Obx(() {
            final uids = [0, ...controller.remoteUsers];
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: uids.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: _Z.border, height: 1),
              itemBuilder: (_, i) {
                final uid = uids[i];
                final isMe = uid == 0;
                final name =
                    controller.participantNames[uid] ?? 'Participant $uid';
                final muted = isMe
                    ? controller.isMuted.value
                    : controller.isRemoteMuted(uid);
                final speaking = controller.isSpeaking(uid);
                final grad = _Z.avatarGrads[i % _Z.avatarGrads.length];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: grad,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: speaking
                              ? [
                                  BoxShadow(
                                    color: _Z.green.withValues(alpha: 0.5),
                                    blurRadius: 6,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Name + status
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: _Z.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                if (speaking)
                                  const Text(
                                    'Speaking',
                                    style: TextStyle(
                                      color: _Z.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                else
                                  Text(
                                    isMe ? 'Host (You)' : 'Participant',
                                    style: const TextStyle(
                                      color: _Z.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Mute button
                      GestureDetector(
                        onTap: isMe
                            ? controller.toggleMute
                            : () => controller.muteRemoteAudio(uid),
                        child: AnimatedContainer(
                          duration: 200.ms,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: muted
                                ? _Z.red.withValues(alpha: 0.15)
                                : _Z.surfaceHigh,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            muted ? Icons.mic_off_rounded : Icons.mic_rounded,
                            color: muted ? _Z.red : _Z.textSecondary,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Pin button
                      GestureDetector(
                        onTap: () => controller.togglePin(uid),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: controller.pinnedUserId.value == uid
                                ? _Z.blue.withValues(alpha: 0.15)
                                : _Z.surfaceHigh,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            controller.pinnedUserId.value == uid
                                ? Icons.push_pin_rounded
                                : Icons.push_pin_outlined,
                            color: controller.pinnedUserId.value == uid
                                ? _Z.blue
                                : _Z.textSecondary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onClose;
  const _PanelHeader({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _Z.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _Z.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(
              Icons.close_rounded,
              color: _Z.textSecondary,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
