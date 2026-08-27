// Conditional export picks the first matching platform in order:
//   dart.library.html → Flutter Web (DOM event dispatch)
//   dart.library.io    → native desktop/mobile (Windows/macOS/Linux/Android;
//                         iOS deliberately no-ops, see web_input_injector_io.dart)
//   (neither)           → stub, e.g. running in a plain Dart VM/test harness
export 'web_input_injector_stub.dart'
    if (dart.library.html) 'web_input_injector_web.dart'
    if (dart.library.io) 'web_input_injector_io.dart';

