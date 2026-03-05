import 'package:flutter/material.dart';

class NeuerBetriebScreen extends StatelessWidget {
  const NeuerBetriebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neuer Betrieb'),
        backgroundColor: const Color(0xFFD6DCE5),
        titleTextStyle: const TextStyle(
          color: Color(0xFF002C59),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const Center(
        child: Text('Hier kommt das Formular für einen neuen Betrieb.'),
      ),
    );
  }
}
