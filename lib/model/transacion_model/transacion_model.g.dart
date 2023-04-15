// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacion_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransacionModelAdapter extends TypeAdapter<TransacionModel> {
  @override
  final int typeId = 3;

  @override
  TransacionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransacionModel(
      id: fields[1] as String,
      model: fields[2] as CategoryModel,
      date: fields[4] as DateTime,
      amount: fields[5] as double,
      type: fields[3] as CategoryType,
    );
  }

  @override
  void write(BinaryWriter writer, TransacionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransacionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
