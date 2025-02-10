import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<double> uploadAudio(String filePath, String fileName) {
    deleteAllFiles();
    final newFile = File(filePath);
    final ref =
        _storage.ref().child('voice_notes/${newFile.uri.pathSegments.last}');
    final uploadTask = ref.putFile(newFile);
    return uploadTask.snapshotEvents.map((task) {
      return task.bytesTransferred / task.totalBytes;
    });
  }

// decidí usar este método para borrar los audios de la nube, evitando así posibles cobros por espacio lleno por parte de Google
  Future<void> deleteAllFiles() async {
    final storageRef = FirebaseStorage.instance.ref().child(
          'voice_notes',
        );

    try {
      final listResult = await storageRef.listAll();

      for (final item in listResult.items) {
        await item.delete();
      }
    } catch (e) {
      Exception(e);
    }
  }
}
