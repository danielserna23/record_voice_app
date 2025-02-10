import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:record_voice_app/data/data.dart';
import 'package:record_voice_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player.g.dart';

@riverpod
class AudioPlayer extends _$AudioPlayer {
  AudioPlayerService? _playerClient;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<void>? _playerCompleteSubscription;

  @override
  AudioPlayerState build(String filePath) {
    ref.onDispose(_disposeResources);
    return AudioPlayerState.initial();
  }

  Future<void> initialize() async {
    try {
      _playerClient = ref.read(audioPlayerServiceProvider);
      _setupListeners();

      await ref.read(audioPlayerUseCaseProvider).play(filePath);

      final initialDuration = await _playerClient!.player.getDuration();
      if (initialDuration != null) {
        state = state.copyWith(duration: initialDuration);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _setupListeners() {
    _durationSubscription = _playerClient?.durationChanged.listen((duration) {
      state = state.copyWith(
        duration: duration,
        isLoading: false,
      );
    });

    _positionSubscription = _playerClient?.positionChanged.listen((position) {
      state = state.copyWith(position: position);
    });

    _playerStateSubscription =
        _playerClient?.playerStateChanged.listen((state) {
      this.state = this.state.copyWith(playerState: state);
    });

    _playerCompleteSubscription = _playerClient?.playerComplete.listen((_) {
      state = state.copyWith(
        playerState: PlayerState.stopped,
        position: Duration.zero,
      );
    });
  }

  Future<void> seek(double seconds) async {
    await ref
        .read(audioPlayerUseCaseProvider)
        .seek(Duration(seconds: seconds.toInt()));
  }

  void updatePosition(Duration position) {
    state = state.copyWith(position: position);
  }

  Future<void> _disposeResources() async {
    await _playerClient?.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
  }
}

class AudioPlayerState {
  final Duration duration;
  final Duration position;
  final PlayerState playerState;
  final bool isLoading;
  final String? errorMessage;

  AudioPlayerState({
    required this.duration,
    required this.position,
    required this.playerState,
    required this.isLoading,
    this.errorMessage,
  });

  AudioPlayerState.initial()
      : this(
          duration: Duration.zero,
          position: Duration.zero,
          playerState: PlayerState.stopped,
          isLoading: false,
        );

  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    PlayerState? playerState,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AudioPlayerState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      playerState: playerState ?? this.playerState,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
