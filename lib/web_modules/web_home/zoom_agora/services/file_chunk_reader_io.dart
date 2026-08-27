import 'dart:io';
import 'dart:typed_data';

/// Reads the file at [path] back in 8MB chunks (comfortably above R2's
/// 5MB multipart minimum), handing each to [uploadChunk], then deletes
/// the local file once every byte has been sent — its only job was to
/// bridge ffmpeg's finished output into the upload, not to persist.
Future<void> uploadFileInChunksThenDelete(
  String path,
  Future<void> Function(Uint8List) uploadChunk,
) async {
  final file = File(path);
  if (!await file.exists()) return;

  const chunkSize = 8 * 1024 * 1024;
  final length = await file.length();
  final raf = await file.open();
  try {
    for (int offset = 0; offset < length; offset += chunkSize) {
      final size = (length - offset).clamp(0, chunkSize);
      final bytes = await raf.read(size);
      await uploadChunk(Uint8List.fromList(bytes));
    }
  } finally {
    await raf.close();
  }
  await file.delete();
}
