import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebUtilitiesGuestController extends GetxController {
  final searchQuery = ''.obs;
  final isGuestMode = true.obs;

  // Mock data for guest-accessible utilities
  final List<Map<String, dynamic>> guestTools = [
    {
      'name': 'Unit Converter',
      'desc': 'Instant conversion for metric, imperial, and orbital units.',
      'icon': Icons.swap_horiz_rounded,
      'category': 'General',
      'complexity': 'Easy',
    },
    {
      'name': 'AI Text Analyzer',
      'desc': 'Quick sentiment and structural analysis for short texts.',
      'icon': Icons.psychology_alt_rounded,
      'category': 'AI',
      'complexity': 'Medium',
    },
    {
      'name': 'Currency Live-Track',
      'desc': 'Real-time global exchange rates with projection curves.',
      'icon': Icons.currency_exchange_rounded,
      'category': 'Finance',
      'complexity': 'Easy',
    },
    {
      'name': 'Network Speed Test',
      'desc': 'Analyze your current latency and bandwidth throughput.',
      'icon': Icons.speed_rounded,
      'category': 'System',
      'complexity': 'Medium',
    },
    {
      'name': 'QR Generator',
      'desc': 'Create secure, themed QR codes for instant sharing.',
      'icon': Icons.qr_code_scanner_rounded,
      'category': 'Utility',
      'complexity': 'Easy',
    },
    {
      'name': 'Color Palette Picker',
      'desc': 'Extract professional palettes from any uploaded image.',
      'icon': Icons.color_lens_rounded,
      'category': 'Design',
      'complexity': 'Easy',
    },
  ].obs;

  void updateSearch(String val) => searchQuery.value = val;
}
