import 'package:equatable/equatable.dart';

class FavoriteCryptoEntity extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final double priceChangePercentage24h;

  const FavoriteCryptoEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
  });

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    image,
    currentPrice,
    marketCap,
    priceChangePercentage24h,
  ];
}