import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';

class ZoomHomeView extends StatelessWidget {
  const ZoomHomeView({super.key});
  Widget _tile(IconData i, String label, Color c, VoidCallback onTap) => InkWell(
    onTap: onTap, borderRadius: BorderRadius.circular(16),
    child: Container(width: 160, height: 140,
      decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width:56,height:56,decoration:BoxDecoration(color:c,shape:BoxShape.circle),
          child: Icon(i, color: Colors.white)),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ])));
  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: const Color(0xFF1C1C1E),
    appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Meet'),
      actions:[IconButton(icon: const Icon(Icons.settings), onPressed: ()=>Get.toNamed(ZoomRoutes.settings))]),
    body: Center(child: Wrap(spacing:16,runSpacing:16, children:[
      _tile(Icons.videocam,        'New Meeting', const Color(0xFFFF9F0A), ()=>Get.toNamed(ZoomRoutes.devicePreview, arguments:{'mode':'instant'})),
      _tile(Icons.add_box_outlined,'Join',        const Color(0xFF0A84FF), ()=>Get.toNamed(ZoomRoutes.join)),
      _tile(Icons.event,           'Schedule',    const Color(0xFF30D158), ()=>Get.toNamed(ZoomRoutes.schedule)),
      _tile(Icons.screen_share,    'Share Screen',const Color(0xFFBF5AF2), ()=>Get.toNamed(ZoomRoutes.devicePreview, arguments:{'mode':'share'})),
    ])),
  );
}
