// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavourModelAdapter extends TypeAdapter<FavourModel> {
  @override
  final int typeId = 1;

  @override
  FavourModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavourModel(
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavourModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavourModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
