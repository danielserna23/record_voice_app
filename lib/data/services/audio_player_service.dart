import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> play(Uint8List bytes) async {
    if (_player.state == PlayerState.playing) {
      await _player.stop();
    }
    await _player.play(BytesSource(bytes));
  }

  Future<void> pause() async => await _player.pause();

  Future<void> stop() async {
    await _player.stop();
    await _player.release();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  Stream<Duration> get positionChanged => _player.onPositionChanged;
  Stream<Duration> get durationChanged => _player.onDurationChanged;
  Stream<PlayerState> get playerStateChanged => _player.onPlayerStateChanged;
  Stream<void> get playerComplete => _player.onPlayerComplete;
}
