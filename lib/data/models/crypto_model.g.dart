// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoModel _$CryptoModelFromJson(Map<String, dynamic> json) => CryptoModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: CryptoModel._imageFromJson(json['image']),
      currentPrice: json['market_data.current_price.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.current_price.usd']),
      marketCap: json['market_data.market_cap.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.market_cap.usd']),
      marketCapRank:
          (json['market_data.market_cap_rank'] as num?)?.toInt() ?? 0,
      high24h: json['market_data.high_24h.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.high_24h.usd']),
      low24h: json['market_data.low_24h.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.low_24h.usd']),
      priceChange24h:
          json['market_data.price_change_24h_in_currency.usd'] == null
              ? 0.0
              : CryptoModel._priceFromJson(
                  json['market_data.price_change_24h_in_currency.usd']),
      priceChangePercentage24h: json[
                  'market_data.price_change_percentage_24h_in_currency.usd'] ==
              null
          ? 0.0
          : CryptoModel._percentageFromJson(
              json['market_data.price_change_percentage_24h_in_currency.usd']),
      marketCapChange24h:
          json['market_data.market_cap_change_24h_in_currency.usd'] == null
              ? 0.0
              : CryptoModel._priceFromJson(
                  json['market_data.market_cap_change_24h_in_currency.usd']),
      marketCapChangePercentage24h:
          json['market_data.market_cap_change_percentage_24h_in_currency.usd'] ==
                  null
              ? 0.0
              : CryptoModel._percentageFromJson(json[
                  'market_data.market_cap_change_percentage_24h_in_currency.usd']),
      circulatingSupply:
          CryptoModel._priceFromJson(json['market_data.circulating_supply']),
      totalSupply: CryptoModel._priceFromJson(json['market_data.total_supply']),
      maxSupply: CryptoModel._priceFromJson(json['market_data.max_supply']),
      ath: json['market_data.ath.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.ath.usd']),
      athChangePercentage: json['market_data.ath_change_percentage.usd'] == null
          ? 0.0
          : CryptoModel._percentageFromJson(
              json['market_data.ath_change_percentage.usd']),
      athDate: json['market_data.ath_date.usd'] == null
          ? ''
          : CryptoModel._dateFromJson(json['market_data.ath_date.usd']),
      atl: json['market_data.atl.usd'] == null
          ? 0.0
          : CryptoModel._priceFromJson(json['market_data.atl.usd']),
      atlChangePercentage: json['market_data.atl_change_percentage.usd'] == null
          ? 0.0
          : CryptoModel._percentageFromJson(
              json['market_data.atl_change_percentage.usd']),
      atlDate: json['market_data.atl_date.usd'] == null
          ? ''
          : CryptoModel._dateFromJson(json['market_data.atl_date.usd']),
      roi: CryptoModel._roiFromJson(json['market_data.roi']),
      lastUpdated: json['last_updated'] == null
          ? ''
          : CryptoModel._dateFromJson(json['last_updated']),
      priceChangePercentage7dInCurrency: json[
                  'market_data.price_change_percentage_7d_in_currency.usd'] ==
              null
          ? 0.0
          : CryptoModel._percentageFromJson(
              json['market_data.price_change_percentage_7d_in_currency.usd']),
    );

Map<String, dynamic> _$CryptoModelToJson(CryptoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': CryptoModel._imageToJson(instance.image),
      'market_data.current_price.usd': instance.currentPrice,
      'market_data.market_cap.usd': instance.marketCap,
      'market_data.market_cap_rank': instance.marketCapRank,
      'market_data.high_24h.usd': instance.high24h,
      'market_data.low_24h.usd': instance.low24h,
      'market_data.price_change_24h_in_currency.usd': instance.priceChange24h,
      'market_data.price_change_percentage_24h_in_currency.usd':
          instance.priceChangePercentage24h,
      'market_data.market_cap_change_24h_in_currency.usd':
          instance.marketCapChange24h,
      'market_data.market_cap_change_percentage_24h_in_currency.usd':
          instance.marketCapChangePercentage24h,
      'market_data.circulating_supply': instance.circulatingSupply,
      'market_data.total_supply': instance.totalSupply,
      'market_data.max_supply': instance.maxSupply,
      'market_data.ath.usd': instance.ath,
      'market_data.ath_change_percentage.usd': instance.athChangePercentage,
      'market_data.ath_date.usd': instance.athDate,
      'market_data.atl.usd': instance.atl,
      'market_data.atl_change_percentage.usd': instance.atlChangePercentage,
      'market_data.atl_date.usd': instance.atlDate,
      'market_data.roi': instance.roi,
      'last_updated': instance.lastUpdated,
      'market_data.price_change_percentage_7d_in_currency.usd':
          instance.priceChangePercentage7dInCurrency,
    };
