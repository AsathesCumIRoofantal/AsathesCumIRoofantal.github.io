import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../in_meeting/zoom_meeting_controller.dart';
class ReconnectBanner extends GetView<ZoomMeetingController> {
  const ReconnectBanner({super.key});
  @override Widget build(BuildContext c)=>Obx(() {
    final s = controller.connection.value;
    if (s == 'connected') return const SizedBox.shrink();
    return Container(width: double.infinity, color: s=='failed'?Colors.red:Colors.orange,
      padding: const EdgeInsets.all(8),
      child: Center(child: Text(s=='failed'?'Disconnected — tap to retry':'Reconnecting…',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))));
  });
}
