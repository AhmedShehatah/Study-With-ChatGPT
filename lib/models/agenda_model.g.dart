// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgendaModelAdapter extends TypeAdapter<AgendaModel> {
  @override
  final int typeId = 1;

  @override
  AgendaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgendaModel(
      title: fields[0] as String,
      date: fields[1] as DateTime,
      isCompleted: fields[3] as bool,
      note: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AgendaModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
