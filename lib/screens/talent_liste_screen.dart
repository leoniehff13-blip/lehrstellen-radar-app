import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'talent_detail_screen.dart';

class TalentListeScreen extends StatefulWidget {
  final List<Profil> talente;
  final Function(Profil) onAnfrage;
  final Profil? profil;

  const TalentListeScreen({
    super.key,
    required this.talente,
    required this.onAnfrage,
    required this.profil,
  });

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
        profilbild:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
        stadt: 'Berlin',
        handwerkskammer: 'HWK Berlin'),
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
        profilbild:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100&auto=format&fit=crop',
        stadt: 'München',
        handwerkskammer: 'HWK für München und Oberbayern'),
    Profil(
        name: 'Müller',
        vorname: 'Alex Cedric',
        gewerk: 'Zimmerer',
        lehrjahr: 1,
        faehigkeiten: ['Holzverbindungen', 'Oberflächenbehandlung'],
        profilTyp: 'Azubi',
        profilbild:
            'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=100&auto=format&fit=crop',
        stadt: 'Hamburg',
        handwerkskammer: 'HWK Hamburg'),
  ];

  List<Profil> _allTalents = [];
  List<Profil> _filteredTalents = [];

  // Filter values
  String? _selectedSkill;
  int? _selectedLehrjahr;
  String? _selectedGewerk;
  String? _selectedOrt;
  String? _selectedKammer;

  // Lists for filter options
  List<String> _allSkills = [];
  List<int> _allLehrjahre = [];
  List<String> _allGewerke = [];
  List<String> _allOrte = [];
  List<String> _allKammern = [];

  @override
  void initState() {
    super.initState();
    _initializeLists();
  }

  @override
  void didUpdateWidget(TalentListeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.talente != oldWidget.talente) {
      _initializeLists();
    }
  }

  void _initializeLists() {
    _allTalents = [..._initialTalentAngebote, ...widget.talente];
    
    _allSkills = _allTalents
        .expand<String>((talent) => talent.faehigkeiten ?? [])
        .toSet()
        .toList()..sort();
    _allLehrjahre =
        _allTalents.map((t) => t.lehrjahr).whereType<int>().toSet().toList()..sort();
    _allGewerke =
        _allTalents.map((t) => t.gewerk).whereType<String>().toSet().toList()..sort();
    _allOrte = 
        _allTalents.map((t) => t.stadt).whereType<String>().toSet().toList()..sort();
    _allKammern = _allTalents
        .map((t) => t.handwerkskammer)
        .whereType<String>()
        .toSet()
        .toList()..sort();
    _applyFilters(); 
  }

  void _applyFilters() {
    setState(() {
      _filteredTalents = _allTalents.where((talent) {
        final bool skillMatch = _selectedSkill == null ||
            (talent.faehigkeiten?.contains(_selectedSkill) ?? false);
        final bool lehrjahrMatch =
            _selectedLehrjahr == null || talent.lehrjahr == _selectedLehrjahr;
        final bool gewerkMatch =
            _selectedGewerk == null || talent.gewerk == _selectedGewerk;
        final bool ortMatch = _selectedOrt == null || talent.stadt == _selectedOrt;
        final bool kammerMatch =
            _selectedKammer == null || talent.handwerkskammer == _selectedKammer;
        return skillMatch && lehrjahrMatch && gewerkMatch && ortMatch && kammerMatch;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedSkill = null;
      _selectedLehrjahr = null;
      _selectedGewerk = null;
      _selectedOrt = null;
      _selectedKammer = null;
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
              title: const Text('Talente filtern'),
              content: DefaultTabController(
                length: 5,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: Column(
                    children: [
                      const TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Fähigkeiten'),
                          Tab(text: 'Lehrjahr'),
                          Tab(text: 'Gewerk'),
                          Tab(text: 'Ort'),
                          Tab(text: 'Kammer'),
                        ],
                        labelColor: Color(0xFF002C59),
                        unselectedLabelColor: Colors.grey,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildFilterList(_allSkills, _selectedSkill, (val) => setState(() => _selectedSkill = val as String?)),
                            _buildFilterList(_allLehrjahre, _selectedLehrjahr, (val) => setState(() => _selectedLehrjahr = val as int?)),
                            _buildFilterList(_allGewerke, _selectedGewerk, (val) => setState(() => _selectedGewerk = val as String?)),
                            _buildFilterList(_allOrte, _selectedOrt, (val) => setState(() => _selectedOrt = val as String?)),
                            _buildFilterList(_allKammern, _selectedKammer, (val) => setState(() => _selectedKammer = val as String?)),
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
      shrinkWrap: true,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('Alle anzeigen'),
            trailing: selectedItem == null ? const Icon(Icons.check, color: Color(0xFF002C59)) : null,
            onTap: () => onChanged(null),
          );
        }
        final item = items[index - 1];
        return ListTile(
          title: Text(item.toString()),
          trailing: selectedItem == item ? const Icon(Icons.check, color: Color(0xFF002C59)) : null,
          onTap: () => onChanged(item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _filteredTalents.length,
        itemBuilder: (context, index) {
          final talent = _filteredTalents[index];
          final profilbild = talent.profilbild ??
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(profilbild),
                backgroundColor: Colors.grey[200],
              ),
              title: Text('${talent.vorname ?? ''} ${talent.name ?? ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${talent.gewerk ?? 'N/A'} - ${talent.lehrjahr}. Lehrjahr\n${talent.stadt ?? 'Ort unbekannt'}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TalentDetailScreen(
                      talent: talent,
                      onAnfrage: widget.onAnfrage,
                      profil: widget.profil,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 72.0),
        child: FloatingActionButton(
          onPressed: _showFilterDialog,
          heroTag: 'filter_talente',
          child: const Icon(Icons.filter_list),
        ),
      ),
    );
  }
}
