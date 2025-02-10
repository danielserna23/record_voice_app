import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class AudioPlayerWidget extends ConsumerWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PlayerContent(),
        ],
      ),
    );
  }
}

class _PlayerContent extends ConsumerStatefulWidget {
  const _PlayerContent();

  @override
  PlayerContentState createState() => PlayerContentState();
}

class PlayerContentState extends ConsumerState<_PlayerContent> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final filePath = ref.watch(audioProvider.notifier).filePath;
    final state = ref.watch(audioPlayerProvider(filePath!));
    final notifier = ref.read(audioPlayerProvider(filePath).notifier);
    return Column(
      children: [
        _ProgressSlider(
          duration: state.duration,
          position: state.position,
          onChanged: notifier.seek,
        ),
        const SizedBox(height: 30),
        _PlayerControls(
          playerState: state.playerState,
          onPlayPause: notifier.initialize,
        ),
        const SizedBox(height: 20),
        _TimeDisplay(
          currentPosition: state.position,
          totalDuration: state.duration,
        ),
      ],
    );
  }
}

class _ProgressSlider extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<double> onChanged;

  const _ProgressSlider({
    required this.duration,
    required this.position,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: onChanged,
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: const TextStyle(color: Colors.deepPurple),
              ),
              Text(
                _formatDuration(duration - position),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    return "${d.inMinutes.toString().padLeft(2, '0')}:"
        "${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}

class _PlayerControls extends StatelessWidget {
  final PlayerState playerState;
  final VoidCallback onPlayPause;

  const _PlayerControls({
    required this.playerState,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 60,
          icon: _AnimatedPlayPauseIcon(
            isPlaying: playerState == PlayerState.playing,
          ),
          onPressed: onPlayPause,
        ),
      ],
    );
  }
}

class _AnimatedPlayPauseIcon extends StatelessWidget {
  final bool isPlaying;

  const _AnimatedPlayPauseIcon({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Icon(
        Icons.play_circle_filled,
        key: ValueKey<bool>(isPlaying),
      ),
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  final Duration currentPosition;
  final Duration totalDuration;

  const _TimeDisplay({
    required this.currentPosition,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_formatTime(currentPosition)} / ${_formatTime(totalDuration)}',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return [
      if (hours > 0) twoDigits(hours),
      twoDigits(minutes),
      twoDigits(seconds),
    ].join(':');
  }
}
