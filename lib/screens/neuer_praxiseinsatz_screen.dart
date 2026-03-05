import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myapp/data/skills_data.dart';
import 'package:myapp/models/betrieb.dart';

class NeuerPraxiseinsatzScreen extends StatefulWidget {
  final Betrieb? betriebProfile;

  const NeuerPraxiseinsatzScreen({super.key, this.betriebProfile});

  @override
  NeuerPraxiseinsatzScreenState createState() =>
      NeuerPraxiseinsatzScreenState();
}

class NeuerPraxiseinsatzScreenState extends State<NeuerPraxiseinsatzScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectedDateRange;

  final _nameController = TextEditingController();
  final _ansprechpartnerController = TextEditingController();
  final _handwerkskammerController = TextEditingController();

  String? _selectedGewerk;
  final List<String> _gewerke = ['Elektriker', 'Zimmerer'];

  List<String> _aufgabenbereiche = [];
  List<String> _selectedAufgabenbereiche = [];

  @override
  void initState() {
    super.initState();
    if (widget.betriebProfile != null) {
      _nameController.text = widget.betriebProfile!.name;
      _ansprechpartnerController.text = widget.betriebProfile!.ansprechpartner;
      _handwerkskammerController.text = widget.betriebProfile!
          .handwerkskammerId; // Assuming this is the correct field
      if (_gewerke.contains(widget.betriebProfile!.branche)) {
        _selectedGewerk = widget.betriebProfile!.branche;
        _updateAufgaben(isInit: true);
      }
      _selectedAufgabenbereiche =
          List<String>.from(widget.betriebProfile!.aufgabenbereiche);
    }
  }

  void _updateAufgaben({bool isInit = false}) {
    setState(() {
      _aufgabenbereiche = skillsByGewerk[_selectedGewerk] ?? [];
      if (!isInit) {
        _selectedAufgabenbereiche.clear();
      }
    });
  }

  void _createPraxiseinsatz() {
    if (!mounted) return;
    if (_formKey.currentState!.validate()) {
      final neuerEinsatz = Betrieb(
        name: _nameController.text,
        ansprechpartner: _ansprechpartnerController.text,
        branche: _selectedGewerk!,
        handwerkskammerId: _handwerkskammerController.text,
        aufgabenbereiche: _selectedAufgabenbereiche,
        ort: widget.betriebProfile?.ort ?? '',
        logo: widget.betriebProfile?.logo ?? '',
        beschreibung: widget.betriebProfile?.beschreibung ?? '',
        webseite: widget.betriebProfile?.webseite ?? '',
        adresse: widget.betriebProfile?.adresse ?? '',
        email: widget.betriebProfile?.email ?? '',
        telefon: widget.betriebProfile?.telefon ?? '',
      );
      Navigator.of(context).pop(neuerEinsatz);
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
        title: const Text('Neuer Praxiseinsatz'),
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
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Name des Betriebs'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gewerk/Branche',
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
                    _updateAufgaben();
                  });
                },
                validator: (value) =>
                    value == null ? 'Bitte ein Gewerk auswählen' : null,
                isExpanded: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ansprechpartnerController,
                decoration: const InputDecoration(labelText: 'Ansprechpartner'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _handwerkskammerController,
                decoration: const InputDecoration(
                    labelText: 'Zuständige Handwerkskammer'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateRange == null
                        ? 'Einsatzzeitraum'
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
                  labelText: 'Einsatzort',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              if (_selectedGewerk != null)
                MultiSelectDialogField(
                  items: _aufgabenbereiche
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: const Text("Aufgabenbereiche/Anforderungen"),
                  selectedColor: Theme.of(context).primaryColor,
                  initialValue: _selectedAufgabenbereiche,
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
                    "Aufgabenbereiche auswählen",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  onConfirm: (results) {
                    setState(() {
                      _selectedAufgabenbereiche = results.cast<String>();
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      setState(() {
                        _selectedAufgabenbereiche.remove(value);
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
                onPressed: _createPraxiseinsatz,
                child: const Text('PRAXISEINSATZ ERSTELLEN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
