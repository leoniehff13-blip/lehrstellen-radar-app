import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/profil.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/angebote_screen.dart';
import 'screens/karten_screen.dart';
import 'screens/info_screen.dart';
import 'screens/konto_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azubi Match',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomeScreen(onProfilErstellen: (p) {
        _updateProfil(p);
        _onItemTapped(4);
      }),
      const AngeboteScreen(),
      const KartenScreen(),
      const InfoScreen(),
      KontoScreen(profil: _profil, onProfilUpdated: _updateProfil),
    ];

    return Scaffold(
      appBar: _selectedIndex == 0 || _selectedIndex == 1
          ? null
          : AppBar(
              title: const Text('Azubi Match'),
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
            label: 'Angebote',
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
        type: BottomNavigationBarType.fixed, // Ensure all items are visible
      ),
    );
  }
}
