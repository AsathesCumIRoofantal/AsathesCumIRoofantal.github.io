import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/zoom_theme.dart';
import 'zoom_meeting_controller.dart';

/// Wraps the meeting stage and adds everything the AnyDesk-style
/// permission-gated remote control needs on top of it:
///  - an incoming "X wants to control your screen" dialog (Accept/Deny)
///  - a persistent "being controlled by X · Stop" banner
///  - a small dot showing where the controlling peer's cursor is, drawn
///    over whatever is currently shared/pinned
///
/// This only affects control *within the shared-screen view rendered by
/// this app* — see WEBRTC_SETUP.md for why true OS-wide takeover isn't
/// something a browser or a normal mobile app is allowed to do.
class RemoteControlOverlay extends StatefulWidget {
  const RemoteControlOverlay({super.key, required this.child});
  final Widget child;

  @override
  State<RemoteControlOverlay> createState() => _RemoteControlOverlayState();
}

class _RemoteControlOverlayState extends State<RemoteControlOverlay> {
  final controller = Get.find<ZoomMeetingController>();
  Worker? _requestWorker;
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    final rc = controller.remoteControl;
    if (rc != null) {
      _requestWorker = ever(rc.pendingRequestFromUid, (uid) {
        if (uid != null && !_dialogOpen) _showIncomingRequest(uid);
      });
    }
  }

  void _showIncomingRequest(int fromUid) {
    final rc = controller.remoteControl!;
    final name = controller.participants[fromUid]?.name ?? 'Someone';
    _dialogOpen = true;
    Get.dialog(
      AlertDialog(
        backgroundColor: ZoomTheme.surface2,
        title: const Text('Remote control request', style: TextStyle(color: Colors.white)),
        content: Text(
          '$name wants to control your shared screen.\n'
          'They will be able to click and type on what you\'re sharing until you stop it.',
          style: const TextStyle(color: ZoomTheme.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () { rc.denyControl(fromUid, controller.localUid); Get.back(); _dialogOpen = false; },
            child: const Text('Deny', style: TextStyle(color: ZoomTheme.danger)),
          ),
          FilledButton(
            onPressed: () { rc.grantControl(fromUid, controller.localUid); Get.back(); _dialogOpen = false; },
            child: const Text('Allow'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void dispose() {
    _requestWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rc = controller.remoteControl;
    if (rc == null) return widget.child; // demo mode / no engine attached

    return Stack(children: [
      widget.child,
      // Cursor of whoever is currently controlling us.
      Obx(() {
        if (!rc.showRemoteCursor.value) return const SizedBox.shrink();
        return LayoutBuilder(builder: (ctx, box) {
          return Positioned(
            left: rc.remoteCursorX.value * box.maxWidth - 8,
            top: rc.remoteCursorY.value * box.maxHeight - 8,
            child: IgnorePointer(
              child: Icon(Icons.mouse, size: 20, color: ZoomTheme.primary, shadows: const [
                Shadow(color: Colors.black54, blurRadius: 4),
              ]),
            ),
          );
        });
      }),
      // "Being controlled" banner.
      Obx(() {
        final controllerUid = rc.controlledByUid.value;
        if (controllerUid == null) return const SizedBox.shrink();
        final name = controller.participants[controllerUid]?.name ?? 'A participant';
        return Positioned(
          top: 12, left: 0, right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: ZoomTheme.danger.withOpacity(.92), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.pan_tool_alt, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text('$name is controlling your screen', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => rc.revokeControl(controller.localUid),
                  style: TextButton.styleFrom(backgroundColor: Colors.black26, foregroundColor: Colors.white, minimumSize: const Size(0, 28)),
                  child: const Text('Stop'),
                ),
              ]),
            ),
          ),
        );
      }),
      // "You are controlling X" banner, with its own Stop.
      Obx(() {
        final targetUid = rc.controllingUid.value;
        if (targetUid == null) return const SizedBox.shrink();
        final name = controller.participants[targetUid]?.name ?? 'their screen';
        return Positioned(
          bottom: 90, left: 0, right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: ZoomTheme.primary.withOpacity(.92), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.touch_app, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text('You are controlling $name', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => rc.revokeControl(controller.localUid),
                  style: TextButton.styleFrom(backgroundColor: Colors.black26, foregroundColor: Colors.white, minimumSize: const Size(0, 28)),
                  child: const Text('Stop'),
                ),
              ]),
            ),
          ),
        );
      }),
    ]);
  }
}
