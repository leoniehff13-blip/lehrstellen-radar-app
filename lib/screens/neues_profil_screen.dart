import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:myapp/models/profil.dart';

class NeuesProfilScreen extends StatefulWidget {
  final Profil? profil;

  const NeuesProfilScreen({super.key, this.profil});

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
  final _spezialisierungController = TextEditingController();
  final _ansprechpersonController = TextEditingController();

  final List<TextEditingController> _faehigkeitenControllers = [];

  @override
  void initState() {
    super.initState();
    _countries.addAll(CountryService().getAll().map((c) => c.name).where((name) => name != 'Germany'));

    if (widget.profil != null) {
      final p = widget.profil!;
      _selectedProfilTyp = p.profilTyp;
      _nameController.text = p.name ?? '';
      _vornameController.text = p.vorname ?? '';
      _betriebController.text = p.betrieb ?? '';
      _strasseController.text = p.strasse ?? '';
      _hausnummerController.text = p.hausnummer ?? '';
      _plzController.text = p.plz ?? '';
      _stadtController.text = p.stadt ?? '';
      _selectedCountry = p.land;
      _ansprechpersonController.text = p.ansprechperson ?? '';
      _selectedGewerk = p.gewerk;
      _unternehmenController.text = p.unternehmen ?? '';
      _handwerkskammerController.text = p.handwerkskammer ?? '';
      _spezialisierungController.text = p.spezialisierung ?? '';
      _selectedLehrjahr = p.lehrjahr;

      if (p.faehigkeiten != null && p.faehigkeiten!.isNotEmpty) {
        _faehigkeitenControllers.addAll(
          p.faehigkeiten!.map((faehigkeit) => TextEditingController(text: faehigkeit)),
        );
      } else {
        _faehigkeitenControllers.add(TextEditingController());
      }
    } else {
      _faehigkeitenControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _vornameController.dispose();
    _betriebController.dispose();
    _strasseController.dispose();
    _hausnummerController.dispose();
    _plzController.dispose();
    _stadtController.dispose();
    _unternehmenController.dispose();
    _handwerkskammerController.dispose();
    _spezialisierungController.dispose();
    _ansprechpersonController.dispose();
    for (var controller in _faehigkeitenControllers) {
      controller.dispose();
    }
    super.dispose();
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

  Widget _buildGewerkField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedGewerk,
              decoration: const InputDecoration(labelText: 'Gewerk*'),
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
              validator: (value) => value == null ? 'Bitte ein Gewerk auswählen' : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Information',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Hinweis'),
                  content: const Text(
                      'Dieses Programm befindet sich in einer Testphase - komm später noch einmal wieder, um zu schauen, ob nun auch dein Gewerk mitmacht.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFaehigkeitenList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('Fähigkeiten', style: Theme.of(context).textTheme.titleMedium),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _faehigkeitenControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _faehigkeitenControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Fähigkeit ${index + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (_faehigkeitenControllers.length > 1) {
                          _faehigkeitenControllers[index].dispose();
                          _faehigkeitenControllers.removeAt(index);
                        } else {
                          _faehigkeitenControllers[index].clear();
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Fähigkeit hinzufügen'),
          onPressed: () {
            setState(() {
              _faehigkeitenControllers.add(TextEditingController());
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.profil != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Profil bearbeiten' : 'Neues Profil anlegen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (!isEditing)
                DropdownButtonFormField<String>(
                  value: _selectedProfilTyp,
                  decoration: const InputDecoration(labelText: 'Profil-Typ*'),
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
                )
              else
                Text('Profil-Typ: $_selectedProfilTyp', style: Theme.of(context).textTheme.titleLarge),
              if (_selectedProfilTyp == 'Unternehmen') ...[
                _buildGewerkField(),
                TextFormField(
                  controller: _ansprechpersonController,
                  decoration: const InputDecoration(labelText: 'Ansprechperson*'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte eine Ansprechperson eingeben' : null,
                ),
                TextFormField(
                  controller: _betriebController,
                  decoration: const InputDecoration(labelText: 'Name des Betriebs*'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Betriebsnamen eingeben' : null,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _strasseController,
                        decoration: const InputDecoration(labelText: 'Straße*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte eine Straße eingeben' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        controller: _hausnummerController,
                        decoration: const InputDecoration(labelText: 'Hausnummer*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte eine Hausnummer eingeben' : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        controller: _plzController,
                        decoration: const InputDecoration(labelText: 'Postleitzahl*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte eine PLZ eingeben' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _stadtController,
                        decoration: const InputDecoration(labelText: 'Ort*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Ort eingeben' : null,
                      ),
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: const InputDecoration(labelText: 'Land*'),
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
                  validator: (value) => value == null ? 'Bitte ein Land auswählen' : null,
                ),
                TextFormField(
                  controller: _handwerkskammerController,
                  decoration: const InputDecoration(labelText: 'Handwerkskammer'),
                ),
                TextFormField(
                  controller: _spezialisierungController,
                  decoration: const InputDecoration(labelText: 'Spezialisierung'),
                ),
              ] else if (_selectedProfilTyp == 'Azubi') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _vornameController,
                        decoration: const InputDecoration(labelText: 'Vorname*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Vornamen eingeben' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name*'),
                        validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Namen eingeben' : null,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _stadtController,
                  decoration: const InputDecoration(labelText: 'Ort*'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte einen Ort eingeben' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: const InputDecoration(labelText: 'Land*'),
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
                  validator: (value) => value == null ? 'Bitte ein Land auswählen' : null,
                ),
                _buildGewerkField(),
                TextFormField(
                  controller: _unternehmenController,
                  decoration: const InputDecoration(labelText: 'Unternehmen*'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bitte das Unternehmen eingeben' : null,
                ),
                DropdownButtonFormField<int>(
                  value: _selectedLehrjahr,
                  decoration: const InputDecoration(labelText: 'Lehrjahr*'),
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
                _buildFaehigkeitenList(),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final faehigkeiten = _faehigkeitenControllers
                        .map((controller) => controller.text.trim())
                        .where((faehigkeit) => faehigkeit.isNotEmpty)
                        .toList();

                    final updatedProfile = Profil(
                      profilTyp: _selectedProfilTyp,
                      name: _nameController.text,
                      vorname: _vornameController.text,
                      betrieb: _betriebController.text,
                      strasse: _strasseController.text,
                      hausnummer: _hausnummerController.text,
                      plz: _plzController.text,
                      stadt: _stadtController.text,
                      land: _selectedCountry,
                      ansprechperson: _ansprechpersonController.text,
                      gewerk: _selectedGewerk,
                      unternehmen: _unternehmenController.text,
                      handwerkskammer: _handwerkskammerController.text,
                      spezialisierung: _spezialisierungController.text,
                      lehrjahr: _selectedLehrjahr,
                      faehigkeiten: faehigkeiten,
                    );

                    Navigator.of(context).pop(updatedProfile);
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
