import 'package:hive/hive.dart';
import 'package:whatsapp/features/authentication/data/models/translation_model.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';

part 'country_model_local.g.dart';

@HiveType(typeId: 2)
class CountryModelLocal extends Country {
  @HiveField(0)
  final TranslationModel translations;

  @HiveField(1)
  final String flag;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final List<String> internationalCallingCodes;

  @HiveField(4)
  final String nativeName;

  @HiveField(5)
  final String countryEmoji;

  @HiveField(6)
  final String abbreviation;

  CountryModelLocal({
    this.translations,
    this.flag,
    this.name,
    this.internationalCallingCodes,
    this.nativeName,
    this.countryEmoji,
    this.abbreviation,
  }) : super(
          translations,
          flag,
          name,
          internationalCallingCodes,
          nativeName,
          countryEmoji,
          abbreviation
        );
}
