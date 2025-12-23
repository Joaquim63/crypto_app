// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_crypto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCryptoModelAdapter extends TypeAdapter<FavoriteCryptoModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteCryptoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCryptoModel(
      id: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      image: fields[3] as String,
      currentPrice: fields[4] as double,
      marketCap: fields[5] as double,
      priceChangePercentage24h: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCryptoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.currentPrice)
      ..writeByte(5)
      ..write(obj.marketCap)
      ..writeByte(6)
      ..write(obj.priceChangePercentage24h);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCryptoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
