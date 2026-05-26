import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class CaptionsOverlay extends GetView<ZoomMeetingController> {
  const CaptionsOverlay({super.key});
  @override Widget build(BuildContext c)=>Obx(()=>!controller.captionsOn.value
    ? const SizedBox.shrink()
    : Positioned(bottom:120,left:0,right:0, child: Center(child: Container(
        padding: const EdgeInsets.symmetric(horizontal:16, vertical:8),
        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
        child: Text(controller.liveCaption.value, style: const TextStyle(color: Colors.white, fontSize: 18))))));
}
