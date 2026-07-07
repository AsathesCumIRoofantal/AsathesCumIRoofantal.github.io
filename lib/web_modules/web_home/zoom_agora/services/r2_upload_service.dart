import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Uploads small/medium files to Cloudflare R2 via the Supabase Edge Function
/// `recording_manager` (action: upload_file).
///
/// This implementation sends bytes as base64 in JSON (simple + reliable across
/// platforms). For very large files, switch to presigned URLs + PUT.
class R2UploadService {
  R2UploadService({SupabaseClient? client}) : _db = client ?? Supabase.instance.client;

  final SupabaseClient _db;

  Future<({String url, String r2Key})> uploadFile({
    required String roomId,
    required String filename,
    required Uint8List bytes,
    String contentType = 'application/octet-stream',
  }) async {
    final res = await _db.functions.invoke(
      'recording_manager',
      body: {
        'action': 'upload_file',
        'roomId': roomId,
        'filename': filename,
        'contentType': contentType,
        'dataBase64': base64Encode(bytes),
      },
    );

    if (res.status != 200) {
      throw Exception('upload_file failed (${res.status}): ${res.data}');
    }

    final data = res.data is String
        ? jsonDecode(res.data as String) as Map<String, dynamic>
        : res.data as Map<String, dynamic>;

    final url = data['url'] as String?;
    final r2Key = data['r2Key'] as String?;
    if (url == null || r2Key == null) {
      throw Exception('upload_file invalid response: $data');
    }
    return (url: url, r2Key: r2Key);
  }
}

