import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../in_meeting/zoom_meeting_controller.dart';
import '../widgets/backend_toggle.dart';
import '../widgets/zoom_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const sections = [
    'General',
    'Video',
    'Audio',
    'Share Screen',
    'Background',
    'Recording',
    'Profile',
    'Statistics',
    'Keyboard Shortcuts',
    'Accessibility',
    'Feedback',
  ];

  // Dropdown items get an explicit color rather than relying on ambient
  // text style — the DropdownButton's closed-state face renders these
  // exact widgets directly, and an unstyled Text here previously picked up
  // whatever the *host* app's theme considered "default" text color. On a
  // light host theme that's near-black, which on this screen's near-black
  // background made the selected value effectively invisible.
  DropdownMenuItem<String> _item(String e) => DropdownMenuItem(
    value: e,
    child: Text(e, style: const TextStyle(color: ZoomTheme.text)),
  );

  @override
  Widget build(BuildContext c) {
    final ctl = Get.put(ZoomMeetingController(), permanent: true);
    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      appBar: AppBar(
        backgroundColor: ZoomTheme.surface,
        foregroundColor: ZoomTheme.text,
        title: const Text('Settings'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 220,
            child: ListView(
              children: sections
                  .map((s) => ListTile(title: Text(s, style: ZoomTheme.body)))
                  .toList(),
            ),
          ),
          const VerticalDivider(width: 1, color: ZoomTheme.stroke),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Obx(
                  () => SwitchListTile(
                    title: Text('HD video', style: ZoomTheme.body),
                    value: ctl.hdVideo.value,
                    onChanged: (v) => ctl.hdVideo.value = v,
                    activeColor: ZoomTheme.primary,
                  ),
                ),
                Obx(
                  () => SwitchListTile(
                    title: Text('Mirror my video', style: ZoomTheme.body),
                    value: ctl.mirror.value,
                    onChanged: (v) => ctl.mirror.value = v,
                    activeColor: ZoomTheme.primary,
                  ),
                ),
                Obx(
                  () => SwitchListTile(
                    title: Text('Adjust for low light', style: ZoomTheme.body),
                    value: ctl.lowLightFix.value,
                    onChanged: (v) => ctl.lowLightFix.value = v,
                    activeColor: ZoomTheme.primary,
                  ),
                ),
                Obx(
                  () => SwitchListTile(
                    title: Text('Original sound', style: ZoomTheme.body),
                    value: ctl.originalSound.value,
                    onChanged: (v) => ctl.originalSound.value = v,
                    activeColor: ZoomTheme.primary,
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: Text('Noise suppression', style: ZoomTheme.body),
                    trailing: DropdownButton<String>(
                      value: ctl.noiseSuppression.value,
                      dropdownColor: ZoomTheme.surface2,
                      items: [
                        'off',
                        'auto',
                        'low',
                        'med',
                        'high',
                      ].map(_item).toList(),
                      onChanged: (v) => ctl.noiseSuppression.value = v!,
                    ),
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: Text('Touch-up', style: ZoomTheme.body),
                    subtitle: Slider(
                      value: ctl.touchUp.value,
                      min: 0,
                      max: 1,
                      activeColor: ZoomTheme.primary,
                      inactiveColor: ZoomTheme.stroke,
                      onChanged: (v) => ctl.touchUp.value = v,
                    ),
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: Text('Theme', style: ZoomTheme.body),
                    trailing: DropdownButton<String>(
                      value: ctl.theme.value,
                      dropdownColor: ZoomTheme.surface2,
                      items: ['dark', 'light', 'system'].map(_item).toList(),
                      onChanged: (v) => ctl.theme.value = v!,
                    ),
                  ),
                ),
                const Divider(color: ZoomTheme.stroke, height: 32),
                ListTile(
                  title: Text('Real-time engine', style: ZoomTheme.body),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: BackendToggle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
