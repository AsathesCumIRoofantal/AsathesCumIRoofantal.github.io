import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class BreakoutPanel extends GetView<ZoomMeetingController> {
  const BreakoutPanel({super.key});
  @override Widget build(BuildContext c){
    return Container(width:360, color: const Color(0xFF2C2C2E), child: Column(children:[
      const ListTile(title: Text('Breakout Rooms', style: TextStyle(color: Colors.white))),
      ButtonBar(children:[
        TextButton(onPressed: ()=>controller.createBreakouts(3, auto:true),  child: const Text('Create 3 (auto)')),
        TextButton(onPressed: ()=>controller.createBreakouts(2, auto:false), child: const Text('Create 2 (manual)')),
      ]),
      Expanded(child: Obx(()=>ListView(children: controller.breakouts.map((r)=>ExpansionTile(
        collapsedTextColor: Colors.white, textColor: Colors.white,
        title: Text('${r.name} (${r.participants.length})'),
        children: r.participants.map((uid)=>ListTile(
          title: Text('uid $uid', style: const TextStyle(color: Colors.white70)))).toList(),
      )).toList()))),
      Padding(padding: const EdgeInsets.all(8), child: Row(children:[
        Expanded(child: TextField(decoration: const InputDecoration(hintText:'Broadcast message…', hintStyle: TextStyle(color: Colors.white38)),
          style: const TextStyle(color: Colors.white),
          onSubmitted: controller.broadcastToBreakouts)),
        IconButton(onPressed: ()=>controller.closeBreakouts(), icon: const Icon(Icons.close, color: Colors.white)),
      ])),
    ]));
  }
}
