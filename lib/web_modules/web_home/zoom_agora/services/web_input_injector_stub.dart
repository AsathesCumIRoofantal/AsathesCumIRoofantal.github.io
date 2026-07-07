class WebInputInjector {
  const WebInputInjector();

  void mouseMove(double x, double y) {}
  void mouseClick(double x, double y, {String button = 'left'}) {}
  void mouseScroll(double dx, double dy) {}
  void keyEvent(int keyCode, {int modifiers = 0, String action = 'tap'}) {}
  Future<void> clipboardWrite(String text) async {}
}

