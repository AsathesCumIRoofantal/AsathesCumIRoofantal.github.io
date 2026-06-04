import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebYourBusinessController extends GetxController {
  // --- Financial Metrics ---
  final totalNetWorth = 452000.00.obs;
  final monthlyRevenue = 12400.00.obs;
  final growthRate = 14.2.obs; // percentage
  final activeVentures = 3.0.obs;

  // --- Business Assets Portfolio ---
  final List<Map<String, dynamic>> businessAssets = [
    {
      'name': 'AIR-Consultancy Group',
      'type': 'Service Agency',
      'valuation': ' \$120,000',
      'performance': 0.85, // 85%
      'status': 'Scaling',
      'color': const Color(0xFF7C3AED),
      'icon': Icons.corporate_fare_rounded,
    },
    {
      'name': 'Digitalize Hub Store',
      'type': 'E-Commerce',
      'valuation': ' \$85,000',
      'performance': 0.60, // 60%
      'status': 'Stable',
      'color': const Color(0xFFC084FC),
      'icon': Icons.storefront_rounded,
    },
    {
      'name': 'Quantum Research Lab',
      'type': 'R&D Venture',
      'valuation': ' \$247,000',
      'performance': 0.92, // 92%
      'status': 'High Growth',
      'color': const Color(0xFF8B5CF6),
      'icon': Icons.biotech_rounded,
    },
  ].obs;

  // --- Revenue Stream Data (for the chart simulation) ---
  final List<double> revenueData = [
    40.0,
    70.0,
    50.0,
    90.0,
    120.0,
    110.0,
    150.0,
  ].obs;
}
