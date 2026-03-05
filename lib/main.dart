import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/betrieb.dart';
import 'package:myapp/models/profil.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/talentleihe_screen.dart';
import 'screens/karten_screen.dart';
import 'screens/info_screen.dart';
import 'screens/konto_screen.dart';
import 'screens/neue_talentleihe_screen.dart';
import 'screens/neuer_praxiseinsatz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talentleihe',
      theme: ThemeData(
        primaryColor: const Color(0xFF002C59),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF002C59),
          secondary: const Color(0xFFD6DCE5),
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Profil? _profil;
  final List<Profil> _ausgelieheneTalente = [];
  final List<Profil> _meineAngebote = [];
  TabController? _tabController;
  late final List<Widget> _widgetOptions;

  final Betrieb _loggedInBetrieb = Betrieb(
      name: 'Trieschmann AG',
      branche: 'Elektriker',
      ort: 'Bielefeld',
      logo:
          'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=100&auto=format&fit=crop',
      beschreibung:
          'Wir verlegen den Strom von morgen. Werde Teil unseres agilen Teams und gestalte die digitale Zukunft mit.',
      aufgabenbereiche: [
        'Schaltschrankverkabelung',
        'SPS-Programmierung',
        'Fehlerdiagnose unter Spannung'
      ],
      webseite: 'www.kreativ-ag.de',
      adresse: 'Schillerstraße 68, 33609 Bielefeld',
      ansprechpartner: 'Herr Trieschmann ',
      email: 'karriere@kreativ-ag.de',
      telefon: '+49 30 1122334',
      handwerkskammerId: 'bielefeld');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     _tabController!.addListener(() {
      // This is to ensure the FAB updates when the tab changes
      if (mounted) {
        setState(() {});
      }
    });

    _widgetOptions = <Widget>[
      const HomeScreen(),
      TalentleiheScreen(
        tabController: _tabController!,
        ausgelieheneTalente: _ausgelieheneTalente,
        // The key is removed, as it's not the correct approach
      ),
      const KartenScreen(),
      const InfoScreen(),
      KontoScreen(
        profil: _profil, 
        onProfilUpdated: _updateProfil,
        onProfilDeleted: _deleteProfil,
        meineAngebote: _meineAngebote,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateProfil(Profil profil) {
    setState(() {
      _profil = profil;
      _selectedIndex = 4; // Navigate to Konto screen
    });
  }

  void _deleteProfil() {
    setState(() {
      _profil = null;
      _meineAngebote.clear(); // Also clear the offers when profile is deleted
    });
  }

  // This function is no longer needed here
  // void _showBetriebFilter() {
  //   _betriebListeKey.currentState?.showFilterDialog();
  // }

  void _handleNewTalentOffer() async {
    if (_profil != null) {
      final neuesAngebot = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NeueTalentleiheScreen(userProfile: _profil),
        ),
      );

      if (!mounted) return;

      if (neuesAngebot != null && neuesAngebot is Profil) {
        setState(() {
          _ausgelieheneTalente.add(neuesAngebot);
          _meineAngebote.add(neuesAngebot);
        });
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Neues Talent-Angebot wurde erstellt!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte zuerst ein Profil anlegen.')),
      );
      setState(() {
        _selectedIndex = 4; // Redirect to account screen
      });
    }
  }

  void _handleNewPraxiseinsatz() async {
      final neuerEinsatz = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NeuerPraxiseinsatzScreen(
          betriebProfile: _loggedInBetrieb,
        ),
      ),
    );

    if (!mounted) return;

    if (neuerEinsatz != null && neuerEinsatz is Betrieb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Neuer Praxiseinsatz wurde erstellt!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 1 ? AppBar(
        title: const Text('Talentleihe'),
         backgroundColor: const Color(0xFFD6DCE5),
        titleTextStyle: const TextStyle(
          color: Color(0xFF002C59),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ) : null,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Talentleihe',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Karte'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Infos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Konto',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      // The FloatingActionButton logic is now managed by the individual screens
      // in the TabBarView (TalentListeScreen and BetriebListeScreen).
      // This central FAB is only for the add action.
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                if (_tabController?.index == 0) {
                  _handleNewTalentOffer();
                } else if (_tabController?.index == 1) {
                  _handleNewPraxiseinsatz();
                }
              },
              heroTag: 'add',
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
