import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebRewardsController extends GetxController {
  // --- Balance Metrics ---
  final totalCredits = 12850.0.obs;
  final redeemablePoints = 4200.obs;
  final tierProgress = 0.75.obs; // 75% to next tier
  final currentTier = 'Platinum'.obs;

  // --- Reward Store (Redemption Gallery) ---
  final List<Map<String, dynamic>> availableRewards = [
    {
      'name': 'AI Tool Premium',
      'cost': 1200,
      'icon': Icons.auto_awesome,
      'desc': '1 Month of Unlimited AI Analysis',
      'color': const Color(0xFF7C3AED),
    },
    {
      'name': 'Profile Aura Glow',
      'cost': 500,
      'icon': Icons.brightness_high,
      'desc': 'Custom holographic glow for your profile',
      'color': const Color(0xFFC084FC),
    },
    {
      'name': 'Advanced Course',
      'cost': 3000,
      'icon': Icons.school,
      'desc': 'Sliver Architecture Masterclass',
      'color': const Color(0xFF8B5CF6),
    },
    {
      'name': 'Priority Support',
      'cost': 800,
      'icon': Icons.support_agent,
      'desc': '24h priority response for 1 week',
      'color': const Color(0xFF6D28D9),
    },
  ].obs;

  // --- Credit History (The Stream) ---
  final List<Map<String, dynamic>> creditHistory = [
    {
      'action': 'Daily Check-in',
      'amount': 50.0,
      'type': 'gain',
      'date': 'Today',
    },
    {
      'action': 'Collaborated on "Air-Space"',
      'amount': 200.0,
      'type': 'gain',
      'date': 'Yesterday',
    },
    {
      'action': 'Redeemed Profile Aura',
      'amount': -500.0,
      'type': 'loss',
      'date': '2 days ago',
    },
    {
      'action': 'Contribution to Wisdom',
      'amount': 150.0,
      'type': 'gain',
      'date': '3 days ago',
    },
  ].obs;
}
