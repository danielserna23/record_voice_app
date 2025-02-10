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

  Future<void> deleteAllFiles() async {
    final storageRef = FirebaseStorage.instance.ref().child(
          'voice_notes',
        ); // Reemplaza 'voice_notes' con la ruta a tu carpeta

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
