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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(betrieb.logo),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                betrieb.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${betrieb.branche} - ${betrieb.ort}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(betrieb.webseite, style: const TextStyle(color: Colors.blueAccent)),
            ),
            const Divider(height: 32, thickness: 1),

            Text(
              'Über uns',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(betrieb.beschreibung, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),

            Text(
              'Aufgabenbereiche für Azubis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...betrieb.aufgabenbereiche.map((task) => ListTile(
                  leading: const Icon(Icons.build_circle_outlined, color: Colors.purple),
                  title: Text(task),
                )),

            const Divider(height: 32, thickness: 1),

            Text(
              'Standort',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.purple),
              title: Text(betrieb.adresse),
            ),
            const SizedBox(height: 16),

            Container(
              height: 300, // Feste Höhe für die Karte
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
}
