import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/screens/neues_profil_screen.dart';

class KontoScreen extends StatefulWidget {
  final Profil? profil;
  final Function(Profil) onProfilUpdated;
  final Function() onProfilDeleted;
  final List<Profil> meineAngebote;

  const KontoScreen({
    super.key,
    this.profil,
    required this.onProfilUpdated,
    required this.onProfilDeleted,
    required this.meineAngebote,
  });

  @override
  State<KontoScreen> createState() => _KontoScreenState();
}

class _KontoScreenState extends State<KontoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _navigateToProfilScreen(BuildContext context) async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (context) => NeuesProfilScreen(profil: widget.profil),
      ),
    );

    if (result != null) {
      if (result is Profil) {
        widget.onProfilUpdated(result);
      } else if (result == 'delete') {
        widget.onProfilDeleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profil == null ? 'Konto' : 'Mein Konto'),
        backgroundColor: const Color(0xFFD6DCE5),
        titleTextStyle: const TextStyle(
                color: Color(0xFF002C59),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        bottom: widget.profil == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Mein Profil'),
                  Tab(text: 'Meine Angebote'),
                ],
              ),
      ),
      body: widget.profil == null
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
          : TabBarView(
              controller: _tabController,
              children: [
                _buildProfilDetails(context),
                _buildAngeboteView(context),
              ],
            ),
      floatingActionButton: widget.profil == null
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
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.profil?.profilbild != null && widget.profil!.profilbild!.isNotEmpty
                      ? FileImage(File(widget.profil!.profilbild!))
                      : null,
                  child: widget.profil?.profilbild == null || widget.profil!.profilbild!.isEmpty
                      ? Icon(
                          widget.profil?.profilTyp == 'Azubi' ? Icons.person : Icons.business,
                          size: 50,
                        )
                      : null,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (widget.profil!.profilTyp == 'Azubi' || widget.profil!.profilTyp == 'Talent') ...[
            _buildAzubiProfil(context),
          ] else if (widget.profil!.profilTyp == 'Unternehmen') ...[
            _buildUnternehmenProfil(context),
          ]
        ],
      ),
    );
  }

  Widget _buildAngeboteView(BuildContext context) {
    if (widget.meineAngebote.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Du hast noch keine Angebote erstellt.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.meineAngebote.length,
      itemBuilder: (context, index) {
        final angebot = widget.meineAngebote[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: angebot.profilbild != null && angebot.profilbild!.isNotEmpty
                  ? FileImage(File(angebot.profilbild!))
                  : null,
              child: angebot.profilbild == null || angebot.profilbild!.isEmpty
                  ? Icon(angebot.profilTyp == 'Azubi' ? Icons.person : Icons.business)
                  : null,
            ),
            title: Text('${angebot.vorname} ${angebot.name}'),
            subtitle: Text(angebot.gewerk ?? 'Kein Gewerk angegeben'),
            trailing: Text('${angebot.lehrjahr}. Lehrjahr'),
          ),
        );
      },
    );
  }

  Widget _buildAzubiProfil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.profil!.profilTyp == 'Talent' ? 'Talent' : 'Azubi', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF002C59)),
              onPressed: () => _navigateToProfilScreen(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoCard('Name', '${widget.profil!.vorname} ${widget.profil!.name}'),
        _buildInfoCard('Wohnort', '${widget.profil!.stadt}, ${widget.profil!.land}'),
        _buildInfoCard('Gewerk', widget.profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ausbildungsbetrieb', widget.profil!.unternehmen ?? 'Nicht angegeben'),
        _buildInfoCard('Lehrjahr', '${widget.profil!.lehrjahr}. Lehrjahr'),
        _buildInfoCard('HWK', widget.profil!.handwerkskammer ?? 'Nicht angegeben'),
        if (widget.profil!.faehigkeiten != null && widget.profil!.faehigkeiten!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Fähigkeiten', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: widget.profil!.faehigkeiten!.map((skill) => Chip(label: Text(skill))).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildUnternehmenProfil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Unternehmen', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF002C59)),
              onPressed: () => _navigateToProfilScreen(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoCard('Name des Betriebs', widget.profil!.betrieb ?? 'Nicht angegeben'),
        _buildInfoCard('Gewerk', widget.profil!.gewerk ?? 'Nicht angegeben'),
        _buildInfoCard('Ansprechperson', widget.profil!.ansprechperson ?? 'Nicht angegeben'),
        _buildInfoCard('Adresse', '${widget.profil!.strasse} ${widget.profil!.hausnummer}, ${widget.profil!.plz} ${widget.profil!.stadt}, ${widget.profil!.land}'),
        _buildInfoCard('Handwerkskammer', widget.profil!.handwerkskammer ?? 'Nicht angegeben'),
        _buildInfoCard('Spezialisierung', (widget.profil!.spezialisierung != null && widget.profil!.spezialisierung!.isNotEmpty) ? widget.profil!.spezialisierung! : 'Nicht angegeben'),
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
