import 'package:flutter/material.dart';

class EnhancedViewWrapper extends StatelessWidget {
  final Widget child;
  const EnhancedViewWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [child],
    );
  }
}
