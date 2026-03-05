import 'dart:io';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myapp/data/skills_data.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/data/hwk_data.dart';

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
  String? _selectedHandwerkskammer;
  String? _profilbildPath;

  final List<String> _countries = ['Deutschland'];
  final List<String> _gewerke = ['Elektriker', 'Zimmerer'];
  final List<String> _profilTypen = ['Azubi', 'Unternehmen'];
  final List<int> _lehrjahre = [1, 2, 3, 4];

  List<String> _faehigkeiten = [];
  List<String> _selectedFaehigkeiten = [];

  final _nameController = TextEditingController();
  final _vornameController = TextEditingController();
  final _betriebController = TextEditingController();
  final _strasseController = TextEditingController();
  final _hausnummerController = TextEditingController();
  final _plzController = TextEditingController();
  final _stadtController = TextEditingController();
  final _unternehmenController = TextEditingController();
  final _spezialisierungController = TextEditingController();
  final _ansprechpersonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countries.addAll(CountryService()
        .getAll()
        .map((c) => c.name)
        .where((name) => name != 'Germany'));

    if (widget.profil != null) {
      _populateFieldsFromProfile(widget.profil!);
    }
  }

  void _populateFieldsFromProfile(Profil p) {
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
    _selectedHandwerkskammer = p.handwerkskammer;
    _spezialisierungController.text = p.spezialisierung ?? '';
    _selectedLehrjahr = p.lehrjahr;
    _profilbildPath = p.profilbild;

    if (p.gewerk != null) {
      _faehigkeiten = skillsByGewerk[p.gewerk!] ?? [];
    }
    if (p.faehigkeiten != null) {
      _selectedFaehigkeiten = List<String>.from(p.faehigkeiten!);
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
    _spezialisierungController.dispose();
    _ansprechpersonController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilbildPath = pickedFile.path;
      });
    }
  }

  void _updateFaehigkeiten() {
    setState(() {
      _faehigkeiten = skillsByGewerk[_selectedGewerk] ?? [];
      _selectedFaehigkeiten.clear();
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
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
        handwerkskammer: _selectedHandwerkskammer,
        spezialisierung: _spezialisierungController.text,
        lehrjahr: _selectedLehrjahr,
        faehigkeiten: _selectedFaehigkeiten,
        profilbild: _profilbildPath,
      );
      Navigator.of(context).pop(updatedProfile);
    }
  }

  void _deleteProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profil löschen'),
        content: const Text('Möchtest du dein Profil wirklich löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop('delete'); // Pop the screen and return 'delete'
            },
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
  }

  void _checkLand() {
    if (_selectedCountry != null &&
        _selectedCountry!.toLowerCase() != 'deutschland') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Falscher Firmensitz'),
          content: const Text(
              'Dein Firmensitz ist nicht in Deutschland und deswegen kannst du leider nicht am Programm teilnehmen.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK')),
          ],
        ),
      );
    }
  }

  String _getAppBarTitle() {
    if (widget.profil != null) {
      final profilTyp = widget.profil?.profilTyp;
      if (profilTyp == 'Azubi' || profilTyp == 'Talent') {
        return 'Azubi-Profil bearbeiten';
      } else if (profilTyp == 'Unternehmen') {
        return 'Unternehmensprofil bearbeiten';
      }
      return 'Profil bearbeiten';
    } else {
      return 'Neues Profil anlegen';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.profil != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.grey[200],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!isEditing) ...[
                DropdownButtonFormField<String>(
                  initialValue: _selectedProfilTyp,
                  decoration: const InputDecoration(
                      labelText: 'Profil-Typ*', border: OutlineInputBorder()),
                  items: _profilTypen
                      .map((String typ) => DropdownMenuItem<String>(
                          value: typ, child: Text(typ)))
                      .toList(),
                  onChanged: (newValue) =>
                      setState(() => _selectedProfilTyp = newValue),
                  validator: (value) =>
                      value == null ? 'Bitte einen Profil-Typ auswählen' : null,
                ),
                const SizedBox(height: 24),
              ],
              if (_selectedProfilTyp != null) ...[
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilbildPath != null
                            ? FileImage(File(_profilbildPath!))
                            : null,
                        child: _profilbildPath == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // UNTERNEHMEN-FELDER
                if (_selectedProfilTyp == 'Unternehmen') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedGewerk,
                            decoration: const InputDecoration(
                                labelText: 'Gewerk*',
                                border: OutlineInputBorder()),
                            items: _gewerke
                                .map((String gewerk) =>
                                    DropdownMenuItem<String>(
                                        value: gewerk, child: Text(gewerk)))
                                .toList(),
                            onChanged: (newValue) =>
                                setState(() => _selectedGewerk = newValue),
                            validator: (value) => value == null
                                ? 'Bitte ein Gewerk auswählen'
                                : null,
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
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'))
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                      controller: _ansprechpersonController,
                      decoration: const InputDecoration(
                          labelText: 'Ansprechperson*',
                          border: OutlineInputBorder()),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Bitte eine Ansprechperson eingeben'
                          : null),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _betriebController,
                      decoration: const InputDecoration(
                          labelText: 'Name des Betriebs*',
                          border: OutlineInputBorder()),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Bitte einen Betriebsnamen eingeben'
                          : null),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                            controller: _strasseController,
                            decoration: const InputDecoration(
                                labelText: 'Straße*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte eine Straße eingeben'
                                    : null)),
                    const SizedBox(width: 16),
                    SizedBox(
                        width: 100,
                        child: TextFormField(
                            controller: _hausnummerController,
                            decoration: const InputDecoration(
                                labelText: 'Nr.*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte eine Hausnummer eingeben'
                                    : null))
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    SizedBox(
                        width: 120,
                        child: TextFormField(
                            controller: _plzController,
                            decoration: const InputDecoration(
                                labelText: 'PLZ*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte eine PLZ eingeben'
                                    : null)),
                    const SizedBox(width: 16),
                    Expanded(
                        child: TextFormField(
                            controller: _stadtController,
                            decoration: const InputDecoration(
                                labelText: 'Ort*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte einen Ort eingeben'
                                    : null))
                  ]),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                      initialValue: _selectedCountry,
                      decoration: const InputDecoration(
                          labelText: 'Land*', border: OutlineInputBorder()),
                      items: _countries
                          .map((String country) => DropdownMenuItem<String>(
                              value: country, child: Text(country)))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() => _selectedCountry = newValue);
                        _checkLand();
                      },
                      validator: (value) =>
                          value == null ? 'Bitte ein Land auswählen' : null),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _spezialisierungController,
                      decoration: const InputDecoration(
                          labelText: 'Spezialisierung',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: 'Handwerkskammer',
                        border: OutlineInputBorder()),
                    items: alleHandwerkskammern.map((Handwerkskammer kammer) {
                      return DropdownMenuItem<String>(
                        value: kammer.id,
                        child: Text(kammer.shortName),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedHandwerkskammer = newValue;
                      });
                    },
                    initialValue: _selectedHandwerkskammer,
                    validator: (value) => value == null
                        ? 'Bitte eine Handwerkskammer auswählen'
                        : null,
                  ),
                ],

                // AZUBI-FELDER
                if (_selectedProfilTyp == 'Azubi' || _selectedProfilTyp == 'Talent') ...[
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                            controller: _vornameController,
                            decoration: const InputDecoration(
                                labelText: 'Vorname*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte einen Vornamen eingeben'
                                    : null)),
                    const SizedBox(width: 16),
                    Expanded(
                        child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                labelText: 'Name*',
                                border: OutlineInputBorder()),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Bitte einen Namen eingeben'
                                    : null))
                  ]),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _stadtController,
                      decoration: const InputDecoration(
                          labelText: 'Ort*', border: OutlineInputBorder()),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Bitte einen Ort eingeben'
                          : null),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                      initialValue: _selectedCountry,
                      decoration: const InputDecoration(
                          labelText: 'Land*', border: OutlineInputBorder()),
                      items: _countries
                          .map((String country) => DropdownMenuItem<String>(
                              value: country, child: Text(country)))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() => _selectedCountry = newValue);
                        _checkLand();
                      },
                      validator: (value) =>
                          value == null ? 'Bitte ein Land auswählen' : null),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedGewerk,
                            decoration: const InputDecoration(
                                labelText: 'Gewerk*',
                                border: OutlineInputBorder()),
                            items: _gewerke
                                .map((String gewerk) =>
                                    DropdownMenuItem<String>(
                                        value: gewerk, child: Text(gewerk)))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGewerk = newValue;
                                _updateFaehigkeiten();
                              });
                            },
                            validator: (value) => value == null
                                ? 'Bitte ein Gewerk auswählen'
                                : null,
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
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'))
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                      controller: _unternehmenController,
                      decoration: const InputDecoration(
                          labelText: 'Unternehmen*',
                          border: OutlineInputBorder()),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Bitte das Unternehmen eingeben'
                          : null),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                      initialValue: _selectedLehrjahr,
                      decoration: const InputDecoration(
                          labelText: 'Lehrjahr*', border: OutlineInputBorder()),
                      items: _lehrjahre
                          .map((int lehrjahr) => DropdownMenuItem<int>(
                              value: lehrjahr,
                              child: Text('$lehrjahr. Lehrjahr')))
                          .toList(),
                      onChanged: (newValue) =>
                          setState(() => _selectedLehrjahr = newValue),
                      validator: (value) => value == null
                          ? 'Bitte das Lehrjahr auswählen'
                          : null),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: 'Handwerkskammer',
                        border: OutlineInputBorder()),
                    items: alleHandwerkskammern.map((Handwerkskammer kammer) {
                      return DropdownMenuItem<String>(
                        value: kammer.id,
                        child: Text(kammer.shortName),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedHandwerkskammer = newValue;
                      });
                    },
                    initialValue: _selectedHandwerkskammer,
                    validator: (value) => value == null
                        ? 'Bitte eine Handwerkskammer auswählen'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  // Fähigkeiten
                  if (_selectedGewerk != null)
                    MultiSelectDialogField(
                      items: _faehigkeiten
                          .map((e) => MultiSelectItem(e, e))
                          .toList(),
                      title: const Text("Fähigkeiten auswählen"),
                      initialValue: _selectedFaehigkeiten,
                      selectedColor: Theme.of(context).primaryColor,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      buttonIcon:
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      buttonText: Text(
                        "Fähigkeiten auswählen",
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedFaehigkeiten = results.cast<String>();
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            _selectedFaehigkeiten.remove(value);
                          });
                        },
                      ),
                    ),
                ],

                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: _saveProfile,
                  child: const Text('Profil speichern',
                      style: TextStyle(fontSize: 16)),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _deleteProfile,
                    child: const Text('Profil löschen', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ]
            ],
          ),
        ),
      ),
    );
  }
}
