// Native (non-web) input injector — dispatches to a platform-specific
// implementation. iOS is a deliberate no-op: Apple's app sandbox makes
// OS-level input injection impossible for any third-party app, not just
// this one (README already documents this; do not attempt to work around
// it with a private API, that's an App Store rejection + platform abuse).
import 'dart:io';
import 'native_control/input_injector_windows.dart';
import 'native_control/input_injector_macos.dart';
import 'native_control/input_injector_linux.dart';
import 'native_control/input_injector_android.dart';
import 'native_control/keycode_map.dart';

class WebInputInjector {
  const WebInputInjector();

  void mouseMove(double x, double y) {
    if (Platform.isWindows) {
      WindowsInputInjector.mouseMove(x, y);
    } else if (Platform.isMacOS) {
      MacOSInputInjector.mouseMove(x, y);
    } else if (Platform.isLinux) {
      LinuxInputInjector.mouseMove(x, y);
    }
    // Android: cursor position is reflected only via the on-screen
    // overlay (remote_control_overlay.dart) — see AndroidInputInjector
    // doc comment for why raw move isn't forwarded natively.
    // iOS: no-op, not possible — see file header.
  }

  void mouseClick(double x, double y, {String button = 'left'}) {
    if (Platform.isWindows) {
      WindowsInputInjector.mouseClick(x, y, button: button);
    } else if (Platform.isMacOS) {
      MacOSInputInjector.mouseClick(x, y, button: button);
    } else if (Platform.isLinux) {
      LinuxInputInjector.mouseClick(x, y, button: button);
    } else if (Platform.isAndroid) {
      AndroidInputInjector.mouseClick(x, y, button: button);
    }
  }

  void mouseScroll(double dx, double dy) {
    if (Platform.isWindows) {
      WindowsInputInjector.mouseScroll(dx, dy);
    } else if (Platform.isMacOS) {
      MacOSInputInjector.mouseScroll(dx, dy);
    } else if (Platform.isLinux) {
      LinuxInputInjector.mouseScroll(dx, dy);
    } else if (Platform.isAndroid) {
      AndroidInputInjector.mouseScroll(dx, dy);
    }
  }

  void keyEvent(int keyCode, {int modifiers = 0, String action = 'tap'}) {
    if (Platform.isWindows) {
      final vk = KeycodeMap.toWindowsVk(keyCode);
      if (vk != null) WindowsInputInjector.keyEvent(vk, modifiers: modifiers, action: action);
    } else if (Platform.isMacOS) {
      final mk = KeycodeMap.toMacKeycode(keyCode);
      if (mk != null) MacOSInputInjector.keyEvent(mk, modifiers: modifiers, action: action);
    } else if (Platform.isLinux) {
      final sym = KeycodeMap.toX11KeySym(keyCode);
      if (sym != null) LinuxInputInjector.keyEvent(sym, modifiers: modifiers, action: action);
    } else if (Platform.isAndroid) {
      // Printable ASCII → insert into the focused field as text; named
      // control keys (Enter/Backspace) → sendControlKey. Everything else
      // is a documented no-op (see RemoteControlAccessibilityService).
      if (action == 'tap' || action == 'down') {
        if (keyCode >= 32 && keyCode <= 126 && keyCode != 8 && keyCode != 13) {
          AndroidInputInjector.typeText(String.fromCharCode(keyCode));
        } else {
          final ctrl = KeycodeMap.toAndroidControlKey(keyCode);
          if (ctrl != null) AndroidInputInjector.sendControlKey(ctrl);
        }
      }
    }
    // iOS: no-op — see file header.
  }

  Future<void> clipboardWrite(String text) async {
    if (Platform.isWindows) {
      await WindowsInputInjector.clipboardWrite(text);
    } else if (Platform.isMacOS) {
      await MacOSInputInjector.clipboardWrite(text);
    } else if (Platform.isLinux) {
      await LinuxInputInjector.clipboardWrite(text);
    }
    // Android/iOS: the caller (remote_control_service.dart) already also
    // calls Flutter's own Clipboard.setData for these, which is enough
    // for in-app paste even without an OS-level write.
  }
}
