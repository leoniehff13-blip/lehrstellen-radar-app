import 'package:flutter/material.dart';
import '../models/betrieb.dart';

class BetriebListeScreen extends StatelessWidget {
  const BetriebListeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        aufgaben: [
          'Anfertigung von Maßmöbeln',
          'Restauration von alten Möbeln',
        ],
        lat: 53.5522,
        lng: 9.9948,
      ),
    ];

    return ListView.builder(
      itemCount: betriebe.length,
      itemBuilder: (context, index) {
        final betrieb = betriebe[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(betrieb.name),
            subtitle: Text(betrieb.gewerk),
            onTap: () {
              // Navigate to detail screen
            },
          ),
        );
      },
    );
  }
}
