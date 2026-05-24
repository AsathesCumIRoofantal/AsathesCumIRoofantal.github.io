import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebShareCareController extends GetxController {
  final List<Map<String, dynamic>> empathyNodes = [
    {
      'target': 'Community A',
      'action': 'Knowledge Share',
      'points': 450,
      'icon': Icons.volunteer_activism,
    },
    {
      'target': 'Peer Group B',
      'action': 'Emotional Support',
      'points': 800,
      'icon': Icons.favorite,
    },
    {
      'target': 'AIR Network',
      'action': 'Sliver Optimization',
      'points': 300,
      'icon': Icons.share,
    },
  ].obs;
}
