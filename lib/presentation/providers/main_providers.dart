import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

part 'main_providers.g.dart';

@riverpod
AudioRecorderUseCase audioRecorderUseCase(Ref ref) {
  return AudioRecorderUseCase(
    AudioRepositoryImpl(
      AudioRecorderService(),
    ),
  );
}

@riverpod
AudioPlayerUseCase audioPlayerUseCase(Ref ref) {
  return AudioPlayerUseCase(
    AudioPlayerRepositoryImpl(
      AudioPlayerService(),
    ),
  );
}

@riverpod
AudioUploadUseCase audioUploadUseCase(Ref ref) {
  return AudioUploadUseCase(
    AudioUploadRepositoryImpl(
      StorageService(),
    ),
  );
}
