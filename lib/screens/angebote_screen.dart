import 'package:flutter/material.dart';
import 'azubi_liste_screen.dart';
import 'betrieb_liste_screen.dart';

class AngeboteScreen extends StatelessWidget {
  const AngeboteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6DCE5), // Neue Hintergrundfarbe
          title: const Text('Angebote'),
          titleTextStyle: const TextStyle(
            color: Color(0xFF002C59), // Dunkle Textfarbe für Kontrast
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Azubis'),
              Tab(icon: Icon(Icons.business), text: 'Betriebe'),
            ],
            labelColor: Color(0xFF002C59), // Dunkle Label-Farbe
            unselectedLabelColor: Colors.black54, // Angepasste Farbe für inaktive Tabs
            indicatorColor: Color(0xFF002C59), // Indikator in dunkler Farbe
            indicatorWeight: 3.0,
          ),
        ),
        body: TabBarView(
          children: [
            AzubiListeScreen(),
            BetriebListeScreen(),
          ],
        ),
      ),
    );
  }
}
