import 'package:record_voice_app/data/data.dart';

import '../../domain/domain.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final AudioPlayerService _audioPlayerService;

  AudioPlayerRepositoryImpl(this._audioPlayerService);
  @override
  Future<void> playAudio(String filePath) async {
    return await _audioPlayerService.playAudio(filePath);
  }

  @override
  Future<void> stopAudio() async {
    return await _audioPlayerService.stopAudio();
  }
}
