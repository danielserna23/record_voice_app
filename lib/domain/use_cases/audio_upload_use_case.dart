import 'package:record_voice_app/domain/domain.dart';

class AudioUploadUseCase {
  final AudioUploadRepository _audioUploadRepository;

  AudioUploadUseCase(this._audioUploadRepository);

  Stream<double> uploadAudio(String filePath, String fileName) {
    return _audioUploadRepository.uploadAudio(filePath, fileName);
  }
}
