import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_voice_app/presentation/widgets/audio_player_widget.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioProvider);
    final uploadState = ref.watch(audioUploadProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (audioState.value == AudioState.empty ||
                    audioState.value == AudioState.stopped) {
                  await ref.read(audioProvider.notifier).startRecording();
                } else {
                  await ref.read(audioProvider.notifier).stopRecording();
                }
              },
              child: Text(
                audioState.value == AudioState.recording ? 'Detener' : 'Grabar',
              ),
            ),
            if (audioState.value == AudioState.uploading) ...[
              uploadState.when(
                data: (progress) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        LinearProgressIndicator(value: progress),
                        Text(
                          'Progreso: ${(progress * 100).toStringAsFixed(0)}%',
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('Error: $error'),
              ),
            ],
            if (audioState.value == AudioState.loaded) ...[
              const AudioPlayerWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
