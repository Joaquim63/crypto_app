import 'package:hive/hive.dart';
import 'package:crypto_app/domain/entities/favorite_crypto_entity.dart';

part 'favorite_crypto_model.g.dart'; 

@HiveType(
  typeId: 0,
) // Importante: typeId deve ser único para cada adaptador Hive
class FavoriteCryptoModel extends FavoriteCryptoEntity {
  @override
  @HiveField(0)
  // ignore: overridden_fields
  final String id;
  @override
  @HiveField(1)
  // ignore: overridden_fields
  final String symbol;
  @override
  @HiveField(2)
  // ignore: overridden_fields
  final String name;
  @override
  @HiveField(3)
  // ignore: overridden_fields
  final String image;
  @override
  @HiveField(4)
  // ignore: overridden_fields
  final double currentPrice;
  @override
  @HiveField(5)
  // ignore: overridden_fields
  final double marketCap;
  @override
  @HiveField(6)
  // ignore: overridden_fields
  final double priceChangePercentage24h;

  const FavoriteCryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
  }) : super(
         id: id,
         symbol: symbol,
         name: name,
         image: image,
         currentPrice: currentPrice,
         marketCap: marketCap,
         priceChangePercentage24h: priceChangePercentage24h,
       );

  factory FavoriteCryptoModel.fromEntity(FavoriteCryptoEntity entity) {
    return FavoriteCryptoModel(
      id: entity.id,
      symbol: entity.symbol,
      name: entity.name,
      image: entity.image,
      currentPrice: entity.currentPrice,
      marketCap: entity.marketCap,
      priceChangePercentage24h: entity.priceChangePercentage24h,
    );
  }

  FavoriteCryptoEntity toEntity() {
    return FavoriteCryptoEntity(
      id: id,
      symbol: symbol,
      name: name,
      image: image,
      currentPrice: currentPrice,
      marketCap: marketCap,
      priceChangePercentage24h: priceChangePercentage24h,
    );
  }
}
