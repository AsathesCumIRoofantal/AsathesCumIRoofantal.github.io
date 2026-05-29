import 'package:flutter/material.dart';
import 'package:get/get.dart';
class VirtualBgPicker extends StatelessWidget {
  const VirtualBgPicker({super.key});
  static const presets = ['None','Blur Low','Blur High','Office','Beach','Galaxy','Custom…'];
  @override Widget build(BuildContext c)=>AlertDialog(
    backgroundColor: const Color(0xFF2C2C2E),
    title: const Text('Background & Effects', style: TextStyle(color: Colors.white)),
    content: SizedBox(width:520, child: Wrap(spacing:12,runSpacing:12,
      children: presets.map((p)=>InkWell(onTap: ()=>Get.back(result:p),
        child: Container(width:140,height:84,alignment: Alignment.center,
          decoration: BoxDecoration(gradient: const LinearGradient(colors:[Color(0xFF3A3A3C),Color(0xFF1C1C1E)]),
            borderRadius: BorderRadius.circular(8)),
          child: Text(p, style: const TextStyle(color: Colors.white))))).toList())),
  );
}
