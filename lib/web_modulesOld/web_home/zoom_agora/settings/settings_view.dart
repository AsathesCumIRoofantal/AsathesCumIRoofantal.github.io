import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../in_meeting/zoom_meeting_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const sections = ['General','Video','Audio','Share Screen','Background','Recording','Profile','Statistics','Keyboard Shortcuts','Accessibility','Feedback'];
  @override Widget build(BuildContext c){
    final ctl = Get.put(ZoomMeetingController(), permanent: true);
    return Scaffold(backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(title: const Text('Settings')),
      body: Row(children:[
        SizedBox(width:220, child: ListView(children: sections.map((s)=>ListTile(
          title: Text(s, style: const TextStyle(color: Colors.white)))).toList())),
        const VerticalDivider(width:1, color: Colors.white24),
        Expanded(child: ListView(padding: const EdgeInsets.all(24), children:[
          Obx(()=>SwitchListTile(title: const Text('HD video',           style: TextStyle(color: Colors.white)), value: ctl.hdVideo.value,       onChanged:(v)=>ctl.hdVideo.value=v)),
          Obx(()=>SwitchListTile(title: const Text('Mirror my video',    style: TextStyle(color: Colors.white)), value: ctl.mirror.value,        onChanged:(v)=>ctl.mirror.value=v)),
          Obx(()=>SwitchListTile(title: const Text('Adjust for low light',style: TextStyle(color: Colors.white)),value: ctl.lowLightFix.value,   onChanged:(v)=>ctl.lowLightFix.value=v)),
          Obx(()=>SwitchListTile(title: const Text('Original sound',     style: TextStyle(color: Colors.white)), value: ctl.originalSound.value, onChanged:(v)=>ctl.originalSound.value=v)),
          Obx(()=>ListTile(title: const Text('Noise suppression', style: TextStyle(color: Colors.white)),
            trailing: DropdownButton<String>(value: ctl.noiseSuppression.value,
              items: const ['off','auto','low','med','high'].map((e)=>DropdownMenuItem(value:e, child: Text(e))).toList(),
              onChanged:(v)=>ctl.noiseSuppression.value=v!))),
          Obx(()=>ListTile(title: const Text('Touch-up', style: TextStyle(color: Colors.white)),
            subtitle: Slider(value: ctl.touchUp.value, min:0,max:1, onChanged:(v)=>ctl.touchUp.value=v))),
          Obx(()=>ListTile(title: const Text('Theme', style: TextStyle(color: Colors.white)),
            trailing: DropdownButton<String>(value: ctl.theme.value,
              items: const ['dark','light','system'].map((e)=>DropdownMenuItem(value:e, child: Text(e))).toList(),
              onChanged:(v)=>ctl.theme.value=v!))),
        ])),
      ]));
  }
}
