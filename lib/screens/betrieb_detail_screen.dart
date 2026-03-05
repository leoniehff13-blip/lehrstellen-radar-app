import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/betrieb.dart';

class BetriebDetailScreen extends StatelessWidget {
  final Betrieb betrieb;

  const BetriebDetailScreen({super.key, required this.betrieb});

  String _getGoogleMapsUrl(String address) {
    final encodedAddress = Uri.encodeComponent(address);
    return 'https://www.google.com/maps/embed/v1/place?key=NO_API_KEY&q=$encodedAddress';
  }

  @override
  Widget build(BuildContext context) {
    final webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_getGoogleMapsUrl(betrieb.adresse)));

    return Scaffold(
      appBar: AppBar(
        title: Text(betrieb.name),
        backgroundColor: const Color(0xFF002C59),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(betrieb.logo),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      betrieb.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${betrieb.branche} - ${betrieb.ort}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
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
            const SizedBox(height: 16),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: WebViewWidget(controller: webviewController),
              ),
            ),
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
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, IconData icon, String label, String value,
      {bool isLink = false, String? url}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
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
            ? () {
                // Hier könnte man eine URL-Launcher-Funktion einfügen
              }
            : null,
      ),
    );
  }
}
