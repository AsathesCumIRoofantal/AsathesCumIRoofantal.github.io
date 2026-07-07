import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cloud recording via Cloudflare R2, brokered through the Supabase Edge
/// Function `recording_manager`. The function holds the R2 credentials
/// server-side; the Flutter client never sees the R2 secret key.
///
/// Flow:
///   start()  → Edge Function creates an R2 multipart upload, returns
///              an `uploadId` + `r2Key`; meeting row is updated with
///              recording_url pointing to the final R2 public URL.
///   pause()  → Edge Function pauses the recording pipeline (no-op on
///              raw R2; this is where a future media server hook lives).
///   resume() → Resumes.
///   stop()   → Edge Function completes the multipart upload, marks the
///              meeting row recording_url as finalised.
///
/// If the Edge Function is not yet deployed the methods throw with a
/// descriptive error — they do NOT silently swallow errors or pretend
/// recording started.
class RecordingService {
  String? resourceId;  // r2Key returned by start
  String? sid;         // uploadId returned by start
  bool isRecording = false;
  bool isPaused    = false;

  static SupabaseClient get _client => Supabase.instance.client;

  Future<void> acquire(String channel, int uid) async {
    // Acquire is merged into start() for R2 — keeping the method for
    // API compatibility with the controller.
    resourceId = channel;
  }

  /// Begins a cloud recording session via the `recording_manager` Edge
  /// Function. [meetingId] is the `meetings.id` UUID so the function can
  /// update the recording_url column when the recording completes.
  Future<void> start(
    String channel,
    int uid, {
    Map<String, dynamic>? storageConfig,
    String? meetingId,
  }) async {
    await acquire(channel, uid);

    final response = await _client.functions.invoke(
      'recording_manager',
      body: {
        'action': 'start',
        'channel': channel,
        'uid': uid,
        'meetingId': meetingId,
        if (storageConfig != null) 'storageConfig': storageConfig,
      },
    );

    if (response.status != 200) {
      final body = response.data is String
          ? jsonDecode(response.data as String)
          : response.data;
      throw Exception(
        'recording_manager start failed (${response.status}): $body',
      );
    }

    final data = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    sid          = data['uploadId'] as String?;
    resourceId   = data['r2Key']    as String?;
    isRecording  = true;
    isPaused     = false;
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

  Future<void> stop() async {
    if (!isRecording) return;
    final response = await _client.functions.invoke(
      'recording_manager',
      body: {'action': 'stop', 'uploadId': sid, 'r2Key': resourceId},
    );
    if (response.status != 200) {
      throw Exception('recording_manager stop failed (${response.status})');
    }
    isRecording = false;
    sid         = null;
    resourceId  = null;
    isPaused    = false;
  }
}
