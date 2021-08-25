// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslationModelAdapter extends TypeAdapter<TranslationModel> {
  @override
  final int typeId = 3;

  @override
  TranslationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslationModel(
      br: fields[0] as String,
      pt: fields[1] as String,
      nl: fields[2] as String,
      hr: fields[3] as String,
      fa: fields[4] as String,
      de: fields[5] as String,
      es: fields[6] as String,
      fr: fields[7] as String,
      ja: fields[8] as String,
      it: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranslationModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.br)
      ..writeByte(1)
      ..write(obj.pt)
      ..writeByte(2)
      ..write(obj.nl)
      ..writeByte(3)
      ..write(obj.hr)
      ..writeByte(4)
      ..write(obj.fa)
      ..writeByte(5)
      ..write(obj.de)
      ..writeByte(6)
      ..write(obj.es)
      ..writeByte(7)
      ..write(obj.fr)
      ..writeByte(8)
      ..write(obj.ja)
      ..writeByte(9)
      ..write(obj.it);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
