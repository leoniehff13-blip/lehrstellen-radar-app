import 'package:flutter/material.dart';
import '../models/profil.dart';

class TalentDetailScreen extends StatelessWidget {
  final Profil talent;

  const TalentDetailScreen({super.key, required this.talent});

  @override
  Widget build(BuildContext context) {
    // Placeholder for profile image, as it's not in the Profil model yet
    const profilbildPlaceholder =
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop';

    return Scaffold(
      appBar: AppBar(
        title: Text(talent.vorname ?? 'Talent'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF002C59), Color(0xFF3B5998)],
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
                backgroundImage: const NetworkImage(profilbildPlaceholder),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${talent.vorname ?? ''} ${talent.name ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${talent.gewerk ?? 'N/A'} - ${talent.lehrjahr ?? 0}. Lehrjahr',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
            if (talent.unternehmen != null && talent.unternehmen!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    'Bei: ${talent.unternehmen}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            const Divider(height: 32, thickness: 1),
            Text(
              'Fähigkeiten & Lernziele',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (talent.faehigkeiten != null)
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: talent.faehigkeiten!
                    .map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: const Color(0xFFD6DCE5),
                          labelStyle: const TextStyle(color: Color(0xFF002C59)),
                        ))
                    .toList(),
              ),
            if (talent.faehigkeiten == null || talent.faehigkeiten!.isEmpty)
              const Text(
                  'Keine spezifischen Fähigkeiten oder Lernziele angegeben.'),
          ],
        ),
      ),
    );
  }
}
