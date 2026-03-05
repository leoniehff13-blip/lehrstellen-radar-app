import 'package:flutter/material.dart';
import 'package:myapp/models/betrieb.dart';
import 'package:url_launcher/url_launcher.dart';

class BetriebDetailScreen extends StatelessWidget {
  final Betrieb betrieb;

  const BetriebDetailScreen({super.key, required this.betrieb});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(betrieb.name),
        backgroundColor: const Color(0xFFD6DCE5),
        titleTextStyle: const TextStyle(
          color: Color(0xFF002C59),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(betrieb.logo),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            betrieb.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(betrieb.branche,
                              style: Theme.of(context).textTheme.titleMedium),
                           const SizedBox(height: 4),
                          Text(betrieb.ort,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Über uns'),
            const SizedBox(height: 8),
            Text(betrieb.beschreibung,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Aufgabenbereiche für Azubis'),
            const SizedBox(height: 8),
            ...betrieb.aufgabenbereiche.map((task) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.check_circle_outline,
                      color: Color(0xFF002C59)),
                  title: Text(task),
                )),
            const Divider(height: 32, thickness: 1),
            _buildSectionTitle(context, 'Kontakt & Standort'),
            const SizedBox(height: 16),
            _buildContactInfo(context, Icons.person, 'Ansprechpartner',
                betrieb.ansprechpartner),
            _buildContactInfo(context, Icons.email, 'E-Mail', betrieb.email,
                isLink: true, url: 'mailto:${betrieb.email}'),
            _buildContactInfo(context, Icons.phone, 'Telefon', betrieb.telefon,
                isLink: true, url: 'tel:${betrieb.telefon}'),
            _buildContactInfo(
                context, Icons.language, 'Webseite', betrieb.webseite,
                isLink: true, url: 'https://${betrieb.webseite}'),
            _buildContactInfo(
                context, Icons.location_on, 'Adresse', betrieb.adresse),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF002C59)),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, IconData icon, String label, String value,
      {bool isLink = false, String? url}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF002C59)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          value,
          style: isLink
              ? const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline)
              : null,
        ),
        onTap: isLink && url != null
            ? () => _launchURL(url)
            : null,
      ),
    );
  }
}
