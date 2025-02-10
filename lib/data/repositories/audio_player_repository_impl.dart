import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:record_voice_app/data/data.dart';

import '../../domain/domain.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AudioPlayerService _audioPlayerService;

  AudioPlayerRepositoryImpl(this._audioPlayerService);

  @override
  Future<void> dispose() async {
    await _audioPlayerService.dispose();
  }

  @override
  Future<Uint8List> getAudioBytes(String filePath) async {
    final newFile = File(filePath);
    final ref =
        _storage.ref().child('voice_notes/${newFile.uri.pathSegments.last}');
    final bytes = await ref.getData();
    if (bytes == null) throw Exception('Audio not found');
    return bytes;
  }
}
