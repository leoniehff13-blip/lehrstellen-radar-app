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
  final List<String> _countries = ['Deutschland'];
  final List<String> _gewerke = ['Elektriker', 'Zimmerer'];

  final _nameController = TextEditingController();
  final _vornameController = TextEditingController();
  final _betriebController = TextEditingController();
  final _strasseController = TextEditingController();
  final _hausnummerController = TextEditingController();
  final _plzController = TextEditingController();
  final _stadtController = TextEditingController();

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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _vornameController,
                decoration: const InputDecoration(labelText: 'Vorname'),
              ),
              TextFormField(
                controller: _betriebController,
                decoration: const InputDecoration(labelText: 'Betrieb'),
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
              TextFormField(
                controller: _stadtController,
                decoration: const InputDecoration(labelText: 'Stadt'),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProfile = Profil(
                      name: _nameController.text,
                      vorname: _vornameController.text,
                      betrieb: _betriebController.text,
                      strasse: _strasseController.text,
                      hausnummer: _hausnummerController.text,
                      plz: _plzController.text,
                      stadt: _stadtController.text,
                      land: _selectedCountry,
                      gewerk: _selectedGewerk,
                    );
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
