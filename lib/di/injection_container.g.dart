
part of 'injection_container.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'edf93c0df13617c6a7f454eed6074678513bd570';

/// Provider para a instância do Dio
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = ProviderRef<Dio>;
String _$dioClientHash() => r'4a64c04c5dd51a7130e7ccac51809c4df96a6920';

/// Provider para o DioClient (wrapper do Dio)
///
/// Copied from [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = Provider<DioClient>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioClientRef = ProviderRef<DioClient>;
String _$favoriteCryptosBoxHash() =>
    r'f84b1a31fa8b3acdf363162bf11b199e5a7f102e';

/// Provider para a Box do Hive de favoritos
///
/// Copied from [favoriteCryptosBox].
@ProviderFor(favoriteCryptosBox)
final favoriteCryptosBoxProvider =
    FutureProvider<Box<FavoriteCryptoModel>>.internal(
  favoriteCryptosBox,
  name: r'favoriteCryptosBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteCryptosBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteCryptosBoxRef = FutureProviderRef<Box<FavoriteCryptoModel>>;
String _$cryptoRemoteDataSourceHash() =>
    r'f2e04ee64999cbc20fead1a8e78e622d909fc96e';

/// Provider para o CryptoRemoteDataSource
///
/// Copied from [cryptoRemoteDataSource].
@ProviderFor(cryptoRemoteDataSource)
final cryptoRemoteDataSourceProvider =
    Provider<CryptoRemoteDataSource>.internal(
  cryptoRemoteDataSource,
  name: r'cryptoRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cryptoRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CryptoRemoteDataSourceRef = ProviderRef<CryptoRemoteDataSource>;
String _$cryptoLocalDataSourceHash() =>
    r'662edfa65397358f8c35c55a81d1b8cdb854433c';

/// Provider para o CryptoLocalDataSource
///
/// Copied from [cryptoLocalDataSource].
@ProviderFor(cryptoLocalDataSource)
final cryptoLocalDataSourceProvider =
    FutureProvider<CryptoLocalDataSource>.internal(
  cryptoLocalDataSource,
  name: r'cryptoLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cryptoLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CryptoLocalDataSourceRef = FutureProviderRef<CryptoLocalDataSource>;
String _$cryptoRepositoryHash() => r'9e3c88f3f06ad163c62b7d8b0567d758d93f71b1';

/// Provider para o CryptoRepository (implementação)
///
/// Copied from [cryptoRepository].
@ProviderFor(cryptoRepository)
final cryptoRepositoryProvider = FutureProvider<CryptoRepository>.internal(
  cryptoRepository,
  name: r'cryptoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cryptoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CryptoRepositoryRef = FutureProviderRef<CryptoRepository>;
String _$searchCryptosHash() => r'608fb2675d0ebfc34a5660801d7276e11498fd8d';

/// Provider para o SearchCryptos Use Case
///
/// Copied from [searchCryptos].
@ProviderFor(searchCryptos)
final searchCryptosProvider = FutureProvider<SearchCryptos>.internal(
  searchCryptos,
  name: r'searchCryptosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchCryptosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchCryptosRef = FutureProviderRef<SearchCryptos>;
String _$getTrendingCryptosHash() =>
    r'607d1c92f3dd60b90b9e339723b31b0efe6a8e11';

/// Provider para o GetTrendingCryptos Use Case
///
/// Copied from [getTrendingCryptos].
@ProviderFor(getTrendingCryptos)
final getTrendingCryptosProvider = FutureProvider<GetTrendingCryptos>.internal(
  getTrendingCryptos,
  name: r'getTrendingCryptosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTrendingCryptosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetTrendingCryptosRef = FutureProviderRef<GetTrendingCryptos>;
String _$getCryptoDetailsHash() => r'90928e423e3ac41f7996cf6160acf5cea2a42647';

/// Provider para o GetCryptoDetails Use Case
///
/// Copied from [getCryptoDetails].
@ProviderFor(getCryptoDetails)
final getCryptoDetailsProvider = FutureProvider<GetCryptoDetails>.internal(
  getCryptoDetails,
  name: r'getCryptoDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCryptoDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCryptoDetailsRef = FutureProviderRef<GetCryptoDetails>;
String _$addFavoriteCryptoHash() => r'3e6cc944d897b30efb448c9641a2971b624fb8f9';

/// Provider para o AddFavoriteCrypto Use Case
///
/// Copied from [addFavoriteCrypto].
@ProviderFor(addFavoriteCrypto)
final addFavoriteCryptoProvider = FutureProvider<AddFavoriteCrypto>.internal(
  addFavoriteCrypto,
  name: r'addFavoriteCryptoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addFavoriteCryptoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddFavoriteCryptoRef = FutureProviderRef<AddFavoriteCrypto>;
String _$removeFavoriteCryptoHash() =>
    r'e7cf861f50c8235c579ba0f64c7d72686564b299';

/// Provider para o RemoveFavoriteCrypto Use Case
///
/// Copied from [removeFavoriteCrypto].
@ProviderFor(removeFavoriteCrypto)
final removeFavoriteCryptoProvider =
    FutureProvider<RemoveFavoriteCrypto>.internal(
  removeFavoriteCrypto,
  name: r'removeFavoriteCryptoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$removeFavoriteCryptoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemoveFavoriteCryptoRef = FutureProviderRef<RemoveFavoriteCrypto>;
String _$getFavoriteCryptosHash() =>
    r'9cfd29880d43e24a1dd6f077cb5f983d78e89753';

/// Provider para o GetFavoriteCryptos Use Case
///
/// Copied from [getFavoriteCryptos].
@ProviderFor(getFavoriteCryptos)
final getFavoriteCryptosProvider = FutureProvider<GetFavoriteCryptos>.internal(
  getFavoriteCryptos,
  name: r'getFavoriteCryptosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFavoriteCryptosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFavoriteCryptosRef = FutureProviderRef<GetFavoriteCryptos>;
String _$isCryptoFavoriteHash() => r'28f7ab87bb0af7e97c88f1fa5795b627d066629a';

/// Provider para o IsCryptoFavorite Use Case
///
/// Copied from [isCryptoFavorite].
@ProviderFor(isCryptoFavorite)
final isCryptoFavoriteProvider = FutureProvider<IsCryptoFavorite>.internal(
  isCryptoFavorite,
  name: r'isCryptoFavoriteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCryptoFavoriteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsCryptoFavoriteRef = FutureProviderRef<IsCryptoFavorite>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
