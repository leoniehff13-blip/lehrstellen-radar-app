import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'package:myapp/screens/betrieb_liste_screen.dart';
import 'package:myapp/screens/talent_liste_screen.dart';

class TalentleiheScreen extends StatefulWidget {
  final Function(bool) onNavigateToNewOffer;
  final List<Profil> ausgelieheneTalente;

  const TalentleiheScreen({
    super.key,
    required this.onNavigateToNewOffer,
    required this.ausgelieheneTalente,
  });

  @override
  TalentleiheScreenState createState() => TalentleiheScreenState();
}

class TalentleiheScreenState extends State<TalentleiheScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.business), text: 'Betriebe'),
            Tab(icon: Icon(Icons.person), text: 'Talente'),
          ],
          labelColor: const Color(0xFF002C59),
          unselectedLabelColor: Colors.black54,
          indicatorColor: const Color(0xFF002C59),
          indicatorWeight: 3.0,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const BetriebListeScreen(),
          TalentListeScreen(talente: widget.ausgelieheneTalente),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onNavigateToNewOffer(_tabController.index == 0),
        backgroundColor: const Color(0xFF002C59),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
