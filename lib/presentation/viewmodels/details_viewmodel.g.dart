// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailsViewModelHash() => r'd8c4d76ec5c31129ce79e41f858e8248350a5ba2';

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

abstract class _$DetailsViewModel
    extends BuildlessAutoDisposeAsyncNotifier<DetailsPageState> {
  late final String cryptoId;

  FutureOr<DetailsPageState> build(
    String cryptoId,
  );
}

/// See also [DetailsViewModel].
@ProviderFor(DetailsViewModel)
const detailsViewModelProvider = DetailsViewModelFamily();

/// See also [DetailsViewModel].
class DetailsViewModelFamily extends Family<AsyncValue<DetailsPageState>> {
  /// See also [DetailsViewModel].
  const DetailsViewModelFamily();

  /// See also [DetailsViewModel].
  DetailsViewModelProvider call(
    String cryptoId,
  ) {
    return DetailsViewModelProvider(
      cryptoId,
    );
  }

  @override
  DetailsViewModelProvider getProviderOverride(
    covariant DetailsViewModelProvider provider,
  ) {
    return call(
      provider.cryptoId,
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
  String? get name => r'detailsViewModelProvider';
}

/// See also [DetailsViewModel].
class DetailsViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DetailsViewModel, DetailsPageState> {
  /// See also [DetailsViewModel].
  DetailsViewModelProvider(
    String cryptoId,
  ) : this._internal(
          () => DetailsViewModel()..cryptoId = cryptoId,
          from: detailsViewModelProvider,
          name: r'detailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailsViewModelHash,
          dependencies: DetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              DetailsViewModelFamily._allTransitiveDependencies,
          cryptoId: cryptoId,
        );

  DetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cryptoId,
  }) : super.internal();

  final String cryptoId;

  @override
  FutureOr<DetailsPageState> runNotifierBuild(
    covariant DetailsViewModel notifier,
  ) {
    return notifier.build(
      cryptoId,
    );
  }

  @override
  Override overrideWith(DetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailsViewModelProvider._internal(
        () => create()..cryptoId = cryptoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cryptoId: cryptoId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailsViewModel, DetailsPageState>
      createElement() {
    return _DetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailsViewModelProvider && other.cryptoId == cryptoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cryptoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailsViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<DetailsPageState> {
  /// The parameter `cryptoId` of this provider.
  String get cryptoId;
}

class _DetailsViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailsViewModel,
        DetailsPageState> with DetailsViewModelRef {
  _DetailsViewModelProviderElement(super.provider);

  @override
  String get cryptoId => (origin as DetailsViewModelProvider).cryptoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
