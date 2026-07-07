import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';

/// Lobby screen: camera/mic preview, device selection, network check,
/// pre-join checklist, and a "Join now" button that only enables once
/// the checklist is satisfied (or the user taps "Join anyway").
class DevicePreviewView extends StatefulWidget {
  const DevicePreviewView({super.key});
  @override
  State<DevicePreviewView> createState() => _S();
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

  // Checklist state
  bool _speakerTested  = false;
  bool _micEverActive  = false;
  String _networkStatus = 'checking'; // 'checking' | 'good' | 'poor'

  bool get _checklistDone =>
      videoOn && _micEverActive && _speakerTested && _networkStatus != 'checking';

  static const _cameras = ['FaceTime HD Camera', 'Logitech C920', 'OBS Virtual Camera'];
  static const _mics    = ['MacBook Pro Microphone', 'AirPods Pro', 'Blue Yeti'];
  static const _spks    = ['External Speakers', 'AirPods Pro', 'Studio Display'];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _t = Timer.periodic(const Duration(milliseconds: 140), (_) {
      if (!mounted) return;
      setState(() {
        micLevel = micOn ? (rng.nextDouble() * .8 + .1) : 0;
        if (micOn && micLevel > 0.05) _micEverActive = true;
      });
    });
    // Simulate network check after 1.5 s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _networkStatus = 'good');
    });
  }

  @override
  void dispose() { _t?.cancel(); super.dispose(); }

  void _join() {
    Get.toNamed(ZoomRoutes.inMeeting, arguments: {
      ...(Get.arguments as Map? ?? const {}),
      'joinMuted':    !micOn,
      'joinVideoOff': !videoOn,
    });
  }

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
        child: TextButton.icon(onPressed: () => setState(() => _speakerTested = true),
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
      const SizedBox(height: 12),
      // ── Pre-join checklist ────────────────────────────────────────
      _ChecklistRow(label: 'Camera',      done: videoOn),
      _ChecklistRow(label: 'Microphone',  done: _micEverActive),
      _ChecklistRow(label: 'Speaker',     done: _speakerTested),
      _ChecklistRow(label: 'Network',
        done: _networkStatus == 'good',
        pending: _networkStatus == 'checking',
        pendingLabel: 'Checking…',
      ),
      const SizedBox(height: 12),
      FilledButton(
        onPressed: _checklistDone ? _join : null,
        style: FilledButton.styleFrom(
          backgroundColor: ZoomTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size(double.infinity, 0),
        ),
        child: const Text('Join now', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      const SizedBox(height: 8),
      Center(
        child: TextButton(
          onPressed: _join,
          child: const Text('Join anyway', style: TextStyle(color: ZoomTheme.textMuted, fontSize: 12)),
        ),
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

/// One row in the pre-join checklist — green tick when done, amber spinner
/// while pending, grey dot when not yet satisfied.
class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.label,
    required this.done,
    this.pending = false,
    this.pendingLabel,
  });
  final String label;
  final bool done;
  final bool pending;
  final String? pendingLabel;

  @override
  Widget build(BuildContext context) {
    final Widget icon;
    final Color labelColor;

    if (done) {
      icon = const Icon(Icons.check_circle_rounded, color: ZoomTheme.success, size: 16);
      labelColor = ZoomTheme.success;
    } else if (pending) {
      icon = const SizedBox(
        width: 16, height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: ZoomTheme.warn),
      );
      labelColor = ZoomTheme.warn;
    } else {
      icon = const Icon(Icons.radio_button_unchecked, color: ZoomTheme.textMuted, size: 16);
      labelColor = ZoomTheme.textMuted;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        icon,
        const SizedBox(width: 8),
        Text(
          done ? label : (pending ? (pendingLabel ?? label) : label),
          style: TextStyle(color: labelColor, fontSize: 12),
        ),
      ]),
    );
  }
}
