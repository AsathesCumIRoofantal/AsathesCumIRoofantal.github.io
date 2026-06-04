import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLiableController extends GetxController {
  final List<Map<String, dynamic>> duties = [
    {
      'title': 'Sliver Maintenance',
      'weight': 'High',
      'impact': 'Systemic',
      'color': const Color(0xFFEC4899),
    },
    {
      'title': 'Peer Review',
      'weight': 'Medium',
      'impact': 'Collaborative',
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Axiom Adherence',
      'weight': 'Critical',
      'impact': 'Ethical',
      'color': const Color(0xFFB91C1C),
    },
  ].obs;
}
