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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('Angebote'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Azubis'),
              Tab(icon: Icon(Icons.business), text: 'Betriebe'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
