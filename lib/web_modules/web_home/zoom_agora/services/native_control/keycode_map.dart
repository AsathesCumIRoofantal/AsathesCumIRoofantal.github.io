// The wire protocol (ControlEvent.keyCode in remote_control_service.dart)
// carries a JS-style keyCode (what `web_input_injector_web.dart` already
// natively understands, since it dispatches DOM KeyboardEvents). Native
// desktop/mobile injectors need that translated into their own key
// representation. This table covers the common, always-needed keys —
// letters, digits, arrows, Enter/Backspace/Tab/Space/Escape. Anything
// missing falls through and is a documented no-op rather than a guess.
class KeycodeMap {
  KeycodeMap._();

  /// JS keyCode → Windows virtual-key code. For A-Z (65-90) and 0-9
  /// (48-57) the values are numerically identical to VK codes, so only
  /// the special keys need an explicit table.
  static int? toWindowsVk(int jsKeyCode) {
    if ((jsKeyCode >= 65 && jsKeyCode <= 90) ||
        (jsKeyCode >= 48 && jsKeyCode <= 57)) {
      return jsKeyCode;
    }
    return _special[jsKeyCode]?.vk;
  }

  /// JS keyCode → macOS virtual keycode (Carbon-era table, still what
  /// CGEventCreateKeyboardEvent expects).
  static int? toMacKeycode(int jsKeyCode) => _special[jsKeyCode]?.mac ?? _macLetters[jsKeyCode];

  /// JS keyCode → X11 keysym name for xdotool.
  static String? toX11KeySym(int jsKeyCode) {
    if (jsKeyCode >= 65 && jsKeyCode <= 90) {
      return String.fromCharCode(jsKeyCode + 32); // lowercase letter
    }
    if (jsKeyCode >= 48 && jsKeyCode <= 57) {
      return String.fromCharCode(jsKeyCode);
    }
    return _special[jsKeyCode]?.x11;
  }

  /// JS keyCode → Android control-key name (only the handful the
  /// AccessibilityService can actually act on — see its doc comment).
  static String? toAndroidControlKey(int jsKeyCode) => _special[jsKeyCode]?.android;

  static final Map<int, _KeyDef> _special = {
    8: _KeyDef(vk: 0x08, mac: 51, x11: 'BackSpace', android: 'Backspace'),
    9: _KeyDef(vk: 0x09, mac: 48, x11: 'Tab', android: null),
    13: _KeyDef(vk: 0x0D, mac: 36, x11: 'Return', android: 'Enter'),
    27: _KeyDef(vk: 0x1B, mac: 53, x11: 'Escape', android: null),
    32: _KeyDef(vk: 0x20, mac: 49, x11: 'space', android: null),
    37: _KeyDef(vk: 0x25, mac: 123, x11: 'Left', android: null),
    38: _KeyDef(vk: 0x26, mac: 126, x11: 'Up', android: null),
    39: _KeyDef(vk: 0x27, mac: 124, x11: 'Right', android: null),
    40: _KeyDef(vk: 0x28, mac: 125, x11: 'Down', android: null),
    46: _KeyDef(vk: 0x2E, mac: 117, x11: 'Delete', android: null),
    // Punctuation the physical wire protocol may also send:
    186: _KeyDef(vk: 0xBA, mac: 41, x11: 'semicolon', android: null),
    188: _KeyDef(vk: 0xBC, mac: 43, x11: 'comma', android: null),
    189: _KeyDef(vk: 0xBD, mac: 27, x11: 'minus', android: null),
    190: _KeyDef(vk: 0xBE, mac: 47, x11: 'period', android: null),
    191: _KeyDef(vk: 0xBF, mac: 44, x11: 'slash', android: null),
  };

  // macOS letter/digit virtual keycodes don't line up numerically with
  // JS keyCodes (unlike Windows), so they need an explicit table.
  static const Map<int, int> _macLetters = {
    65: 0, 66: 11, 67: 8, 68: 2, 69: 14, 70: 3, 71: 5, 72: 4, 73: 34, 74: 38,
    75: 40, 76: 37, 77: 46, 78: 45, 79: 31, 80: 35, 81: 12, 82: 15, 83: 1,
    84: 17, 85: 32, 86: 9, 87: 13, 88: 7, 89: 16, 90: 6,
    48: 29, 49: 18, 50: 19, 51: 20, 52: 21, 53: 23, 54: 22, 55: 26, 56: 28, 57: 25,
  };
}

class _KeyDef {
  final int? vk;
  final int? mac;
  final String? x11;
  final String? android;
  const _KeyDef({this.vk, this.mac, this.x11, this.android});
}
