abstract class AudioUploadRepository {
  Stream<double> uploadAudio(String filePath, String fileName);
}
