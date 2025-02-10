import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'main_providers.dart';

part 'audio_upload.g.dart';

@riverpod
class AudioUpload extends _$AudioUpload {
  @override
  AsyncValue<double> build() => const AsyncValue.data(0.0);

  Future<void> uploadAudio(String filePath) async {
    state = const AsyncValue.loading();
    try {
      final audioUpload = ref.read(audioUploadUseCaseProvider);
      final uploadStream = audioUpload.uploadAudio(filePath, 'audio');

      await for (final progress in uploadStream) {
        state = AsyncValue.data(progress);
      }
      state = const AsyncValue.data(1.0);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
