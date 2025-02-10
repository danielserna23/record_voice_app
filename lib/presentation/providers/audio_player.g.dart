// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerHash() => r'eb861868cbc16c0a8a8babc61a718af5737dee66';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AudioPlayer
    extends BuildlessAutoDisposeNotifier<AudioPlayerState> {
  late final String filePath;

  AudioPlayerState build(
    String filePath,
  );
}

/// See also [AudioPlayer].
@ProviderFor(AudioPlayer)
const audioPlayerProvider = AudioPlayerFamily();

/// See also [AudioPlayer].
class AudioPlayerFamily extends Family<AudioPlayerState> {
  /// See also [AudioPlayer].
  const AudioPlayerFamily();

  /// See also [AudioPlayer].
  AudioPlayerProvider call(
    String filePath,
  ) {
    return AudioPlayerProvider(
      filePath,
    );
  }

  @override
  AudioPlayerProvider getProviderOverride(
    covariant AudioPlayerProvider provider,
  ) {
    return call(
      provider.filePath,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'audioPlayerProvider';
}

/// See also [AudioPlayer].
class AudioPlayerProvider
    extends AutoDisposeNotifierProviderImpl<AudioPlayer, AudioPlayerState> {
  /// See also [AudioPlayer].
  AudioPlayerProvider(
    String filePath,
  ) : this._internal(
          () => AudioPlayer()..filePath = filePath,
          from: audioPlayerProvider,
          name: r'audioPlayerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$audioPlayerHash,
          dependencies: AudioPlayerFamily._dependencies,
          allTransitiveDependencies:
              AudioPlayerFamily._allTransitiveDependencies,
          filePath: filePath,
        );

  AudioPlayerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filePath,
  }) : super.internal();

  final String filePath;

  @override
  AudioPlayerState runNotifierBuild(
    covariant AudioPlayer notifier,
  ) {
    return notifier.build(
      filePath,
    );
  }

  @override
  Override overrideWith(AudioPlayer Function() create) {
    return ProviderOverride(
      origin: this,
      override: AudioPlayerProvider._internal(
        () => create()..filePath = filePath,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filePath: filePath,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AudioPlayer, AudioPlayerState>
      createElement() {
    return _AudioPlayerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioPlayerProvider && other.filePath == filePath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filePath.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AudioPlayerRef on AutoDisposeNotifierProviderRef<AudioPlayerState> {
  /// The parameter `filePath` of this provider.
  String get filePath;
}

class _AudioPlayerProviderElement
    extends AutoDisposeNotifierProviderElement<AudioPlayer, AudioPlayerState>
    with AudioPlayerRef {
  _AudioPlayerProviderElement(super.provider);

  @override
  String get filePath => (origin as AudioPlayerProvider).filePath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
