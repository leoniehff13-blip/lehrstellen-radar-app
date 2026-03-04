import 'package:flutter/material.dart';
import '../models/azubi.dart';

class AzubiDetailScreen extends StatelessWidget {
  final Azubi azubi;

  const AzubiDetailScreen({super.key, required this.azubi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(azubi.name),
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
                backgroundImage: NetworkImage(azubi.profilbild),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                azubi.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${azubi.beruf} - ${azubi.lehrjahr}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 8),
            Center(
                child: Text(azubi.email, style: const TextStyle(color: Colors.blueAccent)),
            ),
            const Divider(height: 32, thickness: 1),

            Text(
              'Fähigkeiten',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: azubi.faehigkeiten.map((skill) => Chip(label: Text(skill))).toList(),
            ),
            const SizedBox(height: 24),

            Text(
              'Lernziele',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...azubi.lernziele.map((goal) => ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: Colors.purple),
                  title: Text(goal),
                )),
          ],
        ),
      ),
    );
  }
}
