import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myapp/data/skills_data.dart';
import 'package:myapp/models/profil.dart';

class NeueTalentleiheScreen extends StatefulWidget {
  final Profil? userProfile;

  const NeueTalentleiheScreen({super.key, this.userProfile});

  @override
  NeueTalentleiheScreenState createState() => NeueTalentleiheScreenState();
}

class NeueTalentleiheScreenState extends State<NeueTalentleiheScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectedDateRange;

  final _nameController = TextEditingController();
  final _vornameController = TextEditingController();
  final _unternehmenController = TextEditingController();
  final _handwerkskammerController = TextEditingController();
  final _faehigkeitenController = TextEditingController();

  String? _selectedGewerk;
  final List<String> _gewerke = ['Elektriker', 'Zimmerer'];

  List<String> _lernziele = [];
  List<String> _selectedLernziele = [];

  @override
  void initState() {
    super.initState();
    if (widget.userProfile != null) {
      _nameController.text = widget.userProfile!.name ?? '';
      _vornameController.text = widget.userProfile!.vorname ?? '';
      _unternehmenController.text = widget.userProfile!.unternehmen ?? '';
      _handwerkskammerController.text =
          widget.userProfile!.handwerkskammer ?? '';
      _faehigkeitenController.text = widget.userProfile!.faehigkeiten?.join(', ') ?? '';
      if (_gewerke.contains(widget.userProfile!.gewerk)) {
        _selectedGewerk = widget.userProfile!.gewerk;
        _updateLernziele(isInit: true);
      }
       _selectedLernziele = List<String>.from(widget.userProfile!.faehigkeiten ?? []);
    }
  }

  void _updateLernziele({bool isInit = false}) {
    setState(() {
      _lernziele = skillsByGewerk[_selectedGewerk] ?? [];
      if (!isInit) {
        _selectedLernziele.clear();
      }
    });
  }

  void _createTalentleihe() {
    if (_formKey.currentState!.validate()) {
      final neuesAngebot = Profil(
        // Copy unchanging data from the original profile
        profilTyp: widget.userProfile?.profilTyp,
        betrieb: widget.userProfile?.betrieb,
        strasse: widget.userProfile?.strasse,
        hausnummer: widget.userProfile?.hausnummer,
        plz: widget.userProfile?.plz,
        stadt: widget.userProfile?.stadt,
        land: widget.userProfile?.land,
        ansprechperson: widget.userProfile?.ansprechperson,
        spezialisierung: widget.userProfile?.spezialisierung,
        lehrjahr: widget.userProfile?.lehrjahr,

        // Use data from the form controllers and selections
        name: _nameController.text,
        vorname: _vornameController.text,
        unternehmen: _unternehmenController.text,
        handwerkskammer: _handwerkskammerController.text,
        gewerk: _selectedGewerk,
        faehigkeiten: _selectedLernziele,
      );
      Navigator.of(context).pop(neuesAngebot);
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Talentleihe'),
        backgroundColor: const Color(0xFFD6DCE5),
        titleTextStyle: const TextStyle(
          color: Color(0xFF002C59),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _vornameController,
                      decoration: const InputDecoration(labelText: 'Vorname'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nachname'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gewerk',
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedGewerk,
                items: _gewerke.map((String gewerk) {
                  return DropdownMenuItem<String>(
                    value: gewerk,
                    child: Text(gewerk),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGewerk = newValue;
                    _updateLernziele();
                  });
                },
                validator: (value) =>
                    value == null ? 'Bitte ein Gewerk auswählen' : null,
                isExpanded: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _unternehmenController,
                      decoration: const InputDecoration(labelText: 'Unternehmen'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _handwerkskammerController,
                      decoration: const InputDecoration(labelText: 'Handwerkskammer'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateRange == null
                        ? 'Verfügbarkeitszeitraum'
                        : '${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.end)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () => _selectDateRange(context),
                    child: const Text('Auswählen'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Präferierte Einsatzorte oder Umkreissuche',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _faehigkeitenController,
                decoration: const InputDecoration(labelText: 'Bestehende Fähigkeiten (Referenz)'),
                readOnly: true, // This should remain read-only as a reference
              ),
              const SizedBox(height: 24),
              if (_selectedGewerk != null)
                MultiSelectDialogField(
                  items: _lernziele.map((e) => MultiSelectItem(e, e)).toList(),
                  title: const Text("Neue/Angebotene Fähigkeiten"),
                  selectedColor: Theme.of(context).primaryColor,
                  initialValue: _selectedLernziele,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  buttonText: Text(
                    "Neue/Angebotene Fähigkeiten auswählen",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  onConfirm: (results) {
                    setState(() {
                      _selectedLernziele = results.cast<String>();
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      setState(() {
                        _selectedLernziele.remove(value);
                      });
                    },
                  ),
                ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: _createTalentleihe, // Updated onPressed handler
                child: const Text('ANGEBOT ERSTELLEN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
