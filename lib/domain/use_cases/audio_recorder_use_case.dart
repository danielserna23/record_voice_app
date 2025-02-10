import 'package:record_voice_app/domain/domain.dart';

class AudioRecorderUseCase {
  final AudioRepository _repository;

  AudioRecorderUseCase(this._repository);

  Future<String?> startRecording() async => await _repository.startRecording();
  Future<String?> stopRecording() async => await _repository.stopRecording();
}
