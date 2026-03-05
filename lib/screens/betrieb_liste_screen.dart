import 'package:flutter/material.dart';
import '../models/betrieb.dart';
import '../models/handwerkskammer.dart';
import 'betrieb_detail_screen.dart';

class BetriebListeScreen extends StatefulWidget {
  const BetriebListeScreen({super.key});

  @override
  State<BetriebListeScreen> createState() => _BetriebListeScreenState();
}

class _BetriebListeScreenState extends State<BetriebListeScreen> {
  // Same data as in KartenScreen for consistency
  final List<Handwerkskammer> _handwerkskammern = [
    Handwerkskammer(id: 'hamburg', name: 'HWK Hamburg', region: 'Hamburg'),
    Handwerkskammer(id: 'stuttgart', name: 'HWK Region Stuttgart', region: 'Stuttgart'),
    Handwerkskammer(id: 'freiburg', name: 'HWK Freiburg', region: 'Freiburg'),
    Handwerkskammer(id: 'berlin', name: 'HWK Berlin', region: 'Berlin'),
    Handwerkskammer(id: 'muenchen', name: 'HWK für München und Oberbayern', region: 'München'),
  ];

  final List<Betrieb> _allBetriebe = [
     Betrieb(
        name: 'Muster GmbH & Co. KG',
        branche: 'Maschinenbau',
        ort: 'Stuttgart',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung:'Wir sind ein führender Hersteller von Spezialmaschinen.',
        aufgabenbereiche: ['Montage', 'Wartung', 'Qualitätssicherung'],
        webseite: 'www.example.com',
        adresse: 'Musterstraße 1, 70173 Stuttgart, Deutschland',
        ansprechpartner: 'Frau Dr. Schneider',
        email: 'bewerbung@example.com',
        telefon: '+49 711 123456',
        handwerkskammerId: 'stuttgart'),
    Betrieb(
        name: 'Holzbau Schmidt',
        branche: 'Handwerk',
        ort: 'Freiburg',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Traditioneller Holzbaubetrieb mit moderner Technik.',
        aufgabenbereiche: ['Dachstühle', 'Holzrahmenbau', 'Innenausbau'],
        webseite: 'www.example.com',
        adresse: 'Hauptstraße 5, 79104 Freiburg im Breisgau, Deutschland',
        ansprechpartner: 'Herr Schmidt',
        email: 'info@example.com',
        telefon: '+49 761 987654',
        handwerkskammerId: 'freiburg'),
    Betrieb(
        name: 'Kreativ-Software AG',
        branche: 'IT & Software',
        ort: 'Berlin',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung:'Wir entwickeln innovative Softwarelösungen.',
        aufgabenbereiche: ['Anwendungsentwicklung', 'Backend-Entwicklung'],
        webseite: 'www.example.com',
        adresse: 'Friedrichstraße 100, 10117 Berlin, Deutschland',
        ansprechpartner: 'Herr Meier',
        email: 'karriere@example.com',
        telefon: '+49 30 12345678',
        handwerkskammerId: 'berlin'),
    Betrieb(
        name: 'Innovatec GmbH',
        branche: 'IT & Hardware',
        ort: 'München',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Hardware-Lösungen für die Industrie.',
        aufgabenbereiche: ['Systemintegration', 'Netzwerktechnik'],
        webseite: 'www.example.com',
        adresse: 'Balanstraße 73, 81541 München, Deutschland',
        ansprechpartner: 'Frau Huber',
        email: 'jobs@example.com',
        telefon: '+49 89 123456',
        handwerkskammerId: 'muenchen'),
    Betrieb(
        name: 'Hafen-Logistik AG',
        branche: 'Logistik',
        ort: 'Hamburg',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Ihr Partner für weltweite Logistik.',
        aufgabenbereiche: ['Spedition', 'Lagerlogistik'],
        webseite: 'www.example.com',
        adresse: 'Bei St. Annen 1, 20457 Hamburg, Deutschland',
        ansprechpartner: 'Herr Jansen',
        email: 'contact@example.com',
        telefon: '+49 40 987654',
        handwerkskammerId: 'hamburg'),
    Betrieb(
        name: 'HSBA',
        branche: 'Bildung',
        ort: 'Hamburg',
        logo:
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Die Business School in Hamburg. Wir bieten duale Studiengänge und Weiterbildungen an.',
        aufgabenbereiche: ['Duales Studium BWL', 'Master in Global Management'],
        webseite: 'www.hsba.de',
        adresse: 'Willy-Brandt-Straße 75, 20459 Hamburg, Deutschland',
        ansprechpartner: 'Studienberatung',
        email: 'info@hsba.de',
        telefon: '+49 40 361380',
        handwerkskammerId: 'hamburg'),
  ];

  String? _selectedKammerId;
  List<Betrieb> _filteredBetriebe = [];

  @override
  void initState() {
    super.initState();
    _filteredBetriebe = _allBetriebe;
  }

  void _filterBetriebe() {
    setState(() {
      if (_selectedKammerId == null) {
        _filteredBetriebe = _allBetriebe;
      } else {
        _filteredBetriebe = _allBetriebe
            .where((b) => b.handwerkskammerId == _selectedKammerId)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterDropdown(),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredBetriebe.length,
            itemBuilder: (context, index) {
              final betrieb = _filteredBetriebe[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(betrieb.logo),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(betrieb.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${betrieb.branche}\n${betrieb.ort}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BetriebDetailScreen(betrieb: betrieb),
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

  Widget _buildFilterDropdown() {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButton<String>(
        value: _selectedKammerId,
        isExpanded: true,
        hint: const Text('Nach Handwerkskammer filtern'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedKammerId = newValue;
          });
          _filterBetriebe();
        },
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Alle anzeigen'),
          ),
          ..._handwerkskammern.map<DropdownMenuItem<String>>((Handwerkskammer kammer) {
            return DropdownMenuItem<String>(
              value: kammer.id,
              child: Text(kammer.name),
            );
          }).toList(),
        ],
      ),
    );
  }
}
