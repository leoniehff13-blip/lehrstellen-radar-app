import 'package:flutter/material.dart';
import '../models/talent.dart';

class TalentDetailScreen extends StatelessWidget {
  final Talent talent;

  const TalentDetailScreen({super.key, required this.talent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(talent.name),
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
                backgroundImage: NetworkImage(talent.profilbild),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                talent.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${talent.beruf} - ${talent.lehrjahr}. Lehrjahr',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 8),
            Center(
                child: Text(talent.email, style: const TextStyle(color: Colors.blueAccent)),
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
              children: talent.faehigkeiten.map((skill) => Chip(label: Text(skill))).toList(),
            ),
            const SizedBox(height: 24),

            Text(
              'Lernziele',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...talent.lernziele.map((goal) => ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: Colors.purple),
                  title: Text(goal),
                )),
          ],
        ),
      ),
    );
  }
}
