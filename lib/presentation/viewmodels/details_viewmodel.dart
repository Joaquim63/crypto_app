import 'package:crypto_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';
import 'package:crypto_app/domain/usecases/get_crypto_details.dart';
import 'package:crypto_app/domain/usecases/add_favorite_crypto.dart';
import 'package:crypto_app/domain/usecases/remove_favorite_crypto.dart';
import 'package:crypto_app/domain/usecases/is_crypto_favorite.dart';
import 'package:crypto_app/di/injection_container.dart';
import 'package:crypto_app/presentation/viewmodels/favorites_viewmodel.dart';
import 'dart:developer';

part 'details_viewmodel.g.dart';

// Defini o estado do DetailsViewModel como uma classe para encapsular tudo
class DetailsPageState {
  final AsyncValue<CryptoEntity?> cryptoDetails;
  final AsyncValue<bool> isFavorite;

  DetailsPageState({required this.cryptoDetails, required this.isFavorite});

  DetailsPageState copyWith({
    AsyncValue<CryptoEntity?>? cryptoDetails,
    AsyncValue<bool>? isFavorite,
  }) {
    return DetailsPageState(
      cryptoDetails: cryptoDetails ?? this.cryptoDetails,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@riverpod
class DetailsViewModel extends _$DetailsViewModel {
  static final Map<String, CryptoEntity> _cryptoDetailsCache = {};
  late final GetCryptoDetails _getCryptoDetails;
  late final AddFavoriteCrypto _addFavoriteCrypto;
  late final RemoveFavoriteCrypto _removeFavoriteCrypto;
  late final IsCryptoFavorite _isCryptoFavorite;
  CryptoEntity? _cachedCryptoDetails;

  Future<Either<Failure, CryptoEntity>> _fetchCryptoDetails(String id) async {
    // Verificar se os detalhes já estão em cache
    if (_cachedCryptoDetails != null && _cachedCryptoDetails!.id == id) {
      log(
        'DEBUG: _fetchCryptoDetails - Retornando detalhes do cache para ID: $id',
      );
      return Right(_cachedCryptoDetails!);
    }

    log('DEBUG: _fetchCryptoDetails - Buscando detalhes da API para ID: $id');
    final result = await _getCryptoDetails(id);
    return result.fold(
      (failure) {
        log(
          'ERROR: _fetchCryptoDetails - Falha ao buscar detalhes para ID: $id - ${failure.message}',
        );
        return Left(failure);
      },
      (crypto) {
        _cachedCryptoDetails =
            crypto; // Armazenar no cache se a busca for bem-sucedida
        log(
          'DEBUG: _fetchCryptoDetails - Detalhes da API carregados e armazenados em cache para ID: $id',
        );
        return Right(crypto);
      },
    );
  }

  String? _cryptoId; // Armazena o ID da criptomoeda atual

  @override
  Future<DetailsPageState> build(String cryptoId) async {
    _cryptoId = cryptoId; // Armazena o ID para uso posterior

    // Injeção dos Use Cases
    _getCryptoDetails = await ref.read(getCryptoDetailsProvider.future);
    _addFavoriteCrypto = await ref.read(addFavoriteCryptoProvider.future);
    _removeFavoriteCrypto = await ref.read(removeFavoriteCryptoProvider.future);
    _isCryptoFavorite = await ref.read(isCryptoFavoriteProvider.future);

    // Adiciona um listener para o FavoritesViewModel
    // Quando a lista de favoritos muda, reavalia o status de favorito desta criptomoeda
    ref.listen<AsyncValue<List<FavoriteCryptoEntity>>>(
      favoritesViewModelProvider,
      (previous, next) {
        _checkFavoriteStatus();
      },
    );

    // Carrega os detalhes da criptomoeda
    final detailsResult = await _fetchCryptoDetails(_cryptoId!);

    final crypto = detailsResult.fold(
      (failure) =>
          throw failure, // Lança a falha para ser capturada pelo AsyncValue.error
      (crypto) => crypto,
    );

    // Verifica o status de favorito inicial
    final isFavoriteResult = await _isCryptoFavorite(cryptoId);
    final isFav = isFavoriteResult.fold(
      (failure) => throw failure, // Lança a falha
      (isFav) => isFav,
    );

    return DetailsPageState(
      cryptoDetails: AsyncValue.data(crypto),
      isFavorite: AsyncValue.data(isFav),
    );
  }

  // método para verificar e atualizar o status de favorito
  Future<void> _checkFavoriteStatus() async {
    if (_cryptoId == null) return; // Não faz nada se o ID não estiver definido

    final currentDetailsState = state.value;
    if (currentDetailsState == null) return;

    final isFavoriteResult = await _isCryptoFavorite(_cryptoId!);
    isFavoriteResult.fold(
      (failure) {
        state = AsyncValue.data(
          currentDetailsState.copyWith(
            isFavorite: AsyncValue.error(failure, StackTrace.current),
          ),
        );
      },
      (isFav) {
        state = AsyncValue.data(
          currentDetailsState.copyWith(isFavorite: AsyncValue.data(isFav)),
        );
      },
    );
  }

  Future<void> toggleFavorite() async {
    final currentDetailsState = state.value;

    if (currentDetailsState != null &&
        currentDetailsState.cryptoDetails.hasValue) {
      final currentCrypto = currentDetailsState.cryptoDetails.value!;

      // Atualiza o estado de favorito para carregando
      state = AsyncValue.data(
        currentDetailsState.copyWith(isFavorite: const AsyncValue.loading()),
      );

      final favoriteEntity = FavoriteCryptoEntity(
        id: currentCrypto.id,
        symbol: currentCrypto.symbol,
        name: currentCrypto.name,
        image: currentCrypto.image,
        currentPrice: currentCrypto.currentPrice,
        marketCap: currentCrypto.marketCap,
        priceChangePercentage24h: currentCrypto.priceChangePercentage24h,
      );

      final currentIsFav = currentDetailsState.isFavorite.value ?? false;

      if (currentIsFav) {
        final result = await _removeFavoriteCrypto(currentCrypto.id);
        result.fold(
          (failure) => state = AsyncValue.data(
            currentDetailsState.copyWith(
              isFavorite: AsyncValue.error(failure, StackTrace.current),
            ),
          ),
          (_) {
            state = AsyncValue.data(
              currentDetailsState.copyWith(
                isFavorite: const AsyncValue.data(false),
              ),
            );
            ref.invalidate(
              favoritesViewModelProvider,
            ); // Invalida o FavoritesViewModel
          },
        );
      } else {
        final result = await _addFavoriteCrypto(favoriteEntity);
        result.fold(
          (failure) => state = AsyncValue.data(
            currentDetailsState.copyWith(
              isFavorite: AsyncValue.error(failure, StackTrace.current),
            ),
          ),
          (_) {
            state = AsyncValue.data(
              currentDetailsState.copyWith(
                isFavorite: const AsyncValue.data(true),
              ),
            );
            ref.invalidate(
              favoritesViewModelProvider,
            ); // Invalida o FavoritesViewModel
          },
        );
      }
    }
  }
}
