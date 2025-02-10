import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> playAudio(String filePath) async {
    final newFile = File(filePath);
    final ref =
        _storage.ref().child('voice_notes/${newFile.uri.pathSegments.last}');

    try {
      final bytes = await ref.getData();
      if (bytes != null) {
        final player = AudioPlayer();
        await player.play(BytesSource(bytes));
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> pauseAudio() async {
    try {
      if (_audioPlayer.state == PlayerState.playing) {
        // Verifica el estado
        await _audioPlayer.pause();
      }
    } catch (e) {
      rethrow;
    }
  }
}
