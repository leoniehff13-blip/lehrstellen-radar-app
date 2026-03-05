class Talent {
  final String name;
  final String beruf;
  final int lehrjahr;
  final String profilbild;
  final List<String> faehigkeiten;
  final List<String> lernziele;
  final String email;

  Talent({
    required this.name,
    required this.beruf,
    required this.lehrjahr,
    required this.profilbild,
    required this.faehigkeiten,
    required this.lernziele,
    required this.email,
  }) : assert(lehrjahr >= 1 && lehrjahr <= 4);
}
