import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebDoctorateController extends GetxController {
  final isLoading = false.obs;

  // Mock data for PhD Research streams
  final List<Map<String, dynamic>> researchStreams = [
    {
      'domain': 'Quantum Computing',
      'level': 'Advanced',
      'description':
          'Exploring the intersection of qubit stability and algorithmic efficiency.',
      'icon': Icons.psychology,
    },
    {
      'domain': 'Artificial General Intelligence',
      'level': 'Experimental',
      'description':
          'Researching self-evolving neural networks and cognitive architectures.',
      'icon': Icons.auto_graph,
    },
    {
      'domain': 'Sustainable Energy',
      'level': 'Applied',
      'description':
          'Developing next-gen fusion containment systems and energy harvesting.',
      'icon': Icons.wb_sunny,
    },
    {
      'domain': 'Biotech & Genetics',
      'level': 'Medical',
      'description':
          'CRISPR-based gene editing for hereditary disease eradication.',
      'icon': Icons.biotech,
    },
  ].obs;

  final List<String> fundingSources = [
    'Govt Grant A-1',
    'Private Venture X',
    'University Fellowship',
    'Global Research Fund',
  ].obs;
}
