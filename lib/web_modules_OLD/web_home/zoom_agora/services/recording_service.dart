/// Agora Cloud Recording REST wrapper.
/// Docs: https://docs.agora.io/en/cloud-recording/reference/restful-api
class RecordingService {
  String? resourceId;
  String? sid;
  bool isRecording = false;
  bool isPaused    = false;

  /// TODO(backend): POST /v1/apps/{appid}/cloud_recording/acquire
  Future<void> acquire(String channel, int uid) async { resourceId = 'TODO'; }

  /// TODO(backend): POST .../mode/mix/start
  Future<void> start(String channel, int uid, {Map<String,dynamic>? storageConfig}) async {
    await acquire(channel, uid);
    sid = 'TODO_sid'; isRecording = true; isPaused = false;
  }
  Future<void> pause()  async { isPaused = true;  /* TODO update layout/pause */ }
  Future<void> resume() async { isPaused = false; }
  Future<void> stop()   async { isRecording = false; sid = null; resourceId = null; }
}
