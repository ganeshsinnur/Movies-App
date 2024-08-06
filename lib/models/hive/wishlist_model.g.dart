// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishMoviesAdapter extends TypeAdapter<WishMovies> {
  @override
  final int typeId = 0;

  @override
  WishMovies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishMovies(
      backdropPath: fields[0] as String,
      genreIds: (fields[1] as List).cast<int>(),
      id: fields[2] as int,
      originalLanguage: fields[3] as String,
      originalTitle: fields[4] as String,
      overview: fields[5] as String,
      posterPath: fields[6] as String,
      releaseDate: fields[7] as DateTime,
      title: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishMovies obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.backdropPath)
      ..writeByte(1)
      ..write(obj.genreIds)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.originalLanguage)
      ..writeByte(4)
      ..write(obj.originalTitle)
      ..writeByte(5)
      ..write(obj.overview)
      ..writeByte(6)
      ..write(obj.posterPath)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishMoviesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
