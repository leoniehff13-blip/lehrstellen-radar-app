import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/screens/neues_profil_screen.dart';

class KontoScreen extends StatelessWidget {
  final Profil? profil;
  final Function(Profil) onProfilUpdated;

  const KontoScreen({
    super.key,
    this.profil,
    required this.onProfilUpdated,
  });

  Future<void> _navigateToProfilScreen(BuildContext context) async {
    final result = await Navigator.of(context).push<Profil>(
      MaterialPageRoute(
        builder: (context) => NeuesProfilScreen(profil: profil),
      ),
    );

    if (result != null) {
      onProfilUpdated(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profil == null ? 'Profil erstellen' : 'Mein Profil'),
        actions: [
          if (profil != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _navigateToProfilScreen(context),
            ),
        ],
      ),
      body: profil == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Du hast noch kein Profil erstellt. Tippe auf das Plus, um loszulegen!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
          : _buildProfilDetails(context),
      floatingActionButton: profil == null
          ? FloatingActionButton(
              onPressed: () => _navigateToProfilScreen(context),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildProfilDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          if (profil!.profilTyp == 'Azubi') ...[
            _buildAzubiProfil(context),
          ] else if (profil!.profilTyp == 'Unternehmen') ...[
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
        const Chip(label: Text('Talent'), avatar: Icon(Icons.person)),
        const SizedBox(height: 16),
        _buildInfoCard('Name', '${profil!.vorname} ${profil!.name}'),
        _buildInfoCard('Wohnort', '${profil!.stadt}, ${profil!.land}'),
        _buildInfoCard('Gewerk', profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ausbildungsbetrieb', profil!.unternehmen ?? 'Nicht angegeben'),
        _buildInfoCard('Lehrjahr', '${profil!.lehrjahr}. Lehrjahr'),
        _buildInfoCard('HWK', profil!.handwerkskammer ?? 'Nicht angegeben'),
        if (profil!.faehigkeiten != null && profil!.faehigkeiten!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Fähigkeiten', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: profil!.faehigkeiten!.map((skill) => Chip(label: Text(skill))).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildUnternehmenProfil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Chip(label: Text('Unternehmen'), avatar: Icon(Icons.business)),
        const SizedBox(height: 16),
        _buildInfoCard('Name des Betriebs', profil!.betrieb ?? 'Nicht angegeben'),
        _buildInfoCard('Gewerk', profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ansprechperson', profil!.ansprechperson ?? 'Nicht angegeben'),
        _buildInfoCard('Adresse', '${profil!.strasse} ${profil!.hausnummer}, ${profil!.plz} ${profil!.stadt}, ${profil!.land}'),
        _buildInfoCard('Spezialisierung', profil!.spezialisierung ?? 'Nicht angegeben'),
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
