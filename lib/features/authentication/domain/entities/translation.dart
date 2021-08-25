import 'package:equatable/equatable.dart';

class Translation extends Equatable {

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

  Translation(this.br, this.pt, this.nl, this.hr, this.fa, this.de, this.es, this.fr, this.ja, this.it);

  @override
  List<Object> get props => [br, pt, nl, hr, fa, de, es, fr, ja, it];
}