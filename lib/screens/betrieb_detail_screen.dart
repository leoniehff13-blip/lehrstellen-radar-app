import 'package:flutter/material.dart';
import 'package:myapp/models/betrieb.dart';

class BetriebDetailScreen extends StatelessWidget {
  final Betrieb betrieb;

  const BetriebDetailScreen({super.key, required this.betrieb});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(betrieb.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(betrieb.logo),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          betrieb.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(betrieb.branche),
                        Text(betrieb.ort),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Beschreibung',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(betrieb.beschreibung),
              const SizedBox(height: 16),
              Text(
                'Aufgabenbereiche',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              for (var aufgabe in betrieb.aufgabenbereiche)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('- $aufgabe'),
                ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
               Text(
                'Kontakt',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(betrieb.ansprechpartner),
                subtitle: const Text('Ansprechpartner'),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(betrieb.email),
                subtitle: const Text('E-Mail'),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(betrieb.telefon),
                subtitle: const Text('Telefon'),
              ),
              ListTile(
                leading: const Icon(Icons.web),
                title: Text(betrieb.webseite),
                 subtitle: const Text('Webseite'),
              ),
               ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(betrieb.adresse),
                subtitle: const Text('Adresse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
