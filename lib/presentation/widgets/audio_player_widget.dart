import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';

class AudioPlayerWidget extends ConsumerWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerProvider);
    return playerState.when(
      data: (state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (state == PlayerState.playing) {
                    ref.read(audioPlayerProvider.notifier).pause();
                  } else {
                    ref.read(audioProvider.notifier).playAudio();
                  }
                },
                icon: Icon(
                  state == PlayerState.playing ? Icons.pause : Icons.play_arrow,
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(audioPlayerProvider.notifier).stop();
                },
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
        ],
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}
