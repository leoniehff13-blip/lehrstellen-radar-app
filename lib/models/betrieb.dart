class Betrieb {
  final String name;
  final String branche;
  final String ort;
  final String logo;
  final String beschreibung;
  final List<String> aufgabenbereiche;
  final String webseite;
  final String adresse; // Neues Feld

  Betrieb({
    required this.name,
    required this.branche,
    required this.ort,
    required this.logo,
    required this.beschreibung,
    required this.aufgabenbereiche,
    required this.webseite,
    required this.adresse, // Im Konstruktor hinzugefügt
  });
}
