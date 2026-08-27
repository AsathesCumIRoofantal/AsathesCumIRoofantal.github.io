// Desktop (Windows/macOS/Linux) local screen recording by shelling out
// to a system `ffmpeg` binary — free and open-source, but NOT bundled;
// the user needs it installed and on PATH:
//   Windows: winget install ffmpeg   (or download from ffmpeg.org)
//   macOS:   brew install ffmpeg
//   Linux:   sudo apt install ffmpeg  /  sudo dnf install ffmpeg
//
// Why shell out instead of a Flutter plugin: as of writing, the popular
// ffmpeg Flutter plugins are either unmaintained or gate desktop screen
// capture behind a paid tier — shelling out to the real, free ffmpeg CLI
// avoids both problems and is the same approach OBS's command-line mode
// and many open-source tools use.
//
// Android/iOS: real screen recording needs MediaProjection (Android) or
// ReplayKit (iOS) — both are native-platform APIs with no pure-Dart path
// (same category of limitation as remote-control input injection, and
// the same one documented in the module's own README for recording).
// Rather than silently doing nothing, isSupported is false and start()
// throws with that explanation, matching this codebase's existing
// "honest stub" pattern elsewhere.
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalRecordingService {
  LocalRecordingService();

  bool get isSupported => Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  String get unsupportedReason => Platform.isAndroid
      ? 'Local screen recording on Android needs a native MediaProjection '
          'plugin — not wired up. Screen sharing (live, to other '
          'participants) still works; saving a local file does not, yet.'
      : Platform.isIOS
          ? 'Local screen recording on iOS needs ReplayKit via a native '
              'Broadcast Upload Extension (an Xcode-side change, not '
              'addable from Dart alone) — not wired up.'
          : 'Local recording is not available on this platform.';

  Process? _ffmpeg;
  String? _outputPath;
  bool get isRecording => _ffmpeg != null;

  Future<bool> _ffmpegAvailable() async {
    try {
      final r = await Process.run('ffmpeg', ['-version']);
      return r.exitCode == 0;
    } catch (_) {
      return false;
    }
  }

  List<String> _captureArgs(String outputPath) {
    if (Platform.isWindows) {
      // gdigrab captures the whole desktop; "desktop" is the magic device name.
      return [
        '-y', '-f', 'gdigrab', '-framerate', '30', '-i', 'desktop',
        '-f', 'dshow', '-i', 'audio=virtual-audio-capturer', // optional; ffmpeg
        // will just fail the audio branch if that device name doesn't
        // exist on this machine — caught below and retried video-only.
        '-c:v', 'libx264', '-preset', 'ultrafast', '-pix_fmt', 'yuv420p',
        outputPath,
      ];
    } else if (Platform.isMacOS) {
      // avfoundation "1:0" = display 1 + default audio input; the exact
      // index can vary by machine (`ffmpeg -f avfoundation -list_devices
      // true -i ""` lists them) — 1:0 is the common default, may need
      // adjusting on a given Mac.
      return [
        '-y', '-f', 'avfoundation', '-framerate', '30', '-i', '1:0',
        '-c:v', 'libx264', '-preset', 'ultrafast', '-pix_fmt', 'yuv420p',
        outputPath,
      ];
    } else {
      // Linux/X11. Requires DISPLAY to be set; will not work under a
      // pure-Wayland session without XWayland screen-capture support
      // (same limitation as the xdotool-based input injector).
      final display = Platform.environment['DISPLAY'] ?? ':0.0';
      return [
        '-y', '-f', 'x11grab', '-framerate', '30', '-i', display,
        '-f', 'pulse', '-i', 'default',
        '-c:v', 'libx264', '-preset', 'ultrafast', '-pix_fmt', 'yuv420p',
        outputPath,
      ];
    }
  }

  /// [onChunk] is accepted for interface parity with the web
  /// implementation but NOT streamed live here — ffmpeg owns the file
  /// handle while recording, so there's nothing safe to read mid-write.
  /// For cloud recording on desktop, the controller instead reads the
  /// finished file back in chunks after [stop] returns a path — see
  /// zoom_meeting_controller.dart's startCloudRecording/stopCloudRecording.
  Future<void> start({required String suggestedFileName, void Function(List<int>)? onChunk}) async {
    if (!isSupported) throw UnsupportedError(unsupportedReason);
    if (_ffmpeg != null) return;
    if (!await _ffmpegAvailable()) {
      throw Exception(
        'ffmpeg is not installed or not on PATH. Install it (brew install '
        'ffmpeg / winget install ffmpeg / apt install ffmpeg) and try again.',
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}${Platform.pathSeparator}$suggestedFileName';
    _outputPath = path;

    try {
      _ffmpeg = await Process.start('ffmpeg', _captureArgs(path));
    } catch (e) {
      _ffmpeg = null;
      rethrow;
    }
  }

  /// Sends ffmpeg a graceful "q" (its documented clean-stop keystroke)
  /// so the output file's container is finalized properly instead of
  /// being corrupted by a hard kill.
  Future<String?> stop() async {
    final proc = _ffmpeg;
    if (proc == null) return null;
    proc.stdin.write('q');
    await proc.stdin.flush();
    await proc.exitCode.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        proc.kill();
        return -1;
      },
    );
    _ffmpeg = null;
    final path = _outputPath;
    _outputPath = null;
    return path;
  }
}
