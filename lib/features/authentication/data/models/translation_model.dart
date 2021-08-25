import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'translation_model.g.dart';

@HiveType(typeId: 3)
class TranslationModel extends Equatable {
  @HiveField(0)
  final String br;

  @HiveField(1)
  final String pt;

  @HiveField(2)
  final String nl;

  @HiveField(3)
  final String hr;

  @HiveField(4)
  final String fa;

  @HiveField(5)
  final String de;

  @HiveField(6)
  final String es;

  @HiveField(7)
  final String fr;

  @HiveField(8)
  final String ja;

  @HiveField(9)
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
