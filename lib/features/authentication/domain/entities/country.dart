import 'package:equatable/equatable.dart';
import 'package:whatsapp/features/authentication/domain/entities/translation.dart';

class Country extends Equatable {
  final Translation translations;
  final String flag;
  final String name;
  final List<String> internationalCallingCodes;
  final String nativeName;
  final String countryEmoji;
  final String abbreviation;

  Country(this.translations, this.flag, this.name, this.internationalCallingCodes, this.nativeName, this.countryEmoji, this.abbreviation);

  @override
  List<Object> get props => [name, nativeName];
}