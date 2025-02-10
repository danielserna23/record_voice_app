import 'package:record_voice_app/data/data.dart';
import 'package:record_voice_app/domain/domain.dart';

class AudioUploadRepositoryImpl implements AudioUploadRepository {
  final StorageService _storageServices;

  AudioUploadRepositoryImpl(this._storageServices);
  @override
  Stream<double> uploadAudio(String filePath, String fileName) {
    return _storageServices.uploadAudio(filePath, fileName);
  }
}
