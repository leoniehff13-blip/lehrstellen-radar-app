class Betrieb {
  final String name;
  final String gewerk;
  final String spezialisierung;
  final List<String> aufgaben;
  final double lat;
  final double lng;

  Betrieb({
    required this.name,
    required this.gewerk,
    required this.spezialisierung,
    required this.aufgaben,
    required this.lat,
    required this.lng,
  });
}
