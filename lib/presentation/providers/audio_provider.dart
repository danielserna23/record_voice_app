import 'package:record_voice_app/domain/domain.dart';
import 'package:record_voice_app/presentation/providers/audio_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'audio_upload.dart';
import 'main_providers.dart';

part 'audio_provider.g.dart';

@riverpod
class Audio extends _$Audio {
  late final AudioRecorderUseCase _audioRecorderUseCase;

  String? _filePath;

  String? get filePath => _filePath;

  @override
  AsyncValue<AudioState> build() {
    _audioRecorderUseCase = ref.watch(audioRecorderUseCaseProvider);
    return const AsyncValue.data(AudioState.empty);
  }

  Future<void> startRecording() async {
    try {
      state = const AsyncValue.loading();
      await _audioRecorderUseCase.startRecording();
      state = const AsyncValue.data(AudioState.recording);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> stopRecording() async {
    try {
      final filePath = await _audioRecorderUseCase.stopRecording();
      state = const AsyncValue.data(AudioState.stopped);
      if (filePath != null) {
        _filePath = filePath;
        state = const AsyncValue.data(AudioState.uploading);
        await ref.watch(audioUploadProvider.notifier).uploadAudio(filePath);

        Future.delayed(const Duration(seconds: 1), () {
          state = const AsyncValue.data(AudioState.loaded);
        });
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> playAudio() async {
    return await ref.watch(audioPlayerProvider.notifier).playAudio(filePath!);
  }
}
