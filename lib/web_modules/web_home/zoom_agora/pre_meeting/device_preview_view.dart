import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';

/// Camera/Mic/Speaker test before joining.
class DevicePreviewView extends StatefulWidget {
  const DevicePreviewView({super.key});
  @override State<DevicePreviewView> createState()=>_S();
}
class _S extends State<DevicePreviewView>{
  String camera='Default Camera', mic='Default Mic', spk='Default Speaker';
  bool mirror=true; double micLevel=0;
  // TODO: query engine.getVideoDeviceManager() + getAudioRecordingDevices()
  @override Widget build(BuildContext c)=>Scaffold(
    backgroundColor: const Color(0xFF1C1C1E),
    appBar: AppBar(title: const Text('Check your devices')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth:720),
      child: Column(children:[
        AspectRatio(aspectRatio:16/9,
          child: Container(color: Colors.black, alignment: Alignment.center,
            child: const Text('Local camera preview', style: TextStyle(color: Colors.white54)))),
        SwitchListTile(title: const Text('Mirror my video'), value:mirror, onChanged:(v)=>setState(()=>mirror=v)),
        ListTile(leading: const Icon(Icons.videocam),    title: Text(camera), trailing: const Icon(Icons.expand_more)),
        ListTile(leading: const Icon(Icons.mic),         title: Text(mic),    subtitle: LinearProgressIndicator(value: micLevel)),
        ListTile(leading: const Icon(Icons.volume_up),   title: Text(spk),
          trailing: TextButton(onPressed:(){}, child: const Text('Test'))),
        const SizedBox(height: 12),
        FilledButton(onPressed: ()=>Get.toNamed(ZoomRoutes.inMeeting, arguments: Get.arguments),
          child: const Text('Join Now')),
      ]))),
  );
}
