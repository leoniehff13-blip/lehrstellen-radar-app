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
  final _einsatzortController = TextEditingController();

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
      _faehigkeitenController.text =
          widget.userProfile!.faehigkeiten?.join(', ') ?? '';
      _gewerkController.text = widget.userProfile!.gewerk ?? '';
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, show success message and pop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Talentleihe erfolgreich erstellt!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Talentleihe'),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
         iconTheme: const IconThemeData(color: Colors.white),
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
                controller: _faehigkeitenController,
                decoration: const InputDecoration(labelText: 'Fähigkeiten'),
                readOnly: true,
              ),
              const SizedBox(height: 24),
              
              // Lernziele MultiSelect
              MultiSelectDialogField(
                items: _lernziele.map((e) => MultiSelectItem(e, e)).toList(),
                title: const Text("Lernziele"),
                selectedColor: Theme.of(context).primaryColor,
                buttonText: const Text("Gewünschte Lernziele auswählen"),
                onConfirm: (results) {
                  _selectedLernziele = results.cast<String>().toList();
                   _formKey.currentState?.validate();
                },
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return 'Bitte wählen Sie mindestens ein Lernziel aus.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Zeitraum Picker
              FormField<DateTimeRange>(
                validator: (value) {
                  if (_selectedDateRange == null) {
                    return 'Bitte wählen Sie einen Zeitraum aus.';
                  }
                  return null;
                },
                builder: (FormFieldState<DateTimeRange> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_selectedDateRange == null
                            ? 'Gewünschter Zeitraum'
                            : '${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd.MM.yyyy').format(_selectedDateRange!.end)}'),
                        trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                        onTap: () async {
                           await _selectDateRange(context);
                           state.didChange(_selectedDateRange);
                        },
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // Einsatzort TextFormField
              TextFormField(
                controller: _einsatzortController,
                decoration: const InputDecoration(
                  labelText: 'Präferierte Einsatzorte oder Umkreis',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie einen Einsatzort oder Umkreis an.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('TALENTLEIHE ERSTELLEN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
