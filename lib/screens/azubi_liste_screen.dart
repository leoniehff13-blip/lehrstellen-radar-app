import 'package:flutter/material.dart';
import '../models/azubi.dart';
import 'azubi_detail_screen.dart';

class AzubiListeScreen extends StatelessWidget {
  AzubiListeScreen({super.key});

  final List<Azubi> azubiAngebote = [
    Azubi(
        name: 'Max Mustermann',
        beruf: 'Elektroniker für Betriebstechnik',
        lehrjahr: '2. Lehrjahr',
        profilbild:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Löten', 'Schaltpläne lesen', 'VDE-Normen'],
        lernziele: [
          'SPS-Programmierung vertiefen',
          'Fehlersuche in komplexen Anlagen'
        ],
        email: 'max.mustermann@email.de'),
    Azubi(
        name: 'Erika Mustermann',
        beruf: 'Anlagenmechanikerin für SHK',
        lehrjahr: '3. Lehrjahr',
        profilbild:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: [
          'Rohrleitungsbau',
          'Heizungsanlagen installieren',
          'Kundendienst'
        ],
        lernziele: ['Hydraulischer Abgleich', 'Regenerative Energien'],
        email: 'erika.mustermann@email.de'),
    Azubi(
        name: 'Jonas Schmidt',
        beruf: 'Tischler',
        lehrjahr: '1. Lehrjahr',
        profilbild:
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Holzverbindungen', 'Oberflächenbehandlung'],
        lernziele: [
          'Umgang mit CNC-Maschinen',
          'Kundenberatung und -betreuung'
        ],
        email: 'jonas.schmidt@email.de'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: azubiAngebote.length,
      itemBuilder: (context, index) {
        final azubi = azubiAngebote[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(azubi.profilbild),
              backgroundColor: Colors.grey[200],
            ),
            title: Text(azubi.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${azubi.beruf}\n${azubi.lehrjahr}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AzubiDetailScreen(azubi: azubi),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
