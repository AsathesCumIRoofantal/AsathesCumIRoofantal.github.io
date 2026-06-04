import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLiveFullController extends GetxController {
  final List<Map<String, dynamic>> horizons = [
    {
      'title': 'The Explorer',
      'desc': 'Visiting every Node in the AIR Space.',
      'color': const Color(0xFFEC4899),
    },
    {
      'title': 'The Polymath',
      'desc': 'Mastering 5+ diverse lapped skills.',
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'The Zen Master',
      'desc': 'Achieving 100% stability index in Wisdom.',
      'color': const Color(0xFFF43F5E),
    },
  ].obs;
}
