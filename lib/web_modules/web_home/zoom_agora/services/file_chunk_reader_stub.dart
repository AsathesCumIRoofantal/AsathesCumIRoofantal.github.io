import 'dart:typed_data';

/// No-op on web/unknown platforms — web's cloud-recording path streams
/// bytes live via LocalRecordingService's onChunk instead of ever writing
/// a local file, so this helper is never actually called there.
Future<void> uploadFileInChunksThenDelete(
  String path,
  Future<void> Function(Uint8List) uploadChunk,
) async {
  throw UnsupportedError('File-based chunk reading is not available on this platform.');
}
