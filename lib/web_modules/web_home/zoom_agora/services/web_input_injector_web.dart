// Web-only implementation.
import 'dart:html' as html;

class WebInputInjector {
  const WebInputInjector();

  html.Element? _elementAt(double xNorm, double yNorm) {
    final x = (xNorm * html.window.innerWidth!).clamp(0, html.window.innerWidth!.toDouble());
    final y = (yNorm * html.window.innerHeight!).clamp(0, html.window.innerHeight!.toDouble());
    return html.document.elementFromPoint(x, y);
  }

  void mouseMove(double x, double y) {
    final el = _elementAt(x, y);
    if (el == null) return;
    el.dispatchEvent(html.MouseEvent('mousemove'));
  }

  void mouseClick(double x, double y, {String button = 'left'}) {
    final el = _elementAt(x, y);
    if (el == null) return;
    el.dispatchEvent(html.MouseEvent('mousedown'));
    el.dispatchEvent(html.MouseEvent('mouseup'));
    el.dispatchEvent(html.MouseEvent('click'));
  }

  void mouseScroll(double dx, double dy) {
    html.window.scrollBy(dx * 200, dy * 200);
  }

  void keyEvent(int keyCode, {int modifiers = 0, String action = 'tap'}) {
    final el = html.document.activeElement ?? html.document.body;
    if (el == null) return;
    // keyCode is legacy; still acceptable for basic key interactions.
    final evt = html.KeyboardEvent(
      action == 'down' ? 'keydown' : 'keyup',
      keyCode: keyCode,
      shiftKey: (modifiers & 1) != 0,
      ctrlKey: (modifiers & 2) != 0,
      altKey: (modifiers & 4) != 0,
      metaKey: (modifiers & 8) != 0,
    );
    el.dispatchEvent(evt);
    if (action == 'tap') {
      el.dispatchEvent(html.KeyboardEvent(
        'keyup',
        keyCode: keyCode,
        shiftKey: (modifiers & 1) != 0,
        ctrlKey: (modifiers & 2) != 0,
        altKey: (modifiers & 4) != 0,
        metaKey: (modifiers & 8) != 0,
      ));
    }
  }

  Future<void> clipboardWrite(String text) async {
    try {
      await html.window.navigator.clipboard?.writeText(text);
    } catch (_) {
      // Clipboard API may require a user gesture; ignore.
    }
  }
}

