import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
  final _gewerkController = TextEditingController();

  final List<String> _lernziele = [
    'Schweißen',
    'Löten',
    'CNC-Fräsen',
    'Qualitätskontrolle',
    'Technisches Zeichnen'
  ];
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
      _faehigkeitenController.text = widget.userProfile!.faehigkeiten ?? '';
      _gewerkController.text = widget.userProfile!.gewerk ?? '';
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                readOnly: true,
              ),
              TextFormField(
                controller: _vornameController,
                decoration: const InputDecoration(labelText: 'Vorname'),
                readOnly: true,
              ),
              TextFormField(
                controller: _gewerkController,
                decoration: const InputDecoration(labelText: 'Gewerk'),
                readOnly: true,
              ),
              TextFormField(
                controller: _unternehmenController,
                decoration: const InputDecoration(labelText: 'Unternehmen'),
                readOnly: true,
              ),
              TextFormField(
                controller: _handwerkskammerController,
                decoration: const InputDecoration(labelText: 'Handwerkskammer'),
                readOnly: true,
              ),
              TextFormField(
                controller: _faehigkeitenController,
                decoration: const InputDecoration(labelText: 'Fähigkeiten'),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              MultiSelectDialogField(
                items: _lernziele.map((e) => MultiSelectItem(e, e)).toList(),
                title: const Text("Lernziele"),
                selectedColor: Theme.of(context).primaryColor,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                buttonText: const Text(
                  "Lernziele auswählen",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  setState(() {
                    _selectedLernziele = results.cast<String>().toList();
                  });
                },
              ),
              const SizedBox(height: 16),
               if (_selectedLernziele.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Ausgewählte Ziele: ${_selectedLernziele.join(', ')}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Text(_selectedDateRange == null
                        ? 'Kein Zeitraum ausgewählt'
                        : '${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.end)}'),
                  ),
                  TextButton(
                    onPressed: () => _selectDateRange(context),
                    child: const Text('Zeitraum auswählen'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Präferierte Einsatzorte oder Umkreissuche',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement save logic
                  }
                },
                child: const Text('Talentleihe erstellen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
