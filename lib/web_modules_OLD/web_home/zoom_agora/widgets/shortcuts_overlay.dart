import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../in_meeting/zoom_meeting_controller.dart';

/// Wrap your meeting Scaffold with this to enable Zoom-style hotkeys.
class ShortcutsOverlay extends StatelessWidget {
  final Widget child;
  const ShortcutsOverlay({super.key, required this.child});
  @override Widget build(BuildContext c){
    final ctl = Get.find<ZoomMeetingController>();
    return CallbackShortcuts(bindings: {
      const SingleActivator(LogicalKeyboardKey.keyA, alt: true): () { /* mute */ },
      const SingleActivator(LogicalKeyboardKey.keyV, alt: true): () { /* video */ },
      const SingleActivator(LogicalKeyboardKey.keyS, alt: true): () { /* share */ },
      const SingleActivator(LogicalKeyboardKey.keyR, alt: true): () { ctl.startCloudRecording(); },
      const SingleActivator(LogicalKeyboardKey.keyH, alt: true): () { /* hand */ },
      const SingleActivator(LogicalKeyboardKey.keyC, alt: true): () { ctl.toggleCaptions(); },
      const SingleActivator(LogicalKeyboardKey.f1):             () { _show(c); },
    }, child: Focus(autofocus: true, child: child));
  }
  void _show(BuildContext c)=>showDialog(context: c, builder:(_)=>AlertDialog(
    title: const Text('Keyboard Shortcuts'),
    content: const SingleChildScrollView(child: Text(
      'Alt+A   Mute / unmute\nAlt+V   Camera on/off\nAlt+S   Share screen\nAlt+R   Record\n'
      'Alt+H   Raise hand\nAlt+C   Captions\nSpace   Push-to-talk\nF1      This dialog')),
    actions:[TextButton(onPressed: ()=>Navigator.pop(c), child: const Text('OK'))]));
}
