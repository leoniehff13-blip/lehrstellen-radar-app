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
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Angebote'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Azubis'),
              Tab(text: 'Betriebe'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            AzubiListeScreen(),
            BetriebListeScreen(),
          ],
        ),
      ),
    );
  }
}
