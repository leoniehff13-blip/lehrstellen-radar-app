import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';
import 'neues_profil_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(Profil) onProfilErstellen;

  const HomeScreen({super.key, required this.onProfilErstellen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/homePage.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Azubi-Match',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withAlpha(128),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final newProfile = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NeuesProfilScreen(),
                    ),
                  );
                  if (newProfile != null) {
                    onProfilErstellen(newProfile);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Neues Profil anlegen'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
