// macOS remote-input injection via direct FFI into the ApplicationServices
// (Core Graphics) system framework — no Swift/ObjC bridge or Xcode target
// change required, just dart:ffi against a system dylib that's always
// present.
//
// IMPORTANT — this requires the *host* app (the one being controlled) to
// be granted Accessibility permission: System Settings → Privacy &
// Security → Accessibility → enable your app. Without it, CGEventPost
// silently does nothing (macOS's own security gate, same one every
// remote-control app — AnyDesk, TeamViewer, Chrome Remote Desktop — has
// to ask the user for). There is no way to grant this programmatically;
// surface a one-time prompt in the UI directing the user there.
//
// Not compiled/tested here (no macOS + Xcode in this sandbox). Struct
// layout for CGPoint (two 8-byte doubles) and function signatures were
// written to match the public CoreGraphics headers; verify on-device and
// report any EXC_BAD_ACCESS / signature mismatch.
import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';

final class CGPoint extends ffi.Struct {
  @ffi.Double()
  external double x;
  @ffi.Double()
  external double y;
}

// CGEventType values we use.
const int _kCGEventLeftMouseDown = 1;
const int _kCGEventLeftMouseUp = 2;
const int _kCGEventRightMouseDown = 3;
const int _kCGEventRightMouseUp = 4;
const int _kCGEventMouseMoved = 5;
const int _kCGEventKeyDown = 10;
const int _kCGEventKeyUp = 11;
const int _kCGEventScrollWheel = 22;
const int _kCGEventOtherMouseDown = 25;
const int _kCGEventOtherMouseUp = 26;
const int _kCGHIDEventTap = 0;
const int _kCGMouseButtonLeft = 0;
const int _kCGMouseButtonRight = 1;
const int _kCGMouseButtonCenter = 2;
const int _kCGScrollEventUnitPixel = 0;

typedef _CGEventCreateMouseEventNative = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source,
    ffi.Int32 mouseType,
    CGPoint mouseCursorPosition,
    ffi.Int32 mouseButton);
typedef _CGEventCreateMouseEventDart = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source,
    int mouseType,
    CGPoint mouseCursorPosition,
    int mouseButton);

typedef _CGEventCreateKeyboardEventNative = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source, ffi.Uint16 virtualKey, ffi.Uint8 keyDown);
typedef _CGEventCreateKeyboardEventDart = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source, int virtualKey, int keyDown);

typedef _CGEventCreateScrollWheelEventNative = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source,
    ffi.Int32 units,
    ffi.Uint32 wheelCount,
    ffi.Int32 wheel1,
    ffi.Int32 wheel2);
typedef _CGEventCreateScrollWheelEventDart = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void> source,
    int units,
    int wheelCount,
    int wheel1,
    int wheel2);

typedef _CGEventPostNative = ffi.Void Function(ffi.Int32 tap, ffi.Pointer<ffi.Void> event);
typedef _CGEventPostDart = void Function(int tap, ffi.Pointer<ffi.Void> event);

typedef _CGEventSetFlagsNative = ffi.Void Function(ffi.Pointer<ffi.Void> event, ffi.Int64 flags);
typedef _CGEventSetFlagsDart = void Function(ffi.Pointer<ffi.Void> event, int flags);

typedef _CFReleaseNative = ffi.Void Function(ffi.Pointer<ffi.Void> cf);
typedef _CFReleaseDart = void Function(ffi.Pointer<ffi.Void> cf);

typedef _CGMainDisplayIdNative = ffi.Uint32 Function();
typedef _CGMainDisplayIdDart = int Function();
typedef _CGDisplayPixelsWideNative = ffi.Size Function(ffi.Uint32 display);
typedef _CGDisplayPixelsWideDart = int Function(int display);
typedef _CGDisplayPixelsHighNative = ffi.Size Function(ffi.Uint32 display);
typedef _CGDisplayPixelsHighDart = int Function(int display);

class MacOSInputInjector {
  MacOSInputInjector._();

  static final ffi.DynamicLibrary _appServices = ffi.DynamicLibrary.open(
    '/System/Library/Frameworks/ApplicationServices.framework/ApplicationServices',
  );
  static final ffi.DynamicLibrary _coreGraphics = ffi.DynamicLibrary.open(
    '/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics',
  );

