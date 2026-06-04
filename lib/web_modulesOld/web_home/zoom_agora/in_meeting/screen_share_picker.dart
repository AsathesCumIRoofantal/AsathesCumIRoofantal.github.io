import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ScreenSharePicker extends StatelessWidget {
  const ScreenSharePicker({super.key});
  Widget _o(IconData i,String t,VoidCallback onTap)=>InkWell(onTap:onTap,
    child: Container(width:140,height:120,margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFF3A3A3C), borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(i,color:Colors.white,size:36),
        const SizedBox(height:8), Text(t, style: const TextStyle(color: Colors.white))])));
  @override Widget build(BuildContext c)=>AlertDialog(
    backgroundColor: const Color(0xFF2C2C2E),
    title: const Text('Share', style: TextStyle(color: Colors.white)),
    content: SizedBox(width: 600, child: Wrap(children:[
      _o(Icons.desktop_windows,'Entire Screen',()=>Get.back(result:'screen')),
      _o(Icons.web,             'Browser Tab',  ()=>Get.back(result:'tab')),
      _o(Icons.window,          'App Window',   ()=>Get.back(result:'window')),
      _o(Icons.brush,           'Whiteboard',   ()=>Get.back(result:'whiteboard')),
      _o(Icons.phone_iphone,    'iPhone/iPad',  ()=>Get.back(result:'phone')),
      _o(Icons.crop,            'Portion',      ()=>Get.back(result:'portion')),
    ])),
    actions:[Row(children:const [
      Icon(Icons.volume_up, color: Colors.white70, size: 16), SizedBox(width:4),
      Text('Share computer sound', style: TextStyle(color: Colors.white70)),
      Spacer(),
      Icon(Icons.movie, color: Colors.white70, size: 16), SizedBox(width:4),
      Text('Optimize for video', style: TextStyle(color: Colors.white70)),
    ])],
  );
}
