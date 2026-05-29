import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../in_meeting/zoom_meeting_controller.dart';
class ReactionOverlay extends GetView<ZoomMeetingController> {
  const ReactionOverlay({super.key});
  @override Widget build(BuildContext c)=>Obx(()=>Stack(children: controller.floatingReactions.map((r){
    final age = DateTime.now().millisecondsSinceEpoch - r.$3;
    final t = (age/10000).clamp(0.0,1.0);
    return Positioned(bottom: 80 + t*300, left: 40 + (r.$1 % 7)*40,
      child: Opacity(opacity: 1-t, child: Text(r.$2, style: const TextStyle(fontSize: 36))));
  }).toList()));
}
