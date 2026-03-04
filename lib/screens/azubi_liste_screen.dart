import 'package:flutter/material.dart';
import '../models/azubi.dart';
import 'azubi_detail_screen.dart';

class AzubiListeScreen extends StatefulWidget {
  const AzubiListeScreen({super.key});

  @override
  State<AzubiListeScreen> createState() => _AzubiListeScreenState();
}

class _AzubiListeScreenState extends State<AzubiListeScreen> {
  final List<Azubi> azubiAngebote = [
    Azubi(
        name: 'Max Mustermann',
        beruf: 'Elektroniker für Betriebstechnik',
        lehrjahr: 2,
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
        lehrjahr: 3,
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
        lehrjahr: 1,
        profilbild:
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Holzverbindungen', 'Oberflächenbehandlung'],
        lernziele: [
          'Umgang mit CNC-Maschinen',
          'Kundenberatung und -betreuung'
        ],
        email: 'jonas.schmidt@email.de'),
    Azubi(
        name: 'Anna Kovac',
        beruf: 'Malerin und Lackiererin',
        lehrjahr: 4,
        profilbild: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Spachteltechniken', 'Fassadengestaltung', 'Tapezieren'],
        lernziele: ['Airless-Spritztechnik', 'Dekorative Wandgestaltung'],
        email: 'anna.kovac@email.de'),

  ];

  int? _gefiltertesLehrjahr;

  @override
  Widget build(BuildContext context) {
    final gefilterteAzubis = _gefiltertesLehrjahr == null
        ? azubiAngebote
        : azubiAngebote
            .where((azubi) => azubi.lehrjahr == _gefiltertesLehrjahr)
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            children: [
              FilterChip(label: const Text('Alle'), selected: _gefiltertesLehrjahr == null, onSelected: (selected) => setState(() => _gefiltertesLehrjahr = null)),
              ...List.generate(4, (index) => FilterChip(
                label: Text('${index + 1}. Lehrjahr'),
                selected: _gefiltertesLehrjahr == index + 1,
                onSelected: (selected) => setState(() => _gefiltertesLehrjahr = selected ? index + 1 : null),
              )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: gefilterteAzubis.length,
            itemBuilder: (context, index) {
              final azubi = gefilterteAzubis[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(azubi.profilbild),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(azubi.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${azubi.beruf}\n${azubi.lehrjahr}. Lehrjahr'),
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
          ),
        ),
      ],
    );
  }
}
