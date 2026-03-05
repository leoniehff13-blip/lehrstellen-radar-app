import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/screens/neues_profil_screen.dart';

class KontoScreen extends StatefulWidget {
  final Profil? profil;
  final Function(Profil) onProfilUpdated;

  const KontoScreen({
    super.key,
    this.profil,
    required this.onProfilUpdated,
  });

  @override
  State<KontoScreen> createState() => _KontoScreenState();
}

class _KontoScreenState extends State<KontoScreen> {
  Profil? _profil;

  @override
  void initState() {
    super.initState();
    _profil = widget.profil;
  }

  @override
  void didUpdateWidget(KontoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.profil != oldWidget.profil) {
      setState(() {
        _profil = widget.profil;
      });
    }
  }

  Future<void> _navigateToEditScreen(BuildContext context) async {
    if (_profil != null) {
      final updatedProfile = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NeuesProfilScreen(profil: _profil),
        ),
      );

      if (updatedProfile != null) {
        widget.onProfilUpdated(updatedProfile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Profil'),
        actions: [
          if (_profil != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _navigateToEditScreen(context),
            ),
        ],
      ),
      body: _profil == null
          ? const Center(
              child: Text('Noch kein Profil erstellt.'),
            )
          : _buildProfilDetails(context),
    );
  }

  Widget _buildProfilDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          if (_profil!.profilTyp == 'Azubi') ...[
            _buildAzubiProfil(context),
          ] else if (_profil!.profilTyp == 'Unternehmen') ...[
            _buildUnternehmenProfil(context),
          ]
        ],
      ),
    );
  }

  Widget _buildAzubiProfil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Profil-Typ: ${_profil!.profilTyp}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _buildInfoCard('Name', '${_profil!.vorname} ${_profil!.name}'),
        _buildInfoCard('Wohnort', '${_profil!.stadt}, ${_profil!.land}'),
        _buildInfoCard('Gewerk', _profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ausbildungsbetrieb', _profil!.unternehmen ?? 'Nicht angegeben'),
        _buildInfoCard('Lehrjahr', '${_profil!.lehrjahr}. Lehrjahr'),
        if (_profil!.faehigkeiten != null && _profil!.faehigkeiten!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Fähigkeiten', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _profil!.faehigkeiten!.map((skill) => Chip(label: Text(skill))).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildUnternehmenProfil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Profil-Typ: ${_profil!.profilTyp}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _buildInfoCard('Name des Betriebs', _profil!.betrieb ?? 'Nicht angegeben'),
         _buildInfoCard('Gewerk', _profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ansprechperson', _profil!.ansprechperson ?? 'Nicht angegeben'),
        _buildInfoCard('Adresse', '${_profil!.strasse} ${_profil!.hausnummer}, ${_profil!.plz} ${_profil!.stadt}, ${_profil!.land}'),
        _buildInfoCard('Handwerkskammer', _profil!.handwerkskammer ?? 'Nicht angegeben'),
        _buildInfoCard('Spezialisierung', _profil!.spezialisierung ?? 'Nicht angegeben'),
      ],
    );
  }

  Widget _buildInfoCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
