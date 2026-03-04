import 'package:flutter/material.dart';
import '../models/azubi.dart';

class AzubiListeScreen extends StatelessWidget {
  const AzubiListeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return ListView.builder(
      itemCount: azubis.length,
      itemBuilder: (context, index) {
        final azubi = azubis[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(azubi.name),
            subtitle: Text('${azubi.beruf}, ${azubi.lehrjahr}. Lehrjahr'),
            onTap: () {
              // Navigate to detail screen
            },
          ),
        );
      },
    );
  }
}
