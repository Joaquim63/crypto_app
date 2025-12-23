// lib/data/models/crypto_model.dart
import 'package:crypto_app/domain/entities/crypto_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:developer';

part 'crypto_model.g.dart';

@JsonSerializable()
class CryptoModel extends CryptoEntity {
  const CryptoModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.marketCap,
    super.marketCapRank,
    required super.high24h,
    required super.low24h,
    required super.priceChange24h,
    required super.priceChangePercentage24h,
    required super.marketCapChange24h,
    required super.marketCapChangePercentage24h,
    super.circulatingSupply,
    super.totalSupply,
    super.maxSupply,
    required super.ath,
    required super.athChangePercentage,
    required super.athDate,
    required super.atl,
    required super.atlChangePercentage,
    required super.atlDate,
    super.roi,
    required super.lastUpdated,
    required super.priceChangePercentage7dInCurrency,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoModelFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoModelToJson(this);

  // Mapeia a imagem aninhada para uma URL de string
  @JsonKey(name: 'image', fromJson: _imageFromJson, toJson: _imageToJson)
  @override
  String get image => super.image; // Sobrescreve o getter para usar a lógica do JsonKey

  static String _imageFromJson(dynamic imageJson) {
    if (imageJson == null) return '';
    if (imageJson is String)
      return imageJson; // Para API de busca/trending que pode ter URL direta
    if (imageJson is Map<String, dynamic>) {
      return imageJson['large'] as String? ??
          imageJson['small'] as String? ??
          imageJson['thumb'] as String? ??
          '';
    }
    return '';
  }

  static Map<String, dynamic> _imageToJson(String image) => {'large': image};

  // Mapeia o preço atual de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.current_price.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get currentPrice => super.currentPrice;

  // Mapeia o market cap de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.market_cap.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get marketCap => super.marketCap;

  // Mapeia o marketCapRank (int)
  @JsonKey(name: 'market_data.market_cap_rank', defaultValue: 0)
  @override
  int? get marketCapRank => super.marketCapRank;

  // Mapeia high24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.high_24h.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get high24h => super.high24h;

  // Mapeia low24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.low_24h.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get low24h => super.low24h;

  // Mapeia priceChange24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.price_change_24h_in_currency.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get priceChange24h => super.priceChange24h;

  // Mapeia priceChangePercentage24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.price_change_percentage_24h_in_currency.usd',
    fromJson: _percentageFromJson,
    defaultValue: 0.0,
  )
  @override
  double get priceChangePercentage24h => super.priceChangePercentage24h;

  // Mapeia marketCapChange24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.market_cap_change_24h_in_currency.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get marketCapChange24h => super.marketCapChange24h;

  // Mapeia marketCapChangePercentage24h de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.market_cap_change_percentage_24h_in_currency.usd',
    fromJson: _percentageFromJson,
    defaultValue: 0.0,
  )
  @override
  double get marketCapChangePercentage24h => super.marketCapChangePercentage24h;

  // Mapeia circulatingSupply
  @JsonKey(name: 'market_data.circulating_supply', fromJson: _priceFromJson)
  @override
  double? get circulatingSupply => super.circulatingSupply;

  // Mapeia totalSupply
  @JsonKey(name: 'market_data.total_supply', fromJson: _priceFromJson)
  @override
  double? get totalSupply => super.totalSupply;

  // Mapeia maxSupply
  @JsonKey(name: 'market_data.max_supply', fromJson: _priceFromJson)
  @override
  double? get maxSupply => super.maxSupply;

  // Mapeia ath de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.ath.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get ath => super.ath;

  // Mapeia athChangePercentage de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.ath_change_percentage.usd',
    fromJson: _percentageFromJson,
    defaultValue: 0.0,
  )
  @override
  double get athChangePercentage => super.athChangePercentage;

  // Mapeia athDate de um mapa aninhado para String
  @JsonKey(
    name: 'market_data.ath_date.usd',
    fromJson: _dateFromJson,
    defaultValue: '',
  )
  @override
  String get athDate => super.athDate;

  // Mapeia atl de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.atl.usd',
    fromJson: _priceFromJson,
    defaultValue: 0.0,
  )
  @override
  double get atl => super.atl;

  // Mapeia atlChangePercentage de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.atl_change_percentage.usd',
    fromJson: _percentageFromJson,
    defaultValue: 0.0,
  )
  @override
  double get atlChangePercentage => super.atlChangePercentage;

  // Mapeia atlDate de um mapa aninhado para String
  @JsonKey(
    name: 'market_data.atl_date.usd',
    fromJson: _dateFromJson,
    defaultValue: '',
  )
  @override
  String get atlDate => super.atlDate;

  // Mapeia roi de um mapa aninhado para double
  @JsonKey(name: 'market_data.roi', fromJson: _roiFromJson)
  @override
  double? get roi => super.roi;

  // Mapeia lastUpdated
  @JsonKey(name: 'last_updated', fromJson: _dateFromJson, defaultValue: '')
  @override
  String get lastUpdated => super.lastUpdated;

  // Mapeia priceChangePercentage7dInCurrency de um mapa aninhado para double
  @JsonKey(
    name: 'market_data.price_change_percentage_7d_in_currency.usd',
    fromJson: _percentageFromJson,
    defaultValue: 0.0,
  )
  @override
  double get priceChangePercentage7dInCurrency =>
      super.priceChangePercentage7dInCurrency;

  // --- Funções estáticas auxiliares para JsonKey fromJson ---

  static double _priceFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    log(
      'WARNING: _priceFromJson - Valor inesperado para preço: $value. Retornando 0.0',
    );
    return 0.0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is Map<String, dynamic>) {
      // Algumas APIs podem retornar um mapa com a porcentagem dentro (ex: {'usd': 1.23})
      final usdValue = value['usd'];
      if (usdValue is num) return usdValue.toDouble();
      if (usdValue is String) {
        final parsed = double.tryParse(usdValue);
        if (parsed != null) return parsed;
      }
    }
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    log(
      'WARNING: _percentageFromJson - Valor inesperado para porcentagem: $value. Retornando 0.0',
    );
    return 0.0;
  }

  static String _dateFromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    log(
      'WARNING: _dateFromJson - Valor inesperado para data: $value. Retornando string vazia.',
    );
    return '';
  }

  static double? _roiFromJson(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is Map<String, dynamic>) {
      final percentage = value['percentage'];
      if (percentage is num) return percentage.toDouble();
      final times = value['times'];
      if (times is num) return times.toDouble();
    }
    log(
      'WARNING: _roiFromJson - Valor inesperado para ROI: $value. Retornando null.',
    );
    return null;
  }
}
