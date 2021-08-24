import 'package:equatable/equatable.dart';

class TranslationModel extends Equatable {
  final String br;
  final String pt;
  final String nl;
  final String hr;
  final String fa;
  final String de;
  final String es;
  final String fr;
  final String ja;
  final String it;

  TranslationModel({
    this.br,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
  });

  static TranslationModel fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      br: json['br'],
      pt: json['pt'],
      nl: json['nl'],
      hr: json['hr'],
      fa: json['fa'],
      de: json['de'],
      es: json['es'],
      fr: json['fr'],
      ja: json['ja'],
      it: json['it'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['br'] = this.br;
    data['pt'] = this.pt;
    data['nl'] = this.nl;
    data['hr'] = this.hr;
    data['fa'] = this.fa;
    data['de'] = this.de;
    data['es'] = this.es;
    data['fr'] = this.fr;
    data['ja'] = this.ja;
    data['it'] = this.it;
    return data;
  }

  @override
  List<Object> get props => [br];
}
