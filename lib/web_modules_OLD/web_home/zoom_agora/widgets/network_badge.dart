import 'package:flutter/material.dart';
class NetworkBadge extends StatelessWidget {
  final int quality; // 0=unknown,1=excellent…6=down
  const NetworkBadge(this.quality, {super.key});
  Color get _c => quality<=2?Colors.greenAccent:quality<=4?Colors.amber:Colors.redAccent;
  @override Widget build(BuildContext c)=>Row(mainAxisSize: MainAxisSize.min, children: List.generate(3,(i)=>
    Container(width:3,height:4+i*3.0,margin: const EdgeInsets.symmetric(horizontal:1),
      decoration: BoxDecoration(color: _c.withOpacity(i<quality?1:.3), borderRadius: BorderRadius.circular(1)))));
}
