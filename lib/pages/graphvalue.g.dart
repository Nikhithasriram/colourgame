// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphvalue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GraphvalueAdapter extends TypeAdapter<Graphvalue> {
  @override
  final int typeId = 0;

  @override
  Graphvalue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Graphvalue(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Graphvalue obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.game)
      ..writeByte(1)
      ..write(obj.wrong)
      ..writeByte(2)
      ..write(obj.correct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraphvalueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
