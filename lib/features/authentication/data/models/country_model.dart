import 'package:equatable/equatable.dart';
import 'package:whatsapp/features/authentication/data/models/translation_model.dart';

class CountryModel extends Equatable {
  final TranslationModel translations;
  final String flag;
  final String name;
  final List<String> internationalCallingCodes;
  final String nativeName;

  CountryModel(
      {this.translations,
      this.flag,
      this.name,
      this.internationalCallingCodes,
      this.nativeName});

  static CountryModel fromJson(Map<String, dynamic> json) {
    return CountryModel(
        translations: json['translations'] != null
            ? TranslationModel.fromJson(json['translations'])
            : null,
        flag: json['flag'],
        name: json['name'],
        internationalCallingCodes: json['callingCodes'].cast<String>(),
        nativeName: json['nativeName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations.toJson();
    }
    data['flag'] = this.flag;
    data['name'] = this.name;
    data['callingCodes'] = this.internationalCallingCodes;
    data['nativeName'] = this.nativeName;
    return data;
  }

  @override
  List<Object> get props => [name];
}
