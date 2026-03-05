class Profil {
  final String? name;
  final String? vorname;
  final String? gewerk;
  final int? lehrjahr;
  final List<String>? faehigkeiten;
  final String? profilTyp; // 'Azubi' oder 'Betrieb'
  final String? unternehmen;
  final String? profilbild; // URL zum Profilbild
  final String? betrieb;
  final String? strasse;
  final String? hausnummer;
  final String? plz;
  final String? stadt;
  final String? land;
  final String? ansprechperson;
  final String? handwerkskammer;
  final String? spezialisierung;

  Profil({
    this.name,
    this.vorname,
    this.gewerk,
    this.lehrjahr,
    this.faehigkeiten,
    this.profilTyp,
    this.unternehmen,
    this.profilbild,
    this.betrieb,
    this.strasse,
    this.hausnummer,
    this.plz,
    this.stadt,
    this.land,
    this.ansprechperson,
    this.handwerkskammer,
    this.spezialisierung,
  });
}
