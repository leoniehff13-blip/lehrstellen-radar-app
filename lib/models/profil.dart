class Profil {
  final String? name;
  final String? vorname;
  final String? gewerk;
  final int? lehrjahr;
  final List<String>? faehigkeiten;
  final String? profilTyp; // 'Azubi' oder 'Betrieb'
  final String? unternehmen; 
  final String? profilbild; // URL zum Profilbild

  Profil({
    this.name,
    this.vorname,
    this.gewerk,
    this.lehrjahr,
    this.faehigkeiten,
    this.profilTyp,
    this.unternehmen,
    this.profilbild,
  });
}