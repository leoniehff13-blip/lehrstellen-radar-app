class Betrieb {
  final String name;
  final String branche;
  final String ort;
  final String logo;
  final String beschreibung;
  final List<String> aufgabenbereiche;
  final String webseite;
  final String adresse;
  final String ansprechpartner;
  final String email;
  final String telefon;
  final String handwerkskammerId;
  final DateTime? startDatum;
  final DateTime? endDatum;

  Betrieb({
    required this.name,
    required this.branche,
    required this.ort,
    required this.logo,
    required this.beschreibung,
    required this.aufgabenbereiche,
    required this.webseite,
    required this.adresse,
    required this.ansprechpartner,
    required this.email,
    required this.telefon,
    required this.handwerkskammerId,
    this.startDatum,
    this.endDatum,
  });
}
