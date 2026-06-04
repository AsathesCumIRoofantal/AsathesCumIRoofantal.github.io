import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebReviseController extends GetxController {
  final List<Map<String, dynamic>> cycles = [
    {
      'step': 'Drafting',
      'desc': 'The raw expression of an idea.',
      'status': 'Completed',
      'color': Colors.pink[200],
    },
    {
      'step': 'Critique',
      'desc': 'Analyzing the friction points.',
      'status': 'Current',
      'color': const Color(0xFFEC4899),
    },
    {
      'step': 'Refining',
      'desc': 'Polishing the rough edges.',
      'status': 'Pending',
      'color': Colors.grey,
    },
  ].obs;
}
