import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/azubi.dart';
import '../models/betrieb.dart';

class KartenScreen extends StatefulWidget {
  const KartenScreen({super.key});

  @override
  KartenScreenState createState() => KartenScreenState();
}

class KartenScreenState extends State<KartenScreen> {
  final List<Azubi> azubis = [
    Azubi(
      name: 'Max Mustermann',
      beruf: 'Elektroniker',
      lehrjahr: 2,
      gelernteFaehigkeiten: [
        'Grundlagen der Elektrotechnik',
        'Schaltungen löten',
      ],
      offeneAusbildungsinhalte: ['SPS-Programmierung', 'Gebäudeautomation'],
      lat: 52.5200,
      lng: 13.4050,
    ),
    Azubi(
      name: 'Maria Schmidt',
      beruf: 'Tischlerin',
      lehrjahr: 3,
      gelernteFaehigkeiten: [
        'Holzverbindungen',
        'Oberflächenbehandlung',
        'Möbelbau',
      ],
      offeneAusbildungsinhalte: ['CNC-Bearbeitung'],
      lat: 53.5511,
      lng: 9.9937,
    ),
  ];

  final List<Betrieb> betriebe = [
    Betrieb(
      name: 'Elektro-Service GmbH',
      gewerk: 'Elektrotechnik',
      spezialisierung: 'Gebäudeautomation',
      aufgaben: [
        'Installation von Smart-Home-Systemen',
        'Wartung von elektrischen Anlagen',
      ],
      lat: 52.5211,
      lng: 13.4061,
    ),
    Betrieb(
      name: 'Tischlerei Holzdesign',
      gewerk: 'Tischler',
      spezialisierung: 'Individueller Möbelbau',
      aufgaben: ['Anfertigung von Maßmöbeln', 'Restauration von alten Möbeln'],
      lat: 53.5522,
      lng: 9.9948,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {};

    for (var azubi in azubis) {
      markers.add(
        Marker(
          markerId: MarkerId(azubi.name),
          position: LatLng(azubi.lat, azubi.lng),
          infoWindow: InfoWindow(title: azubi.name, snippet: azubi.beruf),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
    }

    for (var betrieb in betriebe) {
      markers.add(
        Marker(
          markerId: MarkerId(betrieb.name),
          position: LatLng(betrieb.lat, betrieb.lng),
          infoWindow: InfoWindow(title: betrieb.name, snippet: betrieb.gewerk),
        ),
      );
    }

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(51.1657, 10.4515), // Germany
        zoom: 5.5,
      ),
      markers: markers,
    );
  }
}
