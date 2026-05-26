import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class QAPanel extends GetView<ZoomMeetingController> {
  const QAPanel({super.key});
  @override Widget build(BuildContext c)=>Container(width:340, color: const Color(0xFF2C2C2E),
    child: Column(children:[
      const ListTile(title: Text('Q & A', style: TextStyle(color: Colors.white))),
      Expanded(child: Obx(()=>ListView(children: controller.qa.where((q)=>!q.dismissed).map((q)=>ListTile(
        title: Text(q.question, style: const TextStyle(color: Colors.white)),
        subtitle: Text(q.answerText ?? '— unanswered —', style: const TextStyle(color: Colors.white54)),
        trailing: Wrap(children:[
          Text('${q.upvotes.length}', style: const TextStyle(color: Colors.white70)),
          IconButton(icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.white70),
            onPressed: ()=>q.upvotes.add(0)),
          IconButton(icon: const Icon(Icons.reply, color: Colors.white70),
            onPressed: ()=>controller.answerQuestion(q.id, 'Answered live')),
        ]))).toList()))),
    ]));
}
