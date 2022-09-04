// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class baseAdapter extends TypeAdapter<base> {
  @override
  final int typeId = 0;

  @override
  base read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return base()
      ..Direction = fields[0] as String
      ..Fournisseur = fields[1] as String
      ..NumberSim = fields[2] as int
      ..CodeBox = fields[3] as String
      ..DateA = fields[4] as DateTime
      ..DateFA = fields[5] as DateTime
      ..DateNO = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, base obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.Direction)
      ..writeByte(1)
      ..write(obj.Fournisseur)
      ..writeByte(2)
      ..write(obj.NumberSim)
      ..writeByte(3)
      ..write(obj.CodeBox)
      ..writeByte(4)
      ..write(obj.DateA)
      ..writeByte(5)
      ..write(obj.DateFA)
      ..writeByte(6)
      ..write(obj.DateNO);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is baseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
