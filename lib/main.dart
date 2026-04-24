import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/anfrage.dart';
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
      title: 'Win / Win',
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

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Profil? _profil;
  final List<Profil> _ausgelieheneTalente = [];
  final List<Profil> _meineAngebote = [];
  final List<Betrieb> _praxiseinsaetze = [];
  final List<Betrieb> _meinePraxiseinsaetze = [];
  final List<Anfrage> _anfragen = [];

  TabController? _tabController;

  static Betrieb? _loggedInBetrieb = null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
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
      if (profil.profilTyp == 'Unternehmen') {
        _loggedInBetrieb = Betrieb(
          name: profil.betrieb ?? '',
          branche: profil.gewerk ?? '',
          ort: profil.stadt ?? '',
          logo: profil.profilbild ?? '',
          beschreibung: profil.spezialisierung ?? '',
          aufgabenbereiche: [],
          webseite: '',
          adresse:
              '${profil.strasse} ${profil.hausnummer}, ${profil.plz} ${profil.stadt}',
          ansprechpartner: profil.ansprechperson ?? '',
          email: '',
          telefon: '',
          handwerkskammerId: profil.handwerkskammer ?? '',
        );
      } else {
        _loggedInBetrieb = null;
      }
      _selectedIndex = 4;
    });
  }

  void _deleteProfil() {
    setState(() {
      _profil = null;
      _loggedInBetrieb = null;
      _meineAngebote.clear();
      _meinePraxiseinsaetze.clear();
    });
  }

  void _handleAnfrage(Profil angefragtesTalent) {
    if (_profil != null && _profil!.profilTyp == 'Unternehmen') {
      setState(() {
        _anfragen.add(Anfrage(
          anfragenderBetrieb: _profil!,
          angefragtesTalent: angefragtesTalent,
          anfrageDatum: DateTime.now(),
        ));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anfrage wurde erfolgreich gesendet!')),
      );
    } else {
      // Optional: Handle case where user is not a company
    }
  }

  void _handleNewTalentOffer() async {
    if (_profil?.profilTyp == 'Unternehmen') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Funktion nicht verfügbar'),
            content: const Text(
                'Als Unternehmen können Sie keine Talentleihe erstellen. Diese Funktion ist für Azubis und Talente vorgesehen, um ihre Fähigkeiten anzubieten.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Verstanden'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Profil erforderlich'),
            content: const Text(
                'Bitte erstellen Sie zuerst ein Profil, um eine Talentleihe anzubieten.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                child: const Text('Zum Profil'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _onItemTapped(4);
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _handleNewPraxiseinsatz() async {
    if (_loggedInBetrieb == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Profil erforderlich'),
            content: const Text(
                'Bitte erstellen Sie zuerst ein Firmenprofil, um einen Praxiseinsatz anbieten zu können.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                child: const Text('Zum Profil'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _onItemTapped(4);
                },
              ),
            ],
          );
        },
      );
    } else {
      final neuerEinsatz = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NeuerPraxiseinsatzScreen(
            betriebProfile: _loggedInBetrieb,
          ),
        ),
      );

      if (!mounted) return;

      if (neuerEinsatz != null && neuerEinsatz is Betrieb) {
        setState(() {
          _praxiseinsaetze.add(neuerEinsatz);
          _meinePraxiseinsaetze.add(neuerEinsatz);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Neuer Praxiseinsatz wurde erstellt!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const HomeScreen(),
      TalentleiheScreen(
        tabController: _tabController!,
        ausgelieheneTalente: _ausgelieheneTalente,
        praxiseinsaetze: _praxiseinsaetze,
        onAnfrage: _handleAnfrage,
        profil: _profil,
      ),
      const KartenScreen(),
      const InfoScreen(),
      KontoScreen(
        profil: _profil,
        onProfilUpdated: _updateProfil,
        onProfilDeleted: _deleteProfil,
        meineAngebote: _meineAngebote,
        meinePraxiseinsaetze: _meinePraxiseinsaetze,
        meineAnfragen: _anfragen
            .where((a) => a.angefragtesTalent.name == _profil?.name)
            .toList(),
      ),
    ];

    return Scaffold(
      appBar: _selectedIndex != 1
          ? AppBar(
              title: const Text('Talentleihe'),
              backgroundColor: const Color(0xFFD6DCE5),
              titleTextStyle: const TextStyle(
                color: Color(0xFF002C59),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
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
