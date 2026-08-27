// Windows remote-input injection using the `win32` package (pure Dart FFI
// bindings over user32.dll — no native/C++ project changes needed).
//
// Coordinates arrive normalised 0.0–1.0 from the controller; this file
// converts to absolute screen pixels using GetSystemMetrics.
//
// CORRECTION from the previous version of this file: `mouse_event` and
// `keybd_event` do NOT exist in the current `win32` package — Microsoft
// deprecated both Win32 APIs in favor of `SendInput`, and the Dart
// package only wraps `SendInput` now. Verified against the package's
// own example (github.com/halildurmus/win32/blob/main/examples/sendinput.dart)
// and its INPUT-class docs: INPUT has `.mi` (MOUSEINPUT) and `.ki`
// (KEYBDINPUT) extension accessors directly — not nested under a `.u`
// union field. Rewritten below to match that confirmed API.
//
// Still not compiled/run here (no Windows/Flutter SDK in this sandbox)
// — please build once on a real Windows machine; the struct field names
// below are confirmed from the package's own docs/examples, but flag
// anything the compiler disagrees with.
// CORRECTION #2: `MOUSE_EVENT_FLAGS`/`KEYBD_EVENT_FLAGS` are Dart
// extension types (`extension type const MOUSE_EVENT_FLAGS(int _)
// implements int`, confirmed directly from the win32 package source,
// packages/win32/lib/src/enums.g.dart) — they're assignable TO int
// (since they implement int) but a plain int is NOT assignable back
// into a field typed as one of them. _sendMouseButtonEvent's dwFlags
// param was wrongly typed `int`; fixed to `MOUSE_EVENT_FLAGS` below.
// keyEvent's flag combination (`KEYEVENTF_EXTENDEDKEY | (... : 0)`)
// already type-checks correctly as-is: both types override `operator|`
// to return the same typed value rather than degrading to plain int.
import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class WindowsInputInjector {
  const WindowsInputInjector._();

  static int get _screenW => GetSystemMetrics(SM_CXSCREEN);
  static int get _screenH => GetSystemMetrics(SM_CYSCREEN);

  static void mouseMove(double xNorm, double yNorm) {
    final x = (xNorm.clamp(0.0, 1.0) * _screenW).round();
    final y = (yNorm.clamp(0.0, 1.0) * _screenH).round();
    SetCursorPos(
      x,
      y,
    ); // still a plain, non-deprecated API — no SendInput needed for a bare move
  }

  /// Sends a single mouse-button INPUT event at the *current* cursor
  /// position (matches the old mouse_event behaviour, which also ignored
  /// its dx/dy params for button-only events — callers move the cursor
  /// first via [mouseMove]).
  static void _sendMouseButtonEvent(
    MOUSE_EVENT_FLAGS dwFlags, {
    int mouseData = 0,
  }) {
    final input = calloc<INPUT>();
    try {
      input.ref.type = INPUT_MOUSE;
      input.ref.mi.dx = 0;
      input.ref.mi.dy = 0;
      input.ref.mi.mouseData = mouseData;
      input.ref.mi.dwFlags = dwFlags;
      input.ref.mi.time = 0;
      input.ref.mi.dwExtraInfo = ffi.nullptr.address;
      SendInput(1, input, ffi.sizeOf<INPUT>());
    } finally {
      calloc.free(input);
    }
  }

  static void mouseClick(double xNorm, double yNorm, {String button = 'left'}) {
    mouseMove(xNorm, yNorm);
    switch (button) {
      case 'right':
        _sendMouseButtonEvent(MOUSEEVENTF_RIGHTDOWN);
        _sendMouseButtonEvent(MOUSEEVENTF_RIGHTUP);
        break;
      case 'middle':
        _sendMouseButtonEvent(MOUSEEVENTF_MIDDLEDOWN);
        _sendMouseButtonEvent(MOUSEEVENTF_MIDDLEUP);
        break;
      default:
        _sendMouseButtonEvent(MOUSEEVENTF_LEFTDOWN);
        _sendMouseButtonEvent(MOUSEEVENTF_LEFTUP);
    }
  }

  static void mouseDown(double xNorm, double yNorm, {String button = 'left'}) {
    mouseMove(xNorm, yNorm);
    _sendMouseButtonEvent(
      button == 'right' ? MOUSEEVENTF_RIGHTDOWN : MOUSEEVENTF_LEFTDOWN,
    );
  }

  static void mouseUp(double xNorm, double yNorm, {String button = 'left'}) {
    _sendMouseButtonEvent(
      button == 'right' ? MOUSEEVENTF_RIGHTUP : MOUSEEVENTF_LEFTUP,
    );
  }

  static void mouseScroll(double dx, double dy) {
    // WHEEL_DELTA = 120 per notch on Windows; goes in MOUSEINPUT.mouseData
    // for wheel events (SendInput's equivalent of the old mouse_event's
    // dwData param).
    if (dy != 0) {
      _sendMouseButtonEvent(MOUSEEVENTF_WHEEL, mouseData: (dy * 120).round());
    }
    if (dx != 0) {
      _sendMouseButtonEvent(MOUSEEVENTF_HWHEEL, mouseData: (dx * 120).round());
    }
  }

  /// [keyCode] is a JS/Flutter-side keyCode; the caller (remote_control_service)
  /// already maps physical keys before sending, so this expects a Windows
  /// virtual-key code. See services/native_control/keycode_map.dart.
  static void keyEvent(int vkCode, {int modifiers = 0, String action = 'tap'}) {
    void send(int vk, {required bool keyUp}) {
      final input = calloc<INPUT>();
      try {
        input.ref.type = INPUT_KEYBOARD;
        input.ref.ki.wVk = VIRTUAL_KEY(vk);
        input.ref.ki.wScan = 0;
        input.ref.ki.dwFlags =
            KEYEVENTF_EXTENDEDKEY | (keyUp ? KEYEVENTF_KEYUP : 0);
        input.ref.ki.time = 0;
        input.ref.ki.dwExtraInfo = ffi.nullptr.address;
        SendInput(1, input, ffi.sizeOf<INPUT>());
      } finally {
        calloc.free(input);
      }
    }

    const vkShift = 0x10, vkCtrl = 0x11, vkAlt = 0x12, vkMeta = 0x5B;
    final mods = <int>[
      if (modifiers & 1 != 0) vkShift,
      if (modifiers & 2 != 0) vkCtrl,
      if (modifiers & 4 != 0) vkAlt,
      if (modifiers & 8 != 0) vkMeta,
    ];

    if (action == 'down') {
      for (final m in mods) {
        send(m, keyUp: false);
      }
      send(vkCode, keyUp: false);
    } else if (action == 'up') {
      send(vkCode, keyUp: true);
      for (final m in mods.reversed) {
        send(m, keyUp: true);
      }
    } else {
      for (final m in mods) {
        send(m, keyUp: false);
      }
      send(vkCode, keyUp: false);
      send(vkCode, keyUp: true);
      for (final m in mods.reversed) {
        send(m, keyUp: true);
      }
    }
  }

  static Future<void> clipboardWrite(String text) async {
    // Simplest reliable route: shell out to `clip` (built into Windows,
    // no FFI clipboard-format dance needed).
    final process = await Process.start('cmd', [
      '/c',
      'clip',
    ], runInShell: true);
    process.stdin.write(text);
    await process.stdin.close();
    await process.exitCode;
  }
}
