import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class ParticipantsPanel extends GetView<ZoomMeetingController> {
  const ParticipantsPanel({super.key});
  @override Widget build(BuildContext c){
    return Container(width:340, color: const Color(0xFF2C2C2E),
      child: Column(children:[
        const ListTile(title: Text('Participants', style: TextStyle(color: Colors.white))),
        Obx(()=>controller.waiting.isEmpty?const SizedBox.shrink(): ExpansionTile(
          collapsedTextColor: Colors.amber, textColor: Colors.amber,
          title: Text('Waiting (${controller.waiting.length})'),
          children: controller.waiting.map((p)=>ListTile(
            title: Text(p.name, style: const TextStyle(color: Colors.white)),
            trailing: Wrap(children:[
              TextButton(onPressed: ()=>controller.admit(p.uid), child: const Text('Admit')),
              TextButton(onPressed: ()=>controller.waiting.remove(p),  child: const Text('Deny')),
            ]))).toList())),
        Expanded(child: Obx(()=>ListView(children: controller.participants.values.map((p)=>ListTile(
          leading: CircleAvatar(child: Text(p.name.characters.first)),
          title: Text(p.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(p.role.name, style: const TextStyle(color: Colors.white54)),
          trailing: Wrap(spacing:4, children:[
            if (p.handRaised) const Icon(Icons.front_hand, color: Colors.amber, size: 18),
            Icon(p.audioMuted?Icons.mic_off:Icons.mic, color: p.audioMuted?Colors.red:Colors.greenAccent, size: 18),
            Icon(p.videoOff?Icons.videocam_off:Icons.videocam, color: Colors.white70, size: 18),
            PopupMenuButton<String>(icon: const Icon(Icons.more_vert, color: Colors.white70),
              onSelected:(v){switch(v){
                case 'pin': controller.togglePin(p.uid); break;
                case 'spot': controller.toggleSpotlight(p.uid); break;
                case 'co':  controller.makeCoHost(p.uid); break;
                case 'host':controller.transferHost(p.uid); break;
                case 'kick':controller.removeParticipant(p.uid); break;
              }},
              itemBuilder:(_)=>const [
                PopupMenuItem(value:'pin', child:Text('Pin')),
                PopupMenuItem(value:'spot',child:Text('Spotlight for everyone')),
                PopupMenuItem(value:'co',  child:Text('Make co-host')),
                PopupMenuItem(value:'host',child:Text('Make host')),
                PopupMenuItem(value:'kick',child:Text('Remove from meeting')),
              ]),
          ]))).toList()))),
        ButtonBar(children:[
          TextButton(onPressed: ()=>controller.muteAll(), child: const Text('Mute all')),
          TextButton(onPressed: ()=>controller.lockMeeting(!controller.isLocked.value), child: const Text('Lock')),
        ]),
      ]));
  }
}
