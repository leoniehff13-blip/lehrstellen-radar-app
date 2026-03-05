import 'package:flutter/material.dart';
import 'package:myapp/data/hwk_data.dart';
import '../models/betrieb.dart';
import 'betrieb_detail_screen.dart';

class BetriebListeScreen extends StatefulWidget {
  const BetriebListeScreen({super.key});

  @override
  State<BetriebListeScreen> createState() => _BetriebListeScreenState();
}

class _BetriebListeScreenState extends State<BetriebListeScreen> {
  final List<Betrieb> _allBetriebe = [
    Betrieb(
        name: 'Tietz GmbH & Co. KG',
        branche: 'Zimmerei',
        ort: 'Pinneberg',
        logo:
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Wir lieben Holz.',
        aufgabenbereiche: [
          'Fachwerkrestaurierung historischer Gebäude',
          'Holzbrückenbau',
          'Flechtwerkfassaden & Skulpturales Holzdesign'
        ],
        webseite: 'www.muster-gmbh.de',
        adresse: 'Ossenpadd 8, 25421 Pinneberg',
        ansprechpartner: 'Frau Dr. Tietz',
        email: 'bewerbung@muster-gmbh.de',
        telefon: '+49 711 123456',
        handwerkskammerId: 'hamburg'), // Assuming Hamburg chamber is closest
    Betrieb(
        name: 'Holzbau Bötzelen',
        branche: 'Zimmerei',
        ort: 'Sittensen',
        logo:
            'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Traditionelles Handwerk trifft auf moderne Technik. Bei uns lernst du den Umgang mit dem Werkstoff Holz von Grund auf.',
        aufgabenbereiche: [
          'Schiffsinnenausbau in Holz',
          'Sakralbau (Kirchendächer, Glockentürme)',
          'Baumhausbau & Hochseilgärten'
        ],
        webseite: 'www.holzbau-schmidt.de',
        adresse: 'Appeler Weg 60, 27419 Sittensen',
        ansprechpartner: 'Frau Bötzelen',
        email: 'info@holzbau-schmidt.de',
        telefon: '+49 761 987654',
        handwerkskammerId:
            'braunschweig_lueneburg_stade'), // Assuming this chamber covers Sittensen
    Betrieb(
        name: 'Trieschmann AG',
        branche: 'Elektriker',
        ort: 'Bielefeld',
        logo:
            'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Wir verlegen den Strom von morgen. Werde Teil unseres agilen Teams und gestalte die digitale Zukunft mit.',
        aufgabenbereiche: [
          'Schaltschrankverkabelung',
          'SPS-Programmierung',
          'Fehlerdiagnose unter Spannung'
        ],
        webseite: 'www.kreativ-ag.de',
        adresse: 'Schillerstraße 68, 33609 Bielefeld',
        ansprechpartner: 'Herr Trieschmann ',
        email: 'karriere@kreativ-ag.de',
        telefon: '+49 30 1122334',
        handwerkskammerId: 'bielefeld'),
    Betrieb(
        name: 'Elektriker Knete Kross',
        branche: 'Elektriker',
        ort: 'Wolfsburg',
        logo:
            'https://images.unsplash.com/photo-1598373182133-52452f7691ef?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Abfahrt',
        aufgabenbereiche: [
          'Motorenprüfung',
          'Frequenzumrichter einstellen',
          'Notstromanlagen warten'
        ],
        webseite: 'www.knete-kross.de',
        adresse: 'Rundling 4, 38448 Wolfsburg',
        ansprechpartner: 'Herr Kross',
        email: 'info@knete-kross.de',
        telefon: '+49 221 555667',
        handwerkskammerId:
            'braunschweig_lueneburg_stade'), // Assuming this chamber covers Wolfsburg
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(betrieb.logo),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(betrieb.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${betrieb.branche}\n${betrieb.ort}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BetriebDetailScreen(betrieb: betrieb),
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
          ...alleHandwerkskammern
              .map<DropdownMenuItem<String>>((Handwerkskammer kammer) {
            return DropdownMenuItem<String>(
              value: kammer.id,
              child: Text(kammer.shortName),
            );
          }),
        ],
      ),
    );
  }
}
