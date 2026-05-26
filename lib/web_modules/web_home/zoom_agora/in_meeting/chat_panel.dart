import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/chat_message.dart';
import 'zoom_meeting_controller.dart';
class ChatPanel extends GetView<ZoomMeetingController> {
  const ChatPanel({super.key});
  @override Widget build(BuildContext c){
    final input = TextEditingController();
    return Container(width:340, color: const Color(0xFF2C2C2E),
      child: Column(children:[
        const ListTile(title: Text('Chat', style: TextStyle(color: Colors.white))),
        Expanded(child: Obx(()=>ListView.builder(itemCount: controller.chat.length, itemBuilder:(_,i){
          final m=controller.chat[i];
          return ListTile(dense:true,
            title: Text('${m.fromName}${m.scope==ChatScope.direct?' (DM)':''}',
              style: const TextStyle(color: Colors.white70, fontSize:12)),
            subtitle: Text(m.text, style: const TextStyle(color: Colors.white)));
        }))),
        Padding(padding: const EdgeInsets.all(8),
          child: Row(children:[
            IconButton(icon: const Icon(Icons.attach_file, color: Colors.white70), onPressed:(){/*TODO: file picker*/}),
            IconButton(icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white70), onPressed:(){/*TODO: emoji*/}),
            Expanded(child: TextField(controller: input,
              style: const TextStyle(color: Colors.white),
              onChanged:(_)=>controller.rtm.sendTyping(0),
              decoration: const InputDecoration(hintText:'Type message…', border: InputBorder.none, hintStyle: TextStyle(color: Colors.white38)))),
            IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed:(){
              if (input.text.trim().isEmpty) return;
              final m = ChatMessage(id:'${DateTime.now().millisecondsSinceEpoch}', fromUid:0, fromName:'You',
                text: input.text, sentAt: DateTime.now());
              controller.chat.add(m); controller.rtm.sendMessage(m); input.clear();
            }),
          ])),
      ]));
  }
}
