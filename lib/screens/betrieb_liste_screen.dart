import 'package:flutter/material.dart';
import 'package:myapp/data/hwk_data.dart';
import '../models/betrieb.dart';
import 'betrieb_detail_screen.dart';
import 'package:intl/intl.dart';

class BetriebListeScreen extends StatefulWidget {
  const BetriebListeScreen({super.key});

  @override
  BetriebListeScreenState createState() => BetriebListeScreenState();
}

class BetriebListeScreenState extends State<BetriebListeScreen> {
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

  String? _selectedGewerk;
  String? _selectedOrt;
  String? _selectedKammerId;
  DateTimeRange? _selectedDateRange;
  final TextEditingController _aufgabenController = TextEditingController();

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
        final bool ortMatch =
            _selectedOrt == null || betrieb.ort == _selectedOrt;
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

        return gewerkMatch &&
            ortMatch &&
            kammerMatch &&
            aufgabenMatch &&
            dateMatch;
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
                length: 3,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 450,
                  child: Column(
                    children: [
                      TextField(
                        controller: _aufgabenController,
                        decoration: const InputDecoration(
                          labelText: 'Aufgaben oder Stichworte',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
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
                            initialDateRange: _selectedDateRange,
                          );
                          if (picked != null) {
                            setState(() => _selectedDateRange = picked);
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(_selectedDateRange == null
                            ? 'Zeitraum auswählen'
                            : '${DateFormat.yMEd().format(_selectedDateRange!.start)} - ${DateFormat.yMd().format(_selectedDateRange!.end)}'),
                      ),
                      const SizedBox(height: 16),
                      const TabBar(
                        isScrollable: true,
                        labelColor: Color(0xFF002C59),
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: 'Gewerk'),
                          Tab(text: 'Ort'),
                          Tab(text: 'Kammer'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildFilterList(_allGewerke, _selectedGewerk,
                                (val) => setState(() => _selectedGewerk = val)),
                            _buildFilterList(_allOrte, _selectedOrt,
                                (val) => setState(() => _selectedOrt = val)),
                            _buildKammerFilterList((val) =>
                                setState(() => _selectedKammerId = val)),
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
                  style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF002C59)),
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
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return RadioListTile<T?>(
            title: const Text('Alle anzeigen'),
            value: null,
            groupValue: selectedItem,
            onChanged: onChanged,
          );
        }
        final item = items[index - 1];
        return RadioListTile<T?>(
          title: Text(item.toString()),
          value: item,
          groupValue: selectedItem,
          onChanged: onChanged,
        );
      },
    );
  }

  Widget _buildKammerFilterList(ValueChanged<String?> onChanged) {
    return ListView.builder(
      itemCount: alleHandwerkskammern.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return RadioListTile<String?>(
            title: const Text('Alle anzeigen'),
            value: null,
            groupValue: _selectedKammerId,
            onChanged: onChanged,
          );
        }
        final kammer = alleHandwerkskammern[index - 1];
        return RadioListTile<String?>(
          title: Text(kammer.name),
          value: kammer.id,
          groupValue: _selectedKammerId,
          onChanged: onChanged,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _filteredBetriebe.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Keine Betriebe gefunden',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _resetFilters,
                    child: const Text('Alle Filter zurücksetzen'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _filteredBetriebe.length,
              itemBuilder: (context, index) {
                final betrieb = _filteredBetriebe[index];
                final handwerkskammer = alleHandwerkskammern.firstWhere(
                    (kammer) => kammer.id == betrieb.handwerkskammerId,
                    orElse: () => const Handwerkskammer(
                        id: '',
                        name: 'Unbekannt',
                        shortName: '',
                        address: '',
                        url: ''));

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(betrieb.logo),
                      backgroundColor: Colors.grey[200],
                    ),
                    title: Text(betrieb.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${betrieb.branche}\n${betrieb.ort} - ${handwerkskammer.shortName}'),
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
            onPressed: () {
              // TODO: Implement add functionality
            },
            heroTag: 'add',
            backgroundColor: const Color(0xFF002C59),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
