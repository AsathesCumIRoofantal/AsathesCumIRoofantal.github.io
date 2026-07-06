import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';
import '../services/meeting_service.dart';
import '../services/current_user.dart';

/// Pre-meeting join screen — recent meetings on the left, form on the right.
class ZoomJoinView extends StatefulWidget {
  const ZoomJoinView({super.key});
  @override State<ZoomJoinView> createState() => _S();
}

class _S extends State<ZoomJoinView> {
  final id = TextEditingController(text: '824-731-9056');
  final pass = TextEditingController();
  final name = TextEditingController(text: 'Aarav Sharma');
  bool joinAudio = true, joinVideo = true;

  static const _recent = [
    ('Product weekly sync', '824-731-9056', 'Today, 10:00'),
    ('1:1 with Priya',      '901-118-2003', 'Today, 12:30'),
    ('Q3 roadmap review',   '553-220-7711', 'Today, 16:00'),
  ];

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: ZoomTheme.bg,
    appBar: AppBar(
      backgroundColor: ZoomTheme.bg, elevation: 0,
      title: Text('Join a meeting', style: ZoomTheme.h3),
      iconTheme: const IconThemeData(color: ZoomTheme.text),
    ),
    body: LayoutBuilder(builder: (c, cons) {
      final wide = cons.maxWidth >= 900;
      final form = _form(c);
      final recent = _recentList();
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 16),
        child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 5, child: recent),
              const SizedBox(width: 24),
              Expanded(flex: 6, child: form),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [form, const SizedBox(height: 16), recent]),
      );
    }),
  );

  Widget _form(BuildContext c) => Container(
    padding: const EdgeInsets.all(24),
    decoration: ZoomTheme.card(r: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('Join with meeting ID', style: ZoomTheme.h2),
      const SizedBox(height: 4),
      Text('Paste an invite link or enter the 11-digit meeting ID.', style: ZoomTheme.muted),
      const SizedBox(height: 20),
      _input(id, 'Meeting ID or link', icon: Icons.tag),
      const SizedBox(height: 12),
      _input(pass, 'Passcode (optional)', icon: Icons.lock_outline, obscure: true),
      const SizedBox(height: 12),
      _input(name, 'Your display name', icon: Icons.badge_outlined),
      const SizedBox(height: 20),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text("Don't connect to audio", style: TextStyle(color: ZoomTheme.text)),
        value: !joinAudio, activeColor: ZoomTheme.primary,
        onChanged: (v) => setState(() => joinAudio = !v),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Turn off my video', style: TextStyle(color: ZoomTheme.text)),
        value: !joinVideo, activeColor: ZoomTheme.primary,
        onChanged: (v) => setState(() => joinVideo = !v),
      ),
      const SizedBox(height: 12),
      FilledButton(
        onPressed: () => _submit(c),
        style: FilledButton.styleFrom(
          backgroundColor: ZoomTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Join meeting', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    ]),
  );

  bool _submitting = false;

  Future<void> _submit(BuildContext c) async {
    if (_submitting) return;
    if (!CurrentUser.isSignedIn) {
      Get.snackbar('Sign in required', 'Log in before joining a meeting.');
      return;
    }
    if (id.text.trim().isEmpty) {
      Get.snackbar('Meeting ID required', 'Paste an invite link or enter the meeting ID.');
      return;
    }
    setState(() => _submitting = true);
    try {
      await CurrentUser.ensureProfileLoaded();
      final meeting = await MeetingService().findJoinable(id.text.trim(), passcode: pass.text.trim());
      if (meeting == null) {
        Get.snackbar('Meeting not found', "It may have ended, been cancelled, or the ID is wrong.");
        return;
      }
      Get.toNamed(ZoomRoutes.devicePreview, arguments: {
        'mode': 'join',
        'channelId': meeting.channelName,
        'meetingRowId': meeting.id,
        'displayName': name.text.trim().isEmpty ? CurrentUser.name : name.text.trim(),
        'demoMode': false,
        'joinAudio': joinAudio,
        'joinVideo': joinVideo,
      });
    } on MeetingPasscodeException {
      Get.snackbar('Wrong passcode', 'Check the passcode and try again.');
    } catch (e) {
      Get.snackbar('Could not join', e.toString());
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _input(TextEditingController c, String label, {IconData? icon, bool obscure = false}) =>
    TextField(
      controller: c, obscureText: obscure,
      style: const TextStyle(color: ZoomTheme.text),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ZoomTheme.textMuted),
        prefixIcon: icon != null ? Icon(icon, color: ZoomTheme.textMuted, size: 18) : null,
        filled: true, fillColor: ZoomTheme.surface2,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ZoomTheme.primary, width: 1.4),
        ),
      ),
    );

  Widget _recentList() => Container(
    padding: const EdgeInsets.all(20),
    decoration: ZoomTheme.card(r: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Recent meetings', style: ZoomTheme.h3),
      const SizedBox(height: 12),
      ..._recent.map((r) => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => setState(() => id.text = r.$2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(children: [
            Container(width: 36, height: 36,
              decoration: BoxDecoration(gradient: ZoomTheme.heroGradient,
                borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.videocam, color: Colors.white, size: 18)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.$1, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
              Text('${r.$2} · ${r.$3}', style: ZoomTheme.muted),
            ])),
            const Icon(Icons.chevron_right, color: ZoomTheme.textMuted),
          ]),
        ),
      )),
    ]),
  );
}
