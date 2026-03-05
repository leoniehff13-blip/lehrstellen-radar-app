import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'talent_detail_screen.dart';

class TalentListeScreen extends StatefulWidget {
  final List<Profil> talente;
  const TalentListeScreen({super.key, required this.talente});

  @override
  State<TalentListeScreen> createState() => _TalentListeScreenState();
}

class _TalentListeScreenState extends State<TalentListeScreen> {
  final List<Profil> _initialTalentAngebote = [
    Profil(
        name: 'Gambotron',
        vorname: 'Marlon',
        gewerk: 'Elektroniker für Betriebstechnik',
        lehrjahr: 2,
        faehigkeiten: ['Löten', 'Schaltpläne lesen', 'VDE-Normen'],
        profilTyp: 'Azubi',
        profilbild: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
        ),
    Profil(
        name: 'Altkorn',
        vorname: 'Laura',
        gewerk: 'Anlagenmechanikerin für SHK',
        lehrjahr: 3,
        faehigkeiten: [
          'Rohrleitungsbau',
          'Heizungsanlagen installieren',
          'Kundendienst'
        ],
        profilTyp: 'Azubi',
        profilbild: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100&auto=format&fit=crop',
        ),
    Profil(
        name: 'Müller',
        vorname: 'Alex Cedric',
        gewerk: 'Zimmerer',
        lehrjahr: 1,
        faehigkeiten: ['Holzverbindungen', 'Oberflächenbehandlung'],
        profilTyp: 'Azubi',
        profilbild: 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=100&auto=format&fit=crop',
        ),
  ];

  int? _gefiltertesLehrjahr;

  @override
  Widget build(BuildContext context) {
    final List<Profil> alleTalente = [..._initialTalentAngebote, ...widget.talente];

    final gefilterteTalente = _gefiltertesLehrjahr == null
        ? alleTalente
        : alleTalente
            .where((talent) => talent.lehrjahr == _gefiltertesLehrjahr)
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                  label: const Text('Alle'),
                  selected: _gefiltertesLehrjahr == null,
                  onSelected: (selected) =>
                      setState(() => _gefiltertesLehrjahr = null)),
              ...List.generate(
                  4,
                  (index) => FilterChip(
                        label: Text('${index + 1}. Lehrjahr'),
                        selected: _gefiltertesLehrjahr == index + 1,
                        onSelected: (selected) => setState(() => _gefiltertesLehrjahr =
                            selected ? index + 1 : null),
                      )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: gefilterteTalente.length,
            itemBuilder: (context, index) {
              final talent = gefilterteTalente[index];
              final profilbild = talent.profilbild ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop';

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profilbild),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text('${talent.vorname ?? ''} ${talent.name ?? ''}',
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      '${talent.gewerk ?? 'N/A'}\n${talent.lehrjahr}. Lehrjahr'),
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
