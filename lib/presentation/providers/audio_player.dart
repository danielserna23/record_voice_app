import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import 'main_providers.dart';

part 'audio_player.g.dart';

@riverpod
class AudioPlayer extends _$AudioPlayer {
  late final AudioPlayerUseCase audioPlayerUseCase;
  @override
  AsyncValue<PlayerState> build() {
    audioPlayerUseCase = ref.watch(audioPlayerUseCaseProvider);
    return const AsyncValue.data(PlayerState.stopped);
  }

  Future<void> playAudio(String filePath) async {
    state = const AsyncLoading();

    try {
      await audioPlayerUseCase.playAudio(filePath);
      state = const AsyncData(
        PlayerState.playing,
      );
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> pause() async {
    await audioPlayerUseCase.stopAudio();
    state = const AsyncData(PlayerState.paused);
  }

  Future<void> stop() async {
    await audioPlayerUseCase.stopAudio();
    state = const AsyncData(PlayerState.stopped);
  }
}
