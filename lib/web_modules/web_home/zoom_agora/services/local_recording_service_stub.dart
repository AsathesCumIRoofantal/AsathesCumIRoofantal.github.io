class LocalRecordingService {
  const LocalRecordingService();
  bool get isSupported => false;
  String get unsupportedReason => 'Local recording is not available on this platform.';
  bool get isRecording => false;
  Future<void> start({required String suggestedFileName, void Function(List<int>)? onChunk}) async =>
      throw UnsupportedError(unsupportedReason);
  Future<String?> stop() async => null;
}
