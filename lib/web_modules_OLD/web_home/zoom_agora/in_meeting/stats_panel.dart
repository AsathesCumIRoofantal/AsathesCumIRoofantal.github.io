import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class StatsPanel extends GetView<ZoomMeetingController> {
  const StatsPanel({super.key});
  Widget _row(String k, String v)=>Padding(padding: const EdgeInsets.symmetric(vertical:4),
    child: Row(children:[Text(k, style: const TextStyle(color: Colors.white70)), const Spacer(),
      Text(v, style: const TextStyle(color: Colors.white))]));
  @override Widget build(BuildContext c)=>Container(width:300, color: const Color(0xFF2C2C2E),
    padding: const EdgeInsets.all(16),
    child: Obx(()=>Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      const Text('Statistics', style: TextStyle(color: Colors.white, fontSize: 18)),
      const Divider(color: Colors.white24),
      _row('CPU (app)',     '${controller.stats.cpuAppPct}%'),
      _row('CPU (total)',   '${controller.stats.cpuTotalPct}%'),
      _row('Send',          '${controller.stats.txKbps} kbps'),
      _row('Receive',       '${controller.stats.rxKbps} kbps'),
      _row('Jitter',        '${controller.stats.jitterMs} ms'),
      _row('Packet loss',   '${controller.stats.packetLossPct.toStringAsFixed(1)}%'),
      _row('Resolution',    controller.stats.lastResolution.value),
      _row('Codec',         controller.stats.codec.value),
    ])));
}
