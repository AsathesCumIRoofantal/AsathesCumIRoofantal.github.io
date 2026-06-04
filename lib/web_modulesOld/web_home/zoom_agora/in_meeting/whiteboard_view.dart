import 'package:flutter/material.dart';
class WhiteboardView extends StatelessWidget {
  const WhiteboardView({super.key});
  @override Widget build(BuildContext c)=>Container(color: Colors.white,
    child: const Center(child: Text('Whiteboard — TODO: embed Agora Interactive Whiteboard / tldraw',
      style: TextStyle(color: Colors.black54))));
}
