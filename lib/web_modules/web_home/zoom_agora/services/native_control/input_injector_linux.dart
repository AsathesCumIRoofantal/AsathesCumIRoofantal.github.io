// Linux remote-input injection by shelling out to `xdotool` (free,
// commonly packaged: `sudo apt install xdotool` / `dnf install xdotool`).
// This is the same approach several open-source remote-desktop tools use
// on Linux, because there's no portable pure-Dart way to synthesize
// input events without going through X11/libei bindings.
//
// LIMITATION: xdotool talks to X11. On a pure-Wayland session (no
// XWayland input-forwarding compositor support) this will not inject
// anything — same limitation every X11-based remote tool hits on
// Wayland. Detect via `echo $XDG_SESSION_TYPE` and surface a clear
// message in the UI rather than silently failing; see isAvailable below.
//
// A single `xdotool -` process is kept alive and fed commands over
// stdin (one per line) instead of spawning a new process per event —
// spawning ~60 processes/sec for mouse-move would be far too slow.
import 'dart:async';
import 'dart:io';

class LinuxInputInjector {
  LinuxInputInjector._();
  static Process? _proc;
  static int _screenW = 1920;
  static int _screenH = 1080;
  static bool _resolved = false;

  static Future<bool> isAvailable() async {
    try {
      final r = await Process.run('which', ['xdotool']);
      return r.exitCode == 0;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _ensureStarted() async {
    if (_proc != null) return;
    _proc = await Process.start('xdotool', ['-']);
    _proc!.stderr.drain(); // don't let stderr buffer block the pipe
    if (!_resolved) {
      try {
        final geo = await Process.run('xdotool', ['getdisplaygeometry']);
        final parts = (geo.stdout as String).trim().split(RegExp(r'\s+'));
        if (parts.length == 2) {
          _screenW = int.tryParse(parts[0]) ?? _screenW;
          _screenH = int.tryParse(parts[1]) ?? _screenH;
        }
      } catch (_) {
        // Keep the 1920x1080 fallback; coordinates will be approximate.
      }
      _resolved = true;
    }
  }

  static void _send(String cmd) {
    // Fire-and-forget: start the process lazily, ignore the returned
    // future so mouseMove (called at up to 60fps) never awaits I/O.
    _ensureStarted().then((_) => _proc?.stdin.writeln(cmd));
  }

  static void mouseMove(double xNorm, double yNorm) {
    final x = (xNorm.clamp(0.0, 1.0) * _screenW).round();
    final y = (yNorm.clamp(0.0, 1.0) * _screenH).round();
    _send('mousemove $x $y');
  }

  static void mouseClick(double xNorm, double yNorm, {String button = 'left'}) {
    mouseMove(xNorm, yNorm);
    final b = switch (button) { 'right' => 3, 'middle' => 2, _ => 1 };
    _send('click $b');
  }

  static void mouseDown(double xNorm, double yNorm, {String button = 'left'}) {
    mouseMove(xNorm, yNorm);
    final b = switch (button) { 'right' => 3, 'middle' => 2, _ => 1 };
    _send('mousedown $b');
  }

  static void mouseUp(double xNorm, double yNorm, {String button = 'left'}) {
    final b = switch (button) { 'right' => 3, 'middle' => 2, _ => 1 };
    _send('mouseup $b');
  }

  static void mouseScroll(double dx, double dy) {
    // xdotool click 4/5 = wheel up/down, 6/7 = wheel left/right; repeat
    // proportional to magnitude, capped so a big trackpad flick doesn't
    // spam hundreds of clicks.
    final vRepeat = dy.abs().clamp(0, 6).round();
    if (vRepeat > 0) {
      _send('click --repeat $vRepeat ${dy < 0 ? 4 : 5}');
    }
    final hRepeat = dx.abs().clamp(0, 6).round();
    if (hRepeat > 0) {
      _send('click --repeat $hRepeat ${dx < 0 ? 6 : 7}');
    }
  }

  /// [keySym] must already be an X11 keysym name (e.g. "Return", "BackSpace",
  /// "a") — see keycode_map.dart for the translation from the wire protocol.
  static void keyEvent(String keySym, {int modifiers = 0, String action = 'tap'}) {
    final mods = <String>[
      if (modifiers & 1 != 0) 'shift',
      if (modifiers & 2 != 0) 'ctrl',
      if (modifiers & 4 != 0) 'alt',
      if (modifiers & 8 != 0) 'super',
    ];
    final combo = [...mods, keySym].join('+');
    if (action == 'down') {
      _send('keydown $combo');
    } else if (action == 'up') {
      _send('keyup $combo');
    } else {
      _send('key $combo');
    }
  }

  static Future<void> clipboardWrite(String text) async {
    try {
      final p = await Process.start('xclip', ['-selection', 'clipboard']);
      p.stdin.write(text);
      await p.stdin.close();
      await p.exitCode;
    } catch (_) {
      // xclip not installed — xsel is the common fallback.
      try {
        final p = await Process.start('xsel', ['--clipboard', '--input']);
        p.stdin.write(text);
        await p.stdin.close();
        await p.exitCode;
      } catch (_) {
        // Neither present; caller already updates Flutter's own Clipboard
        // via services.Clipboard.setData, so in-app paste still works.
      }
    }
  }

  static void dispose() {
    _proc?.kill();
    _proc = null;
    _resolved = false;
  }
}
