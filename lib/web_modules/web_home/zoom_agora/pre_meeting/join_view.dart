import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';

class ZoomJoinView extends StatefulWidget {
  const ZoomJoinView({super.key});
  @override State<ZoomJoinView> createState()=>_S();
}
class _S extends State<ZoomJoinView>{
  final id=TextEditingController(), pass=TextEditingController(), name=TextEditingController();
  bool joinAudio=true, joinVideo=true;
  @override Widget build(BuildContext c)=>Scaffold(
    backgroundColor: const Color(0xFF1C1C1E),
    appBar: AppBar(title: const Text('Join a Meeting')),
    body: Padding(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children:[
          TextField(controller:id, decoration: const InputDecoration(labelText:'Meeting ID or link')),
          TextField(controller:pass, decoration: const InputDecoration(labelText:'Passcode (optional)')),
          TextField(controller:name, decoration: const InputDecoration(labelText:'Your name')),
          const SizedBox(height:12),
          SwitchListTile(title: const Text('Don\'t connect to audio'), value:!joinAudio, onChanged:(v)=>setState(()=>joinAudio=!v)),
          SwitchListTile(title: const Text('Turn off my video'),       value:!joinVideo, onChanged:(v)=>setState(()=>joinVideo=!v)),
          const SizedBox(height:12),
          FilledButton(onPressed: ()=>Get.toNamed(ZoomRoutes.devicePreview, arguments:{
            'mode':'join','meetingId':id.text,'passcode':pass.text,'name':name.text,
            'joinAudio':joinAudio,'joinVideo':joinVideo,
          }), child: const Text('Join')),
        ]))),
  );
}
