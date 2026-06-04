import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/poll.dart';
import 'zoom_meeting_controller.dart';
class PollsPanel extends GetView<ZoomMeetingController> {
  const PollsPanel({super.key});
  @override Widget build(BuildContext c)=>Container(width:340, color: const Color(0xFF2C2C2E),
    child: Column(children:[
      const ListTile(title: Text('Polls / Quizzes', style: TextStyle(color: Colors.white))),
      ListTile(leading: const Icon(Icons.add_circle, color: Colors.greenAccent),
        title: const Text('Create poll', style: TextStyle(color: Colors.white)),
        onTap: (){
          controller.launchPoll(Poll(id:'p${DateTime.now().millisecondsSinceEpoch}',
            question:'Sample question?', type: PollType.single,
            options:[PollOption('a','Option A'), PollOption('b','Option B')]));
        }),
      Expanded(child: Obx(()=>ListView(children: controller.polls.map((p)=>ExpansionTile(
        collapsedTextColor: Colors.white, textColor: Colors.white,
        title: Text(p.question),
        subtitle: Text(p.closed?'Closed':'Live', style: TextStyle(color: p.closed?Colors.white54:Colors.greenAccent)),
        children:[
          ...p.options.map((o)=>ListTile(
            title: Text(o.text, style: const TextStyle(color: Colors.white70)),
            trailing: Text('${o.votes}', style: const TextStyle(color: Colors.white)))),
          TextButton(onPressed: ()=>controller.closePoll(p.id), child: const Text('End poll')),
        ])).toList()))),
    ]));
}
