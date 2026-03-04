import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:myapp/models/profil.dart';

class NeuesProfilScreen extends StatefulWidget {
  const NeuesProfilScreen({super.key});

  @override
  NeuesProfilScreenState createState() => NeuesProfilScreenState();
}

class NeuesProfilScreenState extends State<NeuesProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry;
  String? _selectedGewerk;
  String? _selectedProfilTyp;
  int? _selectedLehrjahr;
  final List<String> _countries = ['Deutschland'];
  final List<String> _gewerke = ['Elektriker', 'Zimmerer'];
  final List<String> _profilTypen = ['Azubi', 'Unternehmen'];
  final List<int> _lehrjahre = [1, 2, 3, 4];

  final _nameController = TextEditingController();
  final _vornameController = TextEditingController();
  final _betriebController = TextEditingController();
  final _strasseController = TextEditingController();
  final _hausnummerController = TextEditingController();
  final _plzController = TextEditingController();
  final _stadtController = TextEditingController();
  final _unternehmenController = TextEditingController();
  final _handwerkskammerController = TextEditingController();
  final _faehigkeitenController = TextEditingController();
  final _ansprechpersonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countries.addAll(CountryService().getAll().map((c) => c.name).where((name) => name != 'Germany'));
  }

  void _checkLand() {
    if (_selectedCountry != null &&
        _selectedCountry!.toLowerCase() != 'deutschland') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Falscher Firmensitz'),
          content: const Text(
            'Dein Firmensitz ist nicht in Deutschland und deswegen kannst du leider nicht am Programm teilnehmen.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Profil anlegen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                initialValue: _selectedProfilTyp,
                decoration: const InputDecoration(labelText: 'Profil-Typ'),
                items: _profilTypen.map((String typ) {
                  return DropdownMenuItem<String>(
                    value: typ,
                    child: Text(typ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedProfilTyp = newValue;
                  });
                },
                validator: (value) => value == null ? 'Bitte einen Profil-Typ auswählen' : null,
              ),
              if (_selectedProfilTyp == 'Azubi') ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Namen eingeben' : null,
                ),
                TextFormField(
                  controller: _vornameController,
                  decoration: const InputDecoration(labelText: 'Vorname'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Vornamen eingeben' : null,
                ),
              ] else if (_selectedProfilTyp == 'Unternehmen') ...[
                TextFormField(
                  controller: _betriebController,
                  decoration: const InputDecoration(labelText: 'Betrieb'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Betriebsnamen eingeben' : null,
                ),
                TextFormField(
                  controller: _strasseController,
                  decoration: const InputDecoration(labelText: 'Straße'),
                ),
                TextFormField(
                  controller: _hausnummerController,
                  decoration: const InputDecoration(labelText: 'Hausnummer'),
                ),
                TextFormField(
                  controller: _plzController,
                  decoration: const InputDecoration(labelText: 'Postleitzahl'),
                ),
              ],
              if (_selectedProfilTyp != null) ...[
                TextFormField(
                  controller: _stadtController,
                  decoration: const InputDecoration(labelText: 'Ort'),
                ),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCountry,
                  decoration: const InputDecoration(labelText: 'Land'),
                  items: _countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                      _checkLand();
                    });
                  },
                ),
                if (_selectedProfilTyp == 'Unternehmen')
                  TextFormField(
                    controller: _ansprechpersonController,
                    decoration: const InputDecoration(labelText: 'Ansprechperson'),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Dieses Programm befindet sich in einer Testphase - komm später noch einmal wieder, um zu schauen, ob nun auch dein Gewerk mitmacht :)',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGewerk,
                  decoration: const InputDecoration(labelText: 'Gewerk'),
                  items: _gewerke.map((String gewerk) {
                    return DropdownMenuItem<String>(
                      value: gewerk,
                      child: Text(gewerk),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGewerk = newValue;
                    });
                  },
                ),
              ],
              if (_selectedProfilTyp == 'Azubi') ...[
                TextFormField(
                  controller: _unternehmenController,
                  decoration: const InputDecoration(labelText: 'Unternehmen'),
                ),
                TextFormField(
                  controller: _handwerkskammerController,
                  decoration: const InputDecoration(labelText: 'Handwerkskammer'),
                ),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Lehrjahr'),
                  items: _lehrjahre.map((int lehrjahr) {
                    return DropdownMenuItem<int>(
                      value: lehrjahr,
                      child: Text('$lehrjahr. Lehrjahr'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLehrjahr = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Bitte das Lehrjahr auswählen' : null,
                ),
                TextFormField(
                  controller: _faehigkeitenController,
                  decoration: const InputDecoration(labelText: 'Fähigkeiten'),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProfile = Profil(
                        profilTyp: _selectedProfilTyp,
                        name: _selectedProfilTyp == 'Azubi' ? _nameController.text : null,
                        vorname: _selectedProfilTyp == 'Azubi' ? _vornameController.text : null,
                        betrieb: _selectedProfilTyp == 'Unternehmen' ? _betriebController.text : null,
                        strasse: _selectedProfilTyp == 'Unternehmen' ? _strasseController.text : null,
                        hausnummer: _selectedProfilTyp == 'Unternehmen' ? _hausnummerController.text : null,
                        plz: _selectedProfilTyp == 'Unternehmen' ? _plzController.text : null,
                        stadt: _stadtController.text,
                        land: _selectedCountry,
                        ansprechperson: _selectedProfilTyp == 'Unternehmen' ? _ansprechpersonController.text : null,
                        gewerk: _selectedGewerk,
                        unternehmen: _selectedProfilTyp == 'Azubi' ? _unternehmenController.text : null,
                        handwerkskammer: _selectedProfilTyp == 'Azubi' ? _handwerkskammerController.text : null,
                        lehrjahr: _selectedLehrjahr,
                        faehigkeiten: _selectedProfilTyp == 'Azubi' ? _faehigkeitenController.text : null);
                    Navigator.of(context).pop(newProfile);
                  }
                },
                child: const Text('Profil speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
