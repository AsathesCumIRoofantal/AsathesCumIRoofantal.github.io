import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/qa_item.dart';
import 'zoom_meeting_controller.dart';

class QAPanel extends GetView<ZoomMeetingController> {
  const QAPanel({super.key});
  @override
  Widget build(BuildContext c) {
    final input = TextEditingController();
    return Container(width:340, color: const Color(0xFF2C2C2E),
      child: Column(children:[
        const ListTile(title: Text('Q & A', style: TextStyle(color: Colors.white))),
        Expanded(child: Obx(()=>ListView(children: controller.qa.where((q)=>!q.dismissed).map((q){
          final iUpvoted = q.upvotes.contains(controller.localUid);
          return ListTile(
            title: Text(q.question, style: const TextStyle(color: Colors.white)),
            subtitle: Text(q.answerText ?? '— unanswered —', style: const TextStyle(color: Colors.white54)),
            trailing: Wrap(children:[
              Text('${q.upvotes.length}', style: const TextStyle(color: Colors.white70)),
              IconButton(
                icon: Icon(iUpvoted ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                  color: iUpvoted ? Colors.blueAccent : Colors.white70),
                onPressed: () => controller.toggleUpvoteQuestion(q.id),
              ),
              IconButton(icon: const Icon(Icons.reply, color: Colors.white70),
                onPressed: ()=>controller.answerQuestion(q.id, 'Answered live')),
            ]),
          );
        }).toList()))),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(child: TextField(
              controller: input,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ask a question…', hintStyle: TextStyle(color: Colors.white38),
              ),
              onSubmitted: (_) => _submit(input),
            )),
            IconButton(icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _submit(input)),
          ]),
        ),
      ]));
  }

  void _submit(TextEditingController input) {
    final text = input.text.trim();
    if (text.isEmpty) return;
    controller.submitQuestion(QAItem(
      id: '${controller.localUid}_${DateTime.now().microsecondsSinceEpoch}',
      fromUid: controller.localUid,
      fromName: controller.localName,
      question: text,
    ));
    input.clear();
  }
}
