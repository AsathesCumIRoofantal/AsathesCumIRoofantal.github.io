// ============================================================
//  AIR App – App Utilities
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  // ── Date / Time ──────────────────────────────────────
  static String formatDate(int epochMs, {String pattern = 'MMM d, yyyy'}) =>
      DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(epochMs));

  static String formatTime(int epochMs) =>
      DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(epochMs));

  static String formatDateTime(int epochMs) =>
      DateFormat('MMM d, yyyy • hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(epochMs));

  static int nowEpoch() => DateTime.now().millisecondsSinceEpoch;

  // ── File size ─────────────────────────────────────────
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // ── Avatar initials ───────────────────────────────────
  static String initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  // ── Toast / Snackbar ─────────────────────────────────
  static void showSuccess(String message) => Get.snackbar(
    '✅ Success', message, snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.withOpacity(0.9), colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );

  static void showError(String message) => Get.snackbar(
    '❌ Error', message, snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.9), colorText: Colors.white,
    duration: const Duration(seconds: 4),
  );

  static void showInfo(String message) => Get.snackbar(
    'ℹ️ Info', message, snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
  );

  // ── Validators ───────────────────────────────────────
  static bool isValidEmail(String v) =>
      RegExp(r'^[\w.]+@[\w]+\.[\w.]+$').hasMatch(v);

  static bool isValidPhone(String v) =>
      RegExp(r'^\+?[\d\s\-]{10,15}$').hasMatch(v);

  static bool isValidOtp(String v) =>
      RegExp(r'^\d{6}$').hasMatch(v);

  // ── Color from string (deterministic avatar colour) ─
  static Color colorFromString(String str) {
    final hue = str.codeUnits.fold(0, (s, c) => s + c) % 360;
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.6, 0.5).toColor();
  }
}
