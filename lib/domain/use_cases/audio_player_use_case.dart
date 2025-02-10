import '../domain.dart';

class AudioPlayerUseCase {
  final AudioPlayerRepository _repository;

  AudioPlayerUseCase(this._repository);

  Future<void> playAudio(String filePath) => _repository.playAudio(filePath);
  Future<void> stopAudio() => _repository.stopAudio();
}
