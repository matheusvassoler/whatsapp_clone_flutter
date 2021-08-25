// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryModelLocalAdapter extends TypeAdapter<CountryModelLocal> {
  @override
  final int typeId = 2;

  @override
  CountryModelLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryModelLocal(
      translations: fields[0] as TranslationModel,
      flag: fields[1] as String,
      name: fields[2] as String,
      internationalCallingCodes: (fields[3] as List)?.cast<String>(),
      nativeName: fields[4] as String,
      path: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountryModelLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.translations)
      ..writeByte(1)
      ..write(obj.flag)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.internationalCallingCodes)
      ..writeByte(4)
      ..write(obj.nativeName)
      ..writeByte(5)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModelLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
