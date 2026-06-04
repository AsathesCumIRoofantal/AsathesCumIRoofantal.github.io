import 'package:flutter/material.dart';
class WaitingRoomView extends StatelessWidget {
  const WaitingRoomView({super.key});
  @override Widget build(BuildContext c)=>Scaffold(
    backgroundColor: const Color(0xFF1C1C1E),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children:[
      const CircularProgressIndicator(),
      const SizedBox(height: 20),
      const Text('Please wait, the host will let you in soon.', style: TextStyle(color: Colors.white)),
      const SizedBox(height: 8),
      const Text('Air Space Industrial Stream', style: TextStyle(color: Colors.white54)),
    ])),
  );
}
