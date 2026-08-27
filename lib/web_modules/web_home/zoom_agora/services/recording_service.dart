import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cloud recording via Cloudflare R2, brokered through the Supabase Edge
/// Function `recording_manager` (see supabase_functions/recording_manager/
/// index.ts — that function did not exist before this pass; only a
/// comment describing its contract did).
///
/// PREVIOUSLY (honest note, not hidden): this service only called
/// start/pause/resume/stop with metadata — no video bytes were ever
/// captured or uploaded anywhere, so even with the Edge Function
/// deployed, "recording" produced an empty object in R2. That's fixed
/// now: [uploadChunk] is fed live bytes by whatever is capturing the
/// screen (LocalRecordingService's web MediaRecorder chunks, or a
/// finished desktop ffmpeg file read back in pieces — see
/// zoom_meeting_controller.dart's startCloudRecording wiring) and
/// actually performs an R2 multipart upload.
///
/// Flow:
///   start()        → Edge Function creates an R2 multipart upload.
///   uploadChunk()  → buffers bytes until they reach S3's 5MB minimum
///                     part size (except the final part, which can be
///                     any size), then asks the Edge Function to presign
///                     that part number and PUTs the bytes directly to
///                     R2 (never through the Edge Function — Edge
///                     Functions have a request-body ceiling far below
///                     a video chunk).
///   stop()         → flushes whatever's left as the final part, then
///                     asks the Edge Function to complete the multipart
///                     upload. Returns the finished recording's public URL.
class RecordingService {
  String? resourceId; // r2Key returned by start
  String? sid; // uploadId returned by start
  bool isRecording = false;
  bool isPaused = false;
  String? lastRecordingUrl;

  static SupabaseClient get _client => Supabase.instance.client;

  static const _minPartBytes = 5 * 1024 * 1024; // S3/R2 multipart minimum (except last part)

  final BytesBuilder _buffer = BytesBuilder(copy: false);
  int _nextPartNumber = 1;
  final List<Map<String, dynamic>> _completedParts = [];

  Future<void> acquire(String channel, int uid) async {
    resourceId = channel;
  }

  /// Begins a cloud recording session. [meetingId] is the `meetings.id`
  /// UUID so the Edge Function can update recording_url when it finishes.
  Future<void> start(
    String channel,
    int uid, {
    Map<String, dynamic>? storageConfig,
    String? meetingId,
    String ext = 'webm',
  }) async {
    await acquire(channel, uid);
    _buffer.clear();
    _nextPartNumber = 1;
    _completedParts.clear();

    final response = await _client.functions.invoke(
      'recording_manager',
      body: {
        'action': 'start',
        'channel': channel,
        'uid': uid,
        'meetingId': meetingId,
        'ext': ext,
      },
    );

    if (response.status != 200) {
      throw Exception('recording_manager start failed (${response.status}): ${response.data}');
    }

    final data = _asMap(response.data);
    sid = data['uploadId'] as String?;
    resourceId = data['r2Key'] as String?;
    isRecording = true;
    isPaused = false;
  }

  /// Feed raw video bytes as they're produced. Safe to call frequently
  /// with small chunks (e.g. every MediaRecorder ondataavailable tick) —
  /// internally buffered up to R2's part-size minimum before an actual
  /// network upload happens.
  Future<void> uploadChunk(Uint8List bytes) async {
    if (!isRecording || isPaused) return;
    _buffer.add(bytes);
    if (_buffer.length >= _minPartBytes) {
      await _flushPart();
    }
  }

  Future<void> _flushPart() async {
    if (_buffer.isEmpty || sid == null || resourceId == null) return;
    final partBytes = _buffer.takeBytes();
    final partNumber = _nextPartNumber++;

    final urlRes = await _client.functions.invoke('recording_manager', body: {
      'action': 'getPartUrl',
      'uploadId': sid,
      'r2Key': resourceId,
      'partNumber': partNumber,
    });
    if (urlRes.status != 200) {
      throw Exception('recording_manager getPartUrl failed (${urlRes.status}): ${urlRes.data}');
    }
    final presignedUrl = _asMap(urlRes.data)['url'] as String;

    final putRes = await http.put(Uri.parse(presignedUrl), body: partBytes);
    if (putRes.statusCode != 200) {
      throw Exception('R2 part upload failed (${putRes.statusCode}) for part $partNumber');
    }
    final etag = putRes.headers['etag'] ?? putRes.headers['ETag'];
    if (etag == null) {
      throw Exception('R2 did not return an ETag for part $partNumber');
    }
    _completedParts.add({'partNumber': partNumber, 'etag': etag});
  }

  Future<void> pause() async {
    if (!isRecording) return;
    final response = await _client.functions.invoke(
      'recording_manager',
      body: {'action': 'pause', 'uploadId': sid, 'r2Key': resourceId},
    );
    if (response.status != 200) {
      throw Exception('recording_manager pause failed (${response.status})');
    }
    isPaused = true;
  }

  Future<void> resume() async {
    if (!isPaused) return;
    final response = await _client.functions.invoke(
      'recording_manager',
      body: {'action': 'resume', 'uploadId': sid, 'r2Key': resourceId},
    );
    if (response.status != 200) {
      throw Exception('recording_manager resume failed (${response.status})');
    }
    isPaused = false;
  }

  /// Flushes any buffered bytes as the final part, completes the R2
  /// multipart upload, and returns the finished recording's public URL.
  Future<String?> stop({String? meetingId}) async {
    if (!isRecording) return null;

    if (_buffer.isNotEmpty) {
      await _flushPart();
    }

    if (_completedParts.isEmpty) {
      // Nothing was ever uploaded (e.g. recording stopped instantly) —
      // abort cleanly instead of trying to "complete" an empty upload,
      // which R2 would reject anyway.
      await _client.functions.invoke('recording_manager', body: {
        'action': 'abort',
        'uploadId': sid,
        'r2Key': resourceId,
        'meetingId': meetingId,
      });
      _reset();
      return null;
    }

    final response = await _client.functions.invoke('recording_manager', body: {
      'action': 'complete',
      'uploadId': sid,
      'r2Key': resourceId,
      'parts': _completedParts,
      'meetingId': meetingId,
    });
    if (response.status != 200) {
      throw Exception('recording_manager complete failed (${response.status}): ${response.data}');
    }
    final url = _asMap(response.data)['url'] as String?;
    lastRecordingUrl = url;
    _reset();
    return url;
  }

  void _reset() {
    isRecording = false;
    isPaused = false;
    sid = null;
    resourceId = null;
    _buffer.clear();
    _nextPartNumber = 1;
    _completedParts.clear();
  }

  Map<String, dynamic> _asMap(dynamic data) =>
      data is String ? jsonDecode(data) as Map<String, dynamic> : data as Map<String, dynamic>;
}
