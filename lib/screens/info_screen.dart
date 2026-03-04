import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Zentralverband des Deutschen Handwerks (ZDH)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Der ZDH ist die Spitzenorganisation des Handwerks in Deutschland. Er vertritt die Interessen von rund 1 Million Handwerksbetrieben mit über 5,6 Millionen Beschäftigten.',
        ),
        const Divider(height: 32.0),
        Text(
          'Handwerkskammern',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8.0),
        const Text(
          'In Deutschland gibt es 53 Handwerkskammern. Sie sind die regionalen Selbstverwaltungseinrichtungen des Handwerks und vertreten die Interessen ihrer Mitgliedsbetriebe.',
        ),
        const SizedBox(height: 16.0),
        _buildKammerInfo(
          context,
          'Handwerkskammer für München und Oberbayern',
          'Max-Joseph-Straße 4, 80333 München',
        ),
        _buildKammerInfo(
          context,
          'Handwerkskammer Berlin',
          'Blücherstraße 68, 10961 Berlin',
        ),
        _buildKammerInfo(
          context,
          'Handwerkskammer Hamburg',
          'Holstenwall 12, 20355 Hamburg',
        ),
      ],
    );
  }

  Widget _buildKammerInfo(BuildContext context, String name, String address) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4.0),
            Text(address),
          ],
        ),
      ),
    );
  }
}
