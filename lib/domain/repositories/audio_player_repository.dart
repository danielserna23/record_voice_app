import 'package:flutter/services.dart';

abstract class AudioPlayerRepository {
  Future<Uint8List> getAudioBytes(String filePath);
  Future<void> dispose();
}
