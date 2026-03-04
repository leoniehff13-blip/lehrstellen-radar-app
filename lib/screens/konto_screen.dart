import 'package:flutter/material.dart';
import 'package:myapp/models/profil.dart';

class KontoScreen extends StatelessWidget {
  final Profil? profil;

  const KontoScreen({super.key, this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Konto'),
      ),
      body: profil == null
          ? const Center(
              child: Text('Noch kein Profil erstellt.'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Text('Name: ${profil!.name}'),
                  Text('Vorname: ${profil!.vorname}'),
                  Text('Betrieb: ${profil!.betrieb}'),
                  Text('Straße: ${profil!.strasse}'),
                  Text('Hausnummer: ${profil!.hausnummer}'),
                  Text('PLZ: ${profil!.plz}'),
                  Text('Stadt: ${profil!.stadt}'),
                  Text('Land: ${profil!.land ?? 'Nicht angegeben'}'),
                  Text('Gewerk: ${profil!.gewerk ?? 'Nicht angegeben'}'),
                ],
              ),
            ),
    );
  }
}
