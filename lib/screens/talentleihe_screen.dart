import 'package:flutter/material.dart';
import 'package:myapp/models/betrieb.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/screens/betrieb_liste_screen.dart';
import 'package:myapp/screens/talent_liste_screen.dart';

class TalentleiheScreen extends StatelessWidget {
  final TabController tabController;
  final List<Profil> ausgelieheneTalente;
  final List<Betrieb> praxiseinsaetze;
  final Function(Profil) onAnfrage;
  final Profil? profil;

  const TalentleiheScreen({
    super.key,
    required this.tabController,
    required this.ausgelieheneTalente,
    required this.praxiseinsaetze,
    required this.onAnfrage,
    required this.profil,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD6DCE5),
        title: const Text('Talentleihe'),
        titleTextStyle: const TextStyle(
          color: Color(0xFF002C59),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Talente'),
            Tab(icon: Icon(Icons.business), text: 'Betriebe'),
          ],
          labelColor: const Color(0xFF002C59),
          unselectedLabelColor: Colors.black54,
          indicatorColor: const Color(0xFF002C59),
          indicatorWeight: 3.0,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TalentListeScreen(
            talente: ausgelieheneTalente,
            onAnfrage: onAnfrage, // Pass the function
            profil: profil, // Pass the profile
          ),
          BetriebListeScreen(betriebe: praxiseinsaetze),
        ],
      ),
    );
  }
}
