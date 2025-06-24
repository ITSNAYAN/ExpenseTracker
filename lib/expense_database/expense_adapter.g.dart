// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapterAdapter extends TypeAdapter<ExpenseAdapter> {
  @override
  final int typeId = 0;

  @override
  ExpenseAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseAdapter(
      description: fields[0] as String?,
      amount: fields[1] as double?,
      dateTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
