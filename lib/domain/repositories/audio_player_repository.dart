abstract class AudioPlayerRepository {
  Future<void> playAudio(String filePath);
  Future<void> stopAudio();
}
