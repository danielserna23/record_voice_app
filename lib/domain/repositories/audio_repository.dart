abstract class AudioRepository {
  Future<String?> startRecording();
  Future<String?> stopRecording();
}
