import 'package:flutter/material.dart';
import '../models/talent.dart';
import 'talent_detail_screen.dart';

class TalentListeScreen extends StatefulWidget {
  const TalentListeScreen({super.key});

  @override
  State<TalentListeScreen> createState() => _TalentListeScreenState();
}

class _TalentListeScreenState extends State<TalentListeScreen> {
  final List<Talent> talentAngebote = [
    Talent(
        name: 'Marlon Gambotron',
        beruf: 'Elektroniker für Betriebstechnik',
        lehrjahr: 2,
        profilbild:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Löten', 'Schaltpläne lesen', 'VDE-Normen'],
        lernziele: [
          'Beleuchtung installieren',
          'Erdung prüfen',
          'Fehler diagnostizieren',
          'Kabel verlegen',
          'Leitungen dimensionieren',
          'Messgeräte bedienen',
          'Motoren anschließen',
          'Prüfprotokolle erstellen',
          'Schaltkreise verdrahten',
          'Schaltpläne lesen',
          'Schutzmaßnahmen anwenden',
          'Sicherungen prüfen',
          'Steckdosen installieren',
          'Steuerungen programmieren',
          'Verteiler aufbauen'
        ],
        email: 'marlon.gambotron@email.de'),
    Talent(
        name: 'Laura Altkorn',
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
        email: 'laura.altkorn@email.de'),
    Talent(
        name: 'Alex Cedric Müller',
        beruf: 'Zimmerer',
        lehrjahr: 1,
        profilbild:
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=100&auto=format&fit=crop',
        faehigkeiten: ['Holzverbindungen', 'Oberflächenbehandlung'],
        lernziele: [
          'Dachstühle bauen',
          'Kundenberatung und -betreuung',
          'Nachhaltige Dämmstoffe'
        ],
        email: 'alex-cedric.mueller@email.de'),
  ];

  int? _gefiltertesLehrjahr;

  @override
  Widget build(BuildContext context) {
    final gefilterteTalente = _gefiltertesLehrjahr == null
        ? talentAngebote
        : talentAngebote
            .where((talent) => talent.lehrjahr == _gefiltertesLehrjahr)
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
            itemCount: gefilterteTalente.length,
            itemBuilder: (context, index) {
              final talent = gefilterteTalente[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(talent.profilbild),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(talent.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${talent.beruf}\n${talent.lehrjahr}. Lehrjahr'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TalentDetailScreen(talent: talent),
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
