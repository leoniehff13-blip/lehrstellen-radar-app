import 'package:flutter/material.dart';
import '../models/betrieb.dart';
import '../models/handwerkskammer.dart';
import 'betrieb_detail_screen.dart';
import 'package:intl/intl.dart';

class BetriebListeScreen extends StatefulWidget {
  const BetriebListeScreen({super.key});

  @override
  BetriebListeScreenState createState() => BetriebListeScreenState();
}

class BetriebListeScreenState extends State<BetriebListeScreen> {
  final List<Handwerkskammer> _handwerkskammern = [
    Handwerkskammer(id: 'aachen', name: 'HWK Aachen', region: 'Aachen'),
    Handwerkskammer(
        id: 'schwaben', name: 'HWK für Schwaben', region: 'Augsburg'),
    Handwerkskammer(
        id: 'oberfranken', name: 'HWK für Oberfranken', region: 'Bayreuth'),
    Handwerkskammer(id: 'berlin', name: 'HWK Berlin', region: 'Berlin'),
    Handwerkskammer(
        id: 'bielefeld',
        name: 'HWK Ostwestfalen-Lippe zu Bielefeld',
        region: 'Bielefeld'),
    Handwerkskammer(
        id: 'braunschweig_lueneburg_stade',
        name: 'HWK Braunschweig-Lüneburg-Stade',
        region: 'Braunschweig'),
    Handwerkskammer(id: 'bremen', name: 'HWK Bremen', region: 'Bremen'),
    Handwerkskammer(id: 'chemnitz', name: 'HWK Chemnitz', region: 'Chemnitz'),
    Handwerkskammer(id: 'cottbus', name: 'HWK Cottbus', region: 'Cottbus'),
    Handwerkskammer(id: 'dortmund', name: 'HWK Dortmund', region: 'Dortmund'),
    Handwerkskammer(id: 'dresden', name: 'HWK Dresden', region: 'Dresden'),
    Handwerkskammer(
        id: 'duesseldorf', name: 'HWK Düsseldorf', region: 'Düsseldorf'),
    Handwerkskammer(id: 'erfurt', name: 'HWK Erfurt', region: 'Erfurt'),
    Handwerkskammer(
        id: 'flensburg', name: 'HWK Flensburg', region: 'Flensburg'),
    Handwerkskammer(
        id: 'frankfurt_oder',
        name: 'HWK Frankfurt (Oder) - Region Ostbrandenburg',
        region: 'Frankfurt (Oder)'),
    Handwerkskammer(
        id: 'frankfurt_rhein_main',
        name: 'HWK Frankfurt-Rhein-Main',
        region: 'Frankfurt am Main'),
    Handwerkskammer(id: 'freiburg', name: 'HWK Freiburg', region: 'Freiburg'),
    Handwerkskammer(
        id: 'mittelfranken', name: 'HWK für Mittelfranken', region: 'Nürnberg'),
    Handwerkskammer(
        id: 'muenchen_oberbayern',
        name: 'HWK für München und Oberbayern',
        region: 'München'),
    Handwerkskammer(
        id: 'niederbayern_oberpfalz',
        name: 'HWK Niederbayern-Oberpfalz',
        region: 'Passau'),
    Handwerkskammer(
        id: 'unterfranken', name: 'HWK für Unterfranken', region: 'Würzburg'),
    Handwerkskammer(
        id: 'halle', name: 'HWK Halle (Saale)', region: 'Halle (Saale)'),
    Handwerkskammer(id: 'hamburg', name: 'HWK Hamburg', region: 'Hamburg'),
    Handwerkskammer(id: 'hannover', name: 'HWK Hannover', region: 'Hannover'),
    Handwerkskammer(
        id: 'heilbronn_franken',
        name: 'HWK Heilbronn-Franken',
        region: 'Heilbronn'),
    Handwerkskammer(
        id: 'hildesheim_suedniedersachsen',
        name: 'HWK Hildesheim-Südniedersachsen',
        region: 'Hildesheim'),
    Handwerkskammer(
        id: 'karlsruhe', name: 'HWK Karlsruhe', region: 'Karlsruhe'),
    Handwerkskammer(id: 'kassel', name: 'HWK Kassel', region: 'Kassel'),
    Handwerkskammer(id: 'koblenz', name: 'HWK Koblenz', region: 'Koblenz'),
    Handwerkskammer(id: 'koeln', name: 'HWK zu Köln', region: 'Köln'),
    Handwerkskammer(id: 'konstanz', name: 'HWK Konstanz', region: 'Konstanz'),
    Handwerkskammer(id: 'leipzig', name: 'HWK zu Leipzig', region: 'Leipzig'),
    Handwerkskammer(id: 'luebeck', name: 'HWK Lübeck', region: 'Lübeck'),
    Handwerkskammer(
        id: 'magdeburg', name: 'HWK Magdeburg', region: 'Magdeburg'),
    Handwerkskammer(
        id: 'mannheim',
        name: 'HWK Mannheim Rhein-Neckar-Odenwald',
        region: 'Mannheim'),
    Handwerkskammer(id: 'muenster', name: 'HWK Münster', region: 'Münster'),
    Handwerkskammer(
        id: 'oldenburg', name: 'HWK Oldenburg', region: 'Oldenburg'),
    Handwerkskammer(
        id: 'osnabrueck_emsland',
        name: 'HWK Osnabrück-Emsland-Grafschaft Bentheim',
        region: 'Osnabrück'),
    Handwerkskammer(
        id: 'ostfriesland', name: 'HWK für Ostfriesland', region: 'Aurich'),
    Handwerkskammer(
        id: 'ostthueringen', name: 'HWK für Ostthüringen', region: 'Gera'),
    Handwerkskammer(
        id: 'pfalz', name: 'HWK der Pfalz', region: 'Kaiserslautern'),
    Handwerkskammer(id: 'potsdam', name: 'HWK Potsdam', region: 'Potsdam'),
    Handwerkskammer(
        id: 'reutlingen', name: 'HWK Reutlingen', region: 'Reutlingen'),
    Handwerkskammer(
        id: 'rheinhessen', name: 'HWK Rheinhessen', region: 'Mainz'),
    Handwerkskammer(
        id: 'rostock',
        name: 'HWK Ostmecklenburg-Vorpommern',
        region: 'Rostock'),
    Handwerkskammer(
        id: 'saarland', name: 'HWK des Saarlandes', region: 'Saarbrücken'),
    Handwerkskammer(id: 'schwerin', name: 'HWK Schwerin', region: 'Schwerin'),
    Handwerkskammer(
        id: 'stuttgart', name: 'HWK Region Stuttgart', region: 'Stuttgart'),
    Handwerkskammer(
        id: 'suedthueringen', name: 'HWK Südthüringen', region: 'Suhl'),
    Handwerkskammer(
        id: 'suedwestfalen', name: 'HWK Südwestfalen', region: 'Arnsberg'),
    Handwerkskammer(id: 'trier', name: 'HWK Trier', region: 'Trier'),
    Handwerkskammer(id: 'ulm', name: 'HWK Ulm', region: 'Ulm'),
    Handwerkskammer(
        id: 'wiesbaden', name: 'HWK Wiesbaden', region: 'Wiesbaden'),
  ];

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
        'Flechtwerkfassaden & Skulpturales Holzdesign',
      ],
      webseite: 'www.muster-gmbh.de',
      adresse: 'Ossenpadd 8, 25421 Pinneberg',
      ansprechpartner: 'Frau Dr. Tietz',
      email: 'bewerbung@muster-gmbh.de',
      telefon: '+49 711 123456',
      handwerkskammerId: 'hamburg',
      startDatum: DateTime(2024, 8, 1),
      endDatum: DateTime(2024, 8, 31),
    ),
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
        'Baumhausbau & Hochseilgärten',
      ],
      webseite: 'www.holzbau-schmidt.de',
      adresse: 'Appeler Weg 60, 27419 Sittensen',
      ansprechpartner: 'Frau Bötzelen',
      email: 'info@holzbau-schmidt.de',
      telefon: '+49 761 987654',
      handwerkskammerId: 'braunschweig_lueneburg_stade',
      startDatum: DateTime(2024, 9, 15),
      endDatum: DateTime(2024, 10, 15),
    ),
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
        'Fehlerdiagnose unter Spannung',
      ],
      webseite: 'www.kreativ-ag.de',
      adresse: 'Schillerstraße 68, 33609 Bielefeld',
      ansprechpartner: 'Herr Trieschmann ',
      email: 'karriere@kreativ-ag.de',
      telefon: '+49 30 1122334',
      handwerkskammerId: 'bielefeld',
    ),
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
        'Notstromanlagen warten',
      ],
      webseite: 'www.knete-kross.de',
      adresse: 'Rundling 4, 38448 Wolfsburg',
      ansprechpartner: 'Herr Kross',
      email: 'info@knete-kross.de',
      telefon: '+49 221 555667',
      handwerkskammerId: 'braunschweig_lueneburg_stade',
      startDatum: DateTime(2024, 7, 1),
      endDatum: DateTime(2025, 1, 31),
    ),
  ];

  List<Betrieb> _filteredBetriebe = [];

  // Filter values
  String? _selectedGewerk;
  String? _selectedOrt;
  String? _selectedKammerId;
  DateTimeRange? _selectedDateRange;
  final TextEditingController _aufgabenController = TextEditingController();

  // Lists for filter options
  List<String> _allGewerke = [];
  List<String> _allOrte = [];

  @override
  void initState() {
    super.initState();
    _filteredBetriebe = _allBetriebe;

    _allGewerke = _allBetriebe.map((b) => b.branche).toSet().toList()..sort();
    _allOrte = _allBetriebe.map((b) => b.ort).toSet().toList()..sort();
  }

  void _applyFilters() {
    setState(() {
      _filteredBetriebe = _allBetriebe.where((betrieb) {
        final bool gewerkMatch =
            _selectedGewerk == null || betrieb.branche == _selectedGewerk;
        final bool ortMatch = _selectedOrt == null || betrieb.ort == _selectedOrt;
        final bool kammerMatch = _selectedKammerId == null ||
            betrieb.handwerkskammerId == _selectedKammerId;
        final bool aufgabenMatch = _aufgabenController.text.isEmpty ||
            betrieb.aufgabenbereiche.any((aufgabe) => aufgabe
                .toLowerCase()
                .contains(_aufgabenController.text.toLowerCase()));

        final bool dateMatch;
        if (_selectedDateRange == null) {
          dateMatch = true;
        } else {
          if (betrieb.startDatum == null || betrieb.endDatum == null) {
            dateMatch = false;
          } else {
            final range = _selectedDateRange!;
            dateMatch = !(betrieb.endDatum!.isBefore(range.start) ||
                betrieb.startDatum!.isAfter(range.end));
          }
        }

        return gewerkMatch && ortMatch && kammerMatch && aufgabenMatch && dateMatch;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedGewerk = null;
      _selectedOrt = null;
      _selectedKammerId = null;
      _selectedDateRange = null;
      _aufgabenController.clear();
    });
    _applyFilters();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Betriebe filtern'),
              content: DefaultTabController(
                length: 3, // Gewerk, Ort, Kammer
                child: SizedBox(
                  width: double.maxFinite,
                  height: 400, // Adjusted height
                  child: Column(
                    children: [
                      TextField(
                        controller: _aufgabenController,
                        decoration: const InputDecoration(
                          labelText: 'Aufgabenbeschreibung',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                            currentDate: DateTime.now(),
                            initialDateRange: _selectedDateRange,
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDateRange = picked;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(_selectedDateRange == null
                            ? 'Zeitraum auswählen'
                            : '${DateFormat.yMd().format(_selectedDateRange!.start)} - ${DateFormat.yMd().format(_selectedDateRange!.end)}'),
                      ),
                      const SizedBox(height: 16),
                      const TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Gewerk'),
                          Tab(text: 'Ort'),
                          Tab(text: 'Kammer'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildFilterList(_allGewerke, _selectedGewerk, (val) => setState(() => _selectedGewerk = val)),
                            _buildFilterList(_allOrte, _selectedOrt, (val) => setState(() => _selectedOrt = val)),
                            _buildKammerFilterList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _resetFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Zurücksetzen'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Abbrechen'),
                ),
                FilledButton(
                  onPressed: () {
                    _applyFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Anwenden'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterList<T>(
      List<T> items, T? selectedItem, ValueChanged<T?> onChanged) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('Alle anzeigen'),
            trailing: selectedItem == null ? const Icon(Icons.check) : null,
            onTap: () => onChanged(null),
          );
        }
        final item = items[index - 1];
        return ListTile(
          title: Text(item.toString()),
          trailing: selectedItem == item ? const Icon(Icons.check) : null,
          onTap: () => onChanged(item),
        );
      },
    );
  }

  Widget _buildKammerFilterList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _handwerkskammern.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('Alle anzeigen'),
            trailing: _selectedKammerId == null ? const Icon(Icons.check) : null,
            onTap: () => setState(() => _selectedKammerId = null),
          );
        }
        final kammer = _handwerkskammern[index - 1];
        return ListTile(
          title: Text(kammer.name),
          trailing: _selectedKammerId == kammer.id ? const Icon(Icons.check) : null,
          onTap: () => setState(() => _selectedKammerId = kammer.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _filteredBetriebe.length,
        itemBuilder: (context, index) {
          final betrieb = _filteredBetriebe[index];
          final handwerkskammer = _handwerkskammern.firstWhere(
              (kammer) => kammer.id == betrieb.handwerkskammerId,
              orElse: () => Handwerkskammer(id: '', name: 'Unbekannt', region: ''));

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(betrieb.logo),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(betrieb.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${betrieb.branche}\n${betrieb.adresse} - ${handwerkskammer.name}'),
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _showFilterDialog,
            heroTag: 'filter',
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {},
            heroTag: 'add',
            backgroundColor: const Color(0xFF002C59),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
