// Bridges to the AccessibilityService added in android_native_addon/ via
// MethodChannel. Mouse-move is intentionally NOT forwarded natively (see
// the service's moveCursorHint doc comment) — only clicks/scroll/text are
// real actions; move only updates the on-screen cursor overlay so the
// controller sees where they're pointing before they click.
import 'package:flutter/services.dart';

class AndroidInputInjector {
  AndroidInputInjector._();
  static const _channel = MethodChannel('zoom_agora/input_injector');

  static Future<bool> isServiceEnabled() async {
    try {
      return await _channel.invokeMethod<bool>('isServiceEnabled') ?? false;
    } catch (_) {
      return false; // addon not wired into the host app yet
    }
  }

  static Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } catch (_) {}
  }

  static void mouseClick(double xNorm, double yNorm, {String button = 'left'}) {
    _channel.invokeMethod('tap', {'x': xNorm, 'y': yNorm});
  }

  static void mouseScroll(double dx, double dy) {
    _channel.invokeMethod('scroll', {'dx': dx, 'dy': dy});
  }

  static void typeText(String text) {
    _channel.invokeMethod('typeText', {'text': text});
  }

  static void sendControlKey(String name) {
    _channel.invokeMethod('sendControlKey', {'name': name});
  }
}
