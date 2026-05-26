import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class ReactionsBar extends GetView<ZoomMeetingController> {
  const ReactionsBar({super.key});
  static const emojis = ['👏','❤️','😂','😮','🎉','👍','👎','☕','🙋'];
  @override Widget build(BuildContext c)=>Container(
    padding: const EdgeInsets.symmetric(horizontal:12,vertical:8),
    decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(28)),
    child: Wrap(spacing:8, children: emojis.map((e)=>IconButton(
      icon: Text(e, style: const TextStyle(fontSize:22)),
      onPressed: ()=>controller.react(0,e))).toList()));
}
