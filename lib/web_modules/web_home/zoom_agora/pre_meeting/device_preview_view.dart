import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';

/// Animated mic-meter + simulated camera preview so users can "test" devices
/// before joining the meeting.
class DevicePreviewView extends StatefulWidget {
  const DevicePreviewView({super.key});
  @override State<DevicePreviewView> createState() => _S();
}

class _S extends State<DevicePreviewView> with SingleTickerProviderStateMixin {
  String camera = 'FaceTime HD Camera';
  String mic    = 'MacBook Pro Microphone';
  String spk    = 'External Speakers';
  bool mirror = true;
  bool videoOn = true;
  bool micOn   = true;
  double micLevel = 0;
  Timer? _t;

  static const _cameras = ['FaceTime HD Camera', 'Logitech C920', 'OBS Virtual Camera'];
  static const _mics    = ['MacBook Pro Microphone', 'AirPods Pro', 'Blue Yeti'];
  static const _spks    = ['External Speakers', 'AirPods Pro', 'Studio Display'];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _t = Timer.periodic(const Duration(milliseconds: 140), (_) {
      if (!mounted) return;
      setState(() => micLevel = micOn ? (rng.nextDouble() * .8 + .1) : 0);
    });
  }

  @override
  void dispose() { _t?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: ZoomTheme.bg,
    appBar: AppBar(
      backgroundColor: ZoomTheme.bg, elevation: 0,
      iconTheme: const IconThemeData(color: ZoomTheme.text),
      title: Text('Check your devices', style: ZoomTheme.h3),
    ),
    body: LayoutBuilder(builder: (c, cons) {
      final wide = cons.maxWidth >= 880;
      final preview = _preview();
      final controls = _controls();
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 16, vertical: 16),
        child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 6, child: preview),
              const SizedBox(width: 24),
              Expanded(flex: 5, child: controls),
            ])
          : Column(children: [preview, const SizedBox(height: 20), controls]),
      );
    }),
  );

  Widget _preview() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    AspectRatio(
      aspectRatio: 16/9,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF1B2030), Color(0xFF0B0D12)]),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ZoomTheme.stroke),
        ),
        child: Stack(children: [
          if (videoOn)
            Center(child: Transform(
              alignment: Alignment.center,
              transform: mirror ? Matrix4.rotationY(pi) : Matrix4.identity(),
              child: const InitialsAvatar(name: 'Aarav Sharma', colorHex: 0xFF4F8CFF, size: 120),
            ))
          else
            const Center(child: Text('Camera off', style: TextStyle(color: ZoomTheme.textMuted, fontSize: 14))),
          Positioned(left: 12, bottom: 12, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
            child: const Text('Aarav Sharma', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          )),
          Positioned(right: 12, top: 12, child: Wrap(spacing: 8, children: [
            _chip(videoOn ? Icons.videocam : Icons.videocam_off, videoOn ? 'On' : 'Off', !videoOn),
            _chip(micOn ? Icons.mic : Icons.mic_off, micOn ? 'On' : 'Off', !micOn),
          ])),
        ]),
      ),
    ),
    const SizedBox(height: 14),
    Row(children: [
      Expanded(child: OutlinedButton.icon(
        onPressed: () => setState(() => videoOn = !videoOn),
        icon: Icon(videoOn ? Icons.videocam : Icons.videocam_off),
        label: Text(videoOn ? 'Stop video' : 'Start video'),
        style: OutlinedButton.styleFrom(
          foregroundColor: ZoomTheme.text, side: const BorderSide(color: ZoomTheme.stroke),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      )),
      const SizedBox(width: 12),
      Expanded(child: OutlinedButton.icon(
        onPressed: () => setState(() => micOn = !micOn),
        icon: Icon(micOn ? Icons.mic : Icons.mic_off),
        label: Text(micOn ? 'Mute' : 'Unmute'),
        style: OutlinedButton.styleFrom(
          foregroundColor: ZoomTheme.text, side: const BorderSide(color: ZoomTheme.stroke),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      )),
    ]),
  ]);

  Widget _chip(IconData i, String l, bool danger) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: danger ? ZoomTheme.danger.withOpacity(.8) : Colors.black54,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(i, size: 12, color: Colors.white), const SizedBox(width: 4),
      Text(l, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _controls() => Container(
    padding: const EdgeInsets.all(20),
    decoration: ZoomTheme.card(r: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Audio & video', style: ZoomTheme.h3),
      const SizedBox(height: 14),
      _dropdown('Camera', camera, _cameras, (v) => setState(() => camera = v)),
      const SizedBox(height: 10),
      _dropdown('Microphone', mic, _mics, (v) => setState(() => mic = v)),
      const SizedBox(height: 6),
      Row(children: [
        const Text('Input level', style: TextStyle(color: ZoomTheme.textMuted, fontSize: 12)),
        const SizedBox(width: 10),
        Expanded(child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: micLevel, minHeight: 6,
            backgroundColor: ZoomTheme.surface2,
            valueColor: AlwaysStoppedAnimation(
              micLevel > .8 ? ZoomTheme.danger : micLevel > .5 ? ZoomTheme.warn : ZoomTheme.success),
          ),
        )),
      ]),
      const SizedBox(height: 16),
      _dropdown('Speaker', spk, _spks, (v) => setState(() => spk = v)),
      Align(alignment: Alignment.centerLeft,
        child: TextButton.icon(onPressed: () {},
          icon: const Icon(Icons.play_circle_outline, size: 18),
          label: const Text('Test speaker'),
          style: TextButton.styleFrom(foregroundColor: ZoomTheme.primary))),
      const Divider(color: ZoomTheme.stroke),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Mirror my video', style: TextStyle(color: ZoomTheme.text)),
        value: mirror, activeColor: ZoomTheme.primary,
        onChanged: (v) => setState(() => mirror = v),
      ),
      const SizedBox(height: 8),
      FilledButton(
        onPressed: () => Get.toNamed(ZoomRoutes.inMeeting, arguments: {
          ...(Get.arguments as Map? ?? const {}),
          'joinMuted': !micOn,
          'joinVideoOff': !videoOn,
        }),
        style: FilledButton.styleFrom(
          backgroundColor: ZoomTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size(double.infinity, 0),
        ),
        child: const Text('Join now', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    ]),
  );

  Widget _dropdown(String label, String value, List<String> opts, ValueChanged<String> onChanged) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: ZoomTheme.textMuted, fontSize: 12)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: ZoomTheme.surface2, borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value, isExpanded: true,
            dropdownColor: ZoomTheme.surface2,
            style: const TextStyle(color: ZoomTheme.text),
            items: opts.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
            onChanged: (v) => onChanged(v!),
          ),
        ),
      ),
    ]);
}
