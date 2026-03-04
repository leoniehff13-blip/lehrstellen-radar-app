import 'package:flutter/material.dart';
import '../models/betrieb.dart';
import 'betrieb_detail_screen.dart';

class BetriebListeScreen extends StatelessWidget {
  BetriebListeScreen({super.key});

  final List<Betrieb> betriebAngebote = [
    Betrieb(
        name: 'Muster GmbH & Co. KG',
        branche: 'Maschinenbau',
        ort: 'Stuttgart',
        logo:
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Wir sind ein führender Hersteller von Spezialmaschinen und bieten eine erstklassige Ausbildung in einem innovativen Umfeld.',
        aufgabenbereiche: [
          'Montage von Baugruppen',
          'Wartung und Instandhaltung',
          'Qualitätssicherung'
        ],
        webseite: 'www.muster-gmbh.de',
        adresse: 'Mercedesstraße 137, 70327 Stuttgart',
        ansprechpartner: 'Frau Dr. Schneider',
        email: 'bewerbung@muster-gmbh.de',
        telefon: '+49 711 123456'),
    Betrieb(
        name: 'Holzbau Schmidt',
        branche: 'Handwerk & Bau',
        ort: 'Freiburg',
        logo:
            'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Traditionelles Handwerk trifft auf moderne Technik. Bei uns lernst du den Umgang mit dem Werkstoff Holz von Grund auf.',
        aufgabenbereiche: [
          'Herstellung von Möbeln',
          'Innenausbau',
          'Montage vor Ort'
        ],
        webseite: 'www.holzbau-schmidt.de',
        adresse: 'Hans-Bunte-Straße 8, 79108 Freiburg',
        ansprechpartner: 'Herr Meier',
        email: 'info@holzbau-schmidt.de',
        telefon: '+49 761 987654'),
    Betrieb(
        name: 'Kreativ-Software AG',
        branche: 'IT & Softwareentwicklung',
        ort: 'Berlin',
        logo:
            'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Wir entwickeln die Apps von morgen. Werde Teil unseres agilen Teams und gestalte die digitale Zukunft mit.',
        aufgabenbereiche: [
          'App-Entwicklung mit Flutter',
          'Backend-Anbindung mit Firebase',
          'UI/UX-Design'
        ],
        webseite: 'www.kreativ-ag.de',
        adresse: 'Friedrichstraße 100, 10117 Berlin',
        ansprechpartner: 'Herr Schulze',
        email: 'karriere@kreativ-ag.de',
        telefon: '+49 30 1122334'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: betriebAngebote.length,
      itemBuilder: (context, index) {
        final betrieb = betriebAngebote[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(betrieb.logo),
              backgroundColor: Colors.grey[200],
            ),
            title: Text(betrieb.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${betrieb.branche}\n${betrieb.ort}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BetriebDetailScreen(betrieb: betrieb),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
