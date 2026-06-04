import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebManagementsController extends GetxController {
  final isLoading = false.obs;

  // System Health metrics for the dashboard feel
  final systemEfficiency = 94.2.obs;
  final activeSessions = 12.0.obs;
  final pendingApprovals = 7.0.obs;

  // Bento Grid Items: Define size (small, medium, large) for the layout
  final List<Map<String, dynamic>> managementHubs = [
    {
      'title': 'User Access',
      'desc': 'Manage permissions, roles, and security keys.',
      'icon': Icons.admin_panel_settings_rounded,
      'size': 'large', // Spans 2 columns
      'stat': '1,240 Users',
      'color': const Color(0xFF7C3AED),
    },
    {
      'title': 'Resource Map',
      'desc': 'Allocate assets across AIR space.',
      'icon': Icons.account_tree_rounded,
      'size': 'small',
      'stat': '84% Opt',
      'color': const Color(0xFF8B5CF6),
    },
    {
      'title': 'Cloud Storage',
      'desc': 'Monitor data quotas and archives.',
      'icon': Icons.cloud_queue_rounded,
      'size': 'small',
      'stat': '1.2 TB',
      'color': const Color(0xFF6D28D9),
    },
    {
      'title': 'System Logs',
      'desc': 'Real-time audit trails and event monitoring.',
      'icon': Icons.terminal_rounded,
      'size': 'medium', // Spans 1 column but taller
      'stat': 'Clean',
      'color': const Color(0xFF4C1D95),
    },
    {
      'title': 'Financial Hub',
      'desc': 'Manage billing, invoices, and payroll.',
      'icon': Icons.payments_rounded,
      'size': 'medium',
      'stat': 'Verified',
      'color': const Color(0xFF7C3AED),
    },
    {
      'title': 'API Gateways',
      'desc': 'Configure endpoints and rate limits.',
      'icon': Icons.api_rounded,
      'size': 'small',
      'stat': 'Active',
      'color': const Color(0xFFA78BFA),
    },
  ].obs;
}
