class Profil {
  final String name;
  final String vorname;
  final String betrieb;
  final String strasse;
  final String hausnummer;
  final String plz;
  final String stadt;
  final String? land;
  final String? gewerk;

  Profil({
    required this.name,
    required this.vorname,
    required this.betrieb,
    required this.strasse,
    required this.hausnummer,
    required this.plz,
    required this.stadt,
    this.land,
    this.gewerk,
  });
}