  static final _createMouseEvent = _appServices
      .lookupFunction<_CGEventCreateMouseEventNative, _CGEventCreateMouseEventDart>(
          'CGEventCreateMouseEvent');
  static final _createKeyboardEvent = _appServices
      .lookupFunction<_CGEventCreateKeyboardEventNative, _CGEventCreateKeyboardEventDart>(
          'CGEventCreateKeyboardEvent');
  static final _createScrollEvent = _appServices.lookupFunction<
      _CGEventCreateScrollWheelEventNative,
      _CGEventCreateScrollWheelEventDart>('CGEventCreateScrollWheelEvent');
  static final _post =
      _appServices.lookupFunction<_CGEventPostNative, _CGEventPostDart>('CGEventPost');
  static final _setFlags = _appServices
      .lookupFunction<_CGEventSetFlagsNative, _CGEventSetFlagsDart>('CGEventSetFlags');
  static final _release =
      _coreGraphics.lookupFunction<_CFReleaseNative, _CFReleaseDart>('CFRelease');
  static final _mainDisplay = _coreGraphics
      .lookupFunction<_CGMainDisplayIdNative, _CGMainDisplayIdDart>('CGMainDisplayID');
  static final _displayWide = _coreGraphics
      .lookupFunction<_CGDisplayPixelsWideNative, _CGDisplayPixelsWideDart>('CGDisplayPixelsWide');
  static final _displayHigh = _coreGraphics
      .lookupFunction<_CGDisplayPixelsHighNative, _CGDisplayPixelsHighDart>('CGDisplayPixelsHigh');

  static double get _screenW => _displayWide(_mainDisplay()).toDouble();
  static double get _screenH => _displayHigh(_mainDisplay()).toDouble();

  static CGPoint _point(double xNorm, double yNorm) {
    final p = calloc<CGPoint>();
    p.ref.x = xNorm.clamp(0.0, 1.0) * _screenW;
    p.ref.y = yNorm.clamp(0.0, 1.0) * _screenH;
    final v = p.ref;
    calloc.free(p);
    return v;
  }

  static void mouseMove(double xNorm, double yNorm) {
    final ev = _createMouseEvent(
        ffi.nullptr, _kCGEventMouseMoved, _point(xNorm, yNorm), _kCGMouseButtonLeft);
    _post(_kCGHIDEventTap, ev);
    _release(ev);
  }

  static void mouseClick(double xNorm, double yNorm, {String button = 'left'}) {
    mouseDown(xNorm, yNorm, button: button);
    mouseUp(xNorm, yNorm, button: button);
  }

  static void mouseDown(double xNorm, double yNorm, {String button = 'left'}) {
    final pt = _point(xNorm, yNorm);
    final (type, btn) = switch (button) {
      'right' => (_kCGEventRightMouseDown, _kCGMouseButtonRight),
      'middle' => (_kCGEventOtherMouseDown, _kCGMouseButtonCenter),
      _ => (_kCGEventLeftMouseDown, _kCGMouseButtonLeft),
    };
    final ev = _createMouseEvent(ffi.nullptr, type, pt, btn);
    _post(_kCGHIDEventTap, ev);
    _release(ev);
  }

  static void mouseUp(double xNorm, double yNorm, {String button = 'left'}) {
    final pt = _point(xNorm, yNorm);
    final (type, btn) = switch (button) {
      'right' => (_kCGEventRightMouseUp, _kCGMouseButtonRight),
      'middle' => (_kCGEventOtherMouseUp, _kCGMouseButtonCenter),
      _ => (_kCGEventLeftMouseUp, _kCGMouseButtonLeft),
    };
    final ev = _createMouseEvent(ffi.nullptr, type, pt, btn);
    _post(_kCGHIDEventTap, ev);
    _release(ev);
  }

  static void mouseScroll(double dx, double dy) {
    final ev = _createScrollEvent(
        ffi.nullptr, _kCGScrollEventUnitPixel, 2, (dy * 10).round(), (dx * 10).round());
    _post(_kCGHIDEventTap, ev);
    _release(ev);
  }

  /// [keyCode] must already be a macOS virtual keycode (see keycode_map.dart).
  static void keyEvent(int keyCode, {int modifiers = 0, String action = 'tap'}) {
    void send(bool down) {
      final ev = _createKeyboardEvent(ffi.nullptr, keyCode, down ? 1 : 0);
      // CGEventFlags bit positions: shift=0x20000, ctrl=0x40000,
      // alt/option=0x80000, cmd=0x100000.
      int flags = 0;
      if (modifiers & 1 != 0) flags |= 0x20000;
      if (modifiers & 2 != 0) flags |= 0x40000;
      if (modifiers & 4 != 0) flags |= 0x80000;
      if (modifiers & 8 != 0) flags |= 0x100000;
      if (flags != 0) _setFlags(ev, flags);
      _post(_kCGHIDEventTap, ev);
      _release(ev);
    }

    if (action == 'down') {
      send(true);
    } else if (action == 'up') {
      send(false);
    } else {
      send(true);
      send(false);
    }
  }

  static Future<void> clipboardWrite(String text) async {
    // `pbcopy` is a stock macOS binary — simplest reliable route without
    // wrestling NSPasteboard through FFI.
    final process = await Process.start('pbcopy', []);
    process.stdin.write(text);
    await process.stdin.close();
    await process.exitCode;
  }
}
