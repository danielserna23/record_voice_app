import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _filePath;

  Future<bool> hasPermissions() async {
    return await _recorder.hasPermission();
  }

  Future<String?> startRecording() async {
    if (await hasPermissions()) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath =
          '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      const recordConfig = RecordConfig();
      await _recorder.start(recordConfig, path: _filePath!);

      return _filePath;
    }
    return null;
  }

  Future<String?> stopRecording() async {
    return await _recorder.stop();
  }
}
