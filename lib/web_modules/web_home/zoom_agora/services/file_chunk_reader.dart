// zoom_meeting_controller.dart is compiled for web too, and `dart:io`
// cannot be imported at all in web-compiled Dart (not just "unsupported
// at runtime" — it's a hard compile error), so this file-chunk-reading
// step (only ever needed on desktop, to bridge ffmpeg's finished file
// into RecordingService.uploadChunk) has to live behind the same
// conditional-export pattern as the input injector and local recorder.
export 'file_chunk_reader_stub.dart'
    if (dart.library.io) 'file_chunk_reader_io.dart';
