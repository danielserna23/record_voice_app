import 'package:record_voice_app/data/data.dart';
import 'package:record_voice_app/domain/domain.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioRecorderService _audioRecorderService;

  AudioRepositoryImpl(
    this._audioRecorderService,
  );

  @override
  Future<String?> startRecording() async {
    return await _audioRecorderService.startRecording();
  }

  @override
  Future<String?> stopRecording() async {
    return await _audioRecorderService.stopRecording();
  }
}
