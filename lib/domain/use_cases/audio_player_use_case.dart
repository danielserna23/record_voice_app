import 'package:record_voice_app/domain/domain.dart';

import '../../data/data.dart';

class AudioPlayerUseCase {
  final AudioPlayerService _audioPlayerService;
  final AudioPlayerRepository _audioPlayerRepository;

  AudioPlayerUseCase(this._audioPlayerService, this._audioPlayerRepository);

  Future<void> play(String filePath) async {
    final bytes = await _audioPlayerRepository.getAudioBytes(filePath);
    await _audioPlayerService.play(bytes);
  }

  Future<void> pause() async => await _audioPlayerService.pause();
  Future<void> stop() async => await _audioPlayerService.stop();
  Future<void> seek(Duration position) async =>
      _audioPlayerService.seek(position);
}
