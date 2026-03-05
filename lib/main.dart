import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/profil.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/talentleihe_screen.dart';
import 'screens/karten_screen.dart';
import 'screens/info_screen.dart';
import 'screens/konto_screen.dart';
import 'screens/neue_talentleihe_screen.dart';
import 'screens/neuer_betrieb_screen.dart';

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

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Profil? _profil;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateProfil(Profil profil) {
    setState(() {
      _profil = profil;
      // After updating profile, navigate to the Konto screen to show it
      _selectedIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the list of widgets directly in the build method
    // This ensures they are rebuilt with the latest state (_profil)
    // when setState is called.
    final List<Widget> widgetOptions = <Widget>[
      const HomeScreen(), // No longer needs the callback
      TalentleiheScreen(
        onNavigateToNewOffer: (isBetrieb) {
          if (isBetrieb) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NeuerBetriebScreen(),
              ),
            );
          } else {
            // The closure captures the current _profil value
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    NeueTalentleiheScreen(userProfile: _profil),
              ),
            );
          }
        },
      ),
      const KartenScreen(),
      const InfoScreen(),
      // Pass the current profile and the update callback to KontoScreen
      KontoScreen(profil: _profil, onProfilUpdated: _updateProfil),
    ];

    return Scaffold(
      appBar: _selectedIndex == 0 || _selectedIndex == 1
          ? null
          : AppBar(
              title: const Text('Talentleihe'),
              backgroundColor: Theme.of(context).primaryColor,
              titleTextStyle: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      body: Center(child: widgetOptions.elementAt(_selectedIndex)),
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
    );
  }
}
