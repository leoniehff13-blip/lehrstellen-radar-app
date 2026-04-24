import 'profil.dart';

class Anfrage {
  final Profil anfragenderBetrieb;
  final Profil angefragtesTalent;
  final DateTime anfrageDatum;

  Anfrage({
    required this.anfragenderBetrieb,
    required this.angefragtesTalent,
    required this.anfrageDatum,
  });
}
