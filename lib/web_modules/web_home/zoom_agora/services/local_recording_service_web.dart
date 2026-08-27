import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// Flutter Web local screen recording.
///
/// Uses the browser's native:
///   - navigator.mediaDevices.getDisplayMedia()
///   - MediaRecorder
///
/// No server and no recording package required.
///
/// Local mode:
///   start() -> records -> stop() -> downloads .webm
///
/// Cloud mode:
///   start(onChunk: ...) -> sends approximately 1-second chunks
///   to the callback and does not download on stop().
///
/// Compatible with modern Flutter/Dart web using package:web.
@JS('MediaRecorder')
extension type _MediaRecorder._(JSObject _) implements JSObject {
  external factory _MediaRecorder(web.MediaStream stream, [JSObject? options]);

  external void start([int timeslice]);

  external void stop();

  external set ondataavailable(JSFunction? callback);

  external set onstop(JSFunction? callback);
}

class LocalRecordingService {
  LocalRecordingService();

  web.MediaStream? _stream;

  _MediaRecorder? _recorder;

  final List<web.Blob> _chunks = <web.Blob>[];

  bool _recording = false;

  bool _cloudMode = false;

  bool get isRecording => _recording;

  bool get isSupported {
    return web.window.navigator.mediaDevices != null;
  }

  String get unsupportedReason =>
      'This browser does not support screen capture/recording APIs. '
      'Try a recent Chrome, Edge, or Firefox.';

  /// Starts screen recording.
  ///
  /// [suggestedFileName] is kept for API compatibility.
  ///
  /// If [onChunk] is supplied, approximately every 1 second a chunk
  /// is converted to bytes and delivered to the callback.
  ///
  /// If [onChunk] is null, chunks are collected and downloaded as
  /// one WebM file when [stop()] is called.
  Future<void> start({
    required String suggestedFileName,
    void Function(List<int>)? onChunk,
  }) async {
    if (!isSupported) {
      throw UnsupportedError(unsupportedReason);
    }

    if (_recording) {
      return;
    }

    _cloudMode = onChunk != null;

    // -----------------------------------------------------------------------
    // Browser native screen/tab/window picker.
    // -----------------------------------------------------------------------

    final constraints = web.DisplayMediaStreamOptions(
      video: true.toJS,
      audio: true.toJS,
    );

    _stream = await web.window.navigator.mediaDevices!
        .getDisplayMedia(constraints)
        .toDart;

    _chunks.clear();

    // -----------------------------------------------------------------------
    // Create MediaRecorder.
    //
    // Do not specify mimeType here. This lets the browser select a format
    // that it actually supports.
    // -----------------------------------------------------------------------

    _recorder = _MediaRecorder(_stream!);

    // -----------------------------------------------------------------------
    // Receive recording chunks.
    // -----------------------------------------------------------------------

    _recorder!.ondataavailable = ((JSAny event) {
      try {
        final blobEvent = event as web.BlobEvent;

        final blob = blobEvent.data;

        if (blob.size <= 0) {
          return;
        }

        _chunks.add(blob);

        if (onChunk != null) {
          _readBlobAsBytes(blob).then((bytes) {
            if (bytes != null && bytes.isNotEmpty) {
              onChunk(bytes);
            }
          });
        }
      } catch (_) {
        // Ignore malformed/unexpected recording events.
      }
    }).toJS;

    // -----------------------------------------------------------------------
    // If the user clicks the browser's native "Stop sharing" button,
    // the video track ends. Finalize the recording.
    // -----------------------------------------------------------------------

    final videoTracks = _stream!.getVideoTracks().toDart;

    if (videoTracks.isNotEmpty) {
      videoTracks.first.onended = ((web.Event event) {
        if (_recording) {
          unawaited(stop());
        }
      }).toJS;
    }

    // -----------------------------------------------------------------------
    // Start MediaRecorder.
    //
    // 1000 = request a dataavailable event approximately every second.
    // -----------------------------------------------------------------------

    _recorder!.start(1000);

    _recording = true;
  }

  /// Converts a browser Blob to Dart bytes.
  Future<Uint8List?> _readBlobAsBytes(web.Blob blob) async {
    final reader = web.FileReader();

    final completer = Completer<Uint8List?>();

    reader.onloadend = ((web.Event event) {
      try {
        final result = reader.result;

        if (result == null) {
          if (!completer.isCompleted) {
            completer.complete(null);
          }
          return;
        }

        final buffer = result as JSArrayBuffer;

        if (!completer.isCompleted) {
          completer.complete(buffer.toDart.asUint8List());
        }
      } catch (_) {
        if (!completer.isCompleted) {
          completer.complete(null);
        }
      }
    }).toJS;

    reader.onerror = ((web.Event event) {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    }).toJS;

    reader.readAsArrayBuffer(blob);

    return completer.future;
  }

  /// Stops recording.
  ///
  /// Local mode:
  ///   Combines all WebM chunks and downloads the recording.
  ///
  /// Cloud mode:
  ///   Does not download because chunks have already been delivered
  ///   through [onChunk].
  Future<String?> stop() async {
    if (!_recording || _recorder == null) {
      return null;
    }

    final recorder = _recorder!;

    final stream = _stream;

    final completer = Completer<void>();

    // -----------------------------------------------------------------------
    // Wait until MediaRecorder has actually stopped.
    // -----------------------------------------------------------------------

    recorder.onstop = ((JSAny event) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }).toJS;

    recorder.stop();

    await completer.future;

    // -----------------------------------------------------------------------
    // Stop screen/audio tracks.
    // -----------------------------------------------------------------------

    if (stream != null) {
      for (final track in stream.getTracks().toDart) {
        track.stop();
      }
    }

    _stream = null;

    String? fileName;

    // -----------------------------------------------------------------------
    // Local recording -> create WebM and download.
    // -----------------------------------------------------------------------

    if (!_cloudMode && _chunks.isNotEmpty) {
      final blob = web.Blob(
        _chunks.toJS,
        web.BlobPropertyBag(type: 'video/webm'),
      );

      final url = web.URL.createObjectURL(blob);

      fileName =
          'meeting-recording-${DateTime.now().millisecondsSinceEpoch}.webm';

      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..download = fileName;

      anchor.click();

      web.URL.revokeObjectURL(url);
    }

    // -----------------------------------------------------------------------
    // Cleanup.
    // -----------------------------------------------------------------------

    _chunks.clear();

    _recording = false;

    _cloudMode = false;

    _recorder = null;

    return fileName;
  }
}
