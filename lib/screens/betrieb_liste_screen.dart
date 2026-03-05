import 'package:flutter/material.dart';
import '../models/betrieb.dart';
import '../models/handwerkskammer.dart';
import 'betrieb_detail_screen.dart';

class BetriebListeScreen extends StatefulWidget {
  const BetriebListeScreen({super.key});

  @override
  State<BetriebListeScreen> createState() => _BetriebListeScreenState();
}

class _BetriebListeScreenState extends State<BetriebListeScreen> {
  // Using the full list of chambers for consistency
  final List<Handwerkskammer> _handwerkskammern = [
    Handwerkskammer(id: 'aachen', name: 'HWK Aachen', region: 'Aachen'),
    Handwerkskammer(id: 'schwaben', name: 'HWK für Schwaben', region: 'Augsburg'),
    Handwerkskammer(id: 'oberfranken', name: 'HWK für Oberfranken', region: 'Bayreuth'),
    Handwerkskammer(id: 'berlin', name: 'HWK Berlin', region: 'Berlin'),
    Handwerkskammer(id: 'bielefeld', name: 'HWK Ostwestfalen-Lippe zu Bielefeld', region: 'Bielefeld'),
    Handwerkskammer(id: 'braunschweig_lueneburg_stade', name: 'HWK Braunschweig-Lüneburg-Stade', region: 'Braunschweig'),
    Handwerkskammer(id: 'bremen', name: 'HWK Bremen', region: 'Bremen'),
    Handwerkskammer(id: 'chemnitz', name: 'HWK Chemnitz', region: 'Chemnitz'),
    Handwerkskammer(id: 'cottbus', name: 'HWK Cottbus', region: 'Cottbus'),
    Handwerkskammer(id: 'dortmund', name: 'HWK Dortmund', region: 'Dortmund'),
    Handwerkskammer(id: 'dresden', name: 'HWK Dresden', region: 'Dresden'),
    Handwerkskammer(id: 'duesseldorf', name: 'HWK Düsseldorf', region: 'Düsseldorf'),
    Handwerkskammer(id: 'erfurt', name: 'HWK Erfurt', region: 'Erfurt'),
    Handwerkskammer(id: 'flensburg', name: 'HWK Flensburg', region: 'Flensburg'),
    Handwerkskammer(id: 'frankfurt_oder', name: 'HWK Frankfurt (Oder) - Region Ostbrandenburg', region: 'Frankfurt (Oder)'),
    Handwerkskammer(id: 'frankfurt_rhein_main', name: 'HWK Frankfurt-Rhein-Main', region: 'Frankfurt am Main'),
    Handwerkskammer(id: 'freiburg', name: 'HWK Freiburg', region: 'Freiburg'),
    Handwerkskammer(id: 'mittelfranken', name: 'HWK für Mittelfranken', region: 'Nürnberg'),
    Handwerkskammer(id: 'muenchen_oberbayern', name: 'HWK für München und Oberbayern', region: 'München'),
    Handwerkskammer(id: 'niederbayern_oberpfalz', name: 'HWK Niederbayern-Oberpfalz', region: 'Passau'),
    Handwerkskammer(id: 'unterfranken', name: 'HWK für Unterfranken', region: 'Würzburg'),
    Handwerkskammer(id: 'halle', name: 'HWK Halle (Saale)', region: 'Halle (Saale)'),
    Handwerkskammer(id: 'hamburg', name: 'HWK Hamburg', region: 'Hamburg'),
    Handwerkskammer(id: 'hannover', name: 'HWK Hannover', region: 'Hannover'),
    Handwerkskammer(id: 'heilbronn_franken', name: 'HWK Heilbronn-Franken', region: 'Heilbronn'),
    Handwerkskammer(id: 'hildesheim_suedniedersachsen', name: 'HWK Hildesheim-Südniedersachsen', region: 'Hildesheim'),
    Handwerkskammer(id: 'karlsruhe', name: 'HWK Karlsruhe', region: 'Karlsruhe'),
    Handwerkskammer(id: 'kassel', name: 'HWK Kassel', region: 'Kassel'),
    Handwerkskammer(id: 'koblenz', name: 'HWK Koblenz', region: 'Koblenz'),
    Handwerkskammer(id: 'koeln', name: 'HWK zu Köln', region: 'Köln'),
    Handwerkskammer(id: 'konstanz', name: 'HWK Konstanz', region: 'Konstanz'),
    Handwerkskammer(id: 'leipzig', name: 'HWK zu Leipzig', region: 'Leipzig'),
    Handwerkskammer(id: 'luebeck', name: 'HWK Lübeck', region: 'Lübeck'),
    Handwerkskammer(id: 'magdeburg', name: 'HWK Magdeburg', region: 'Magdeburg'),
    Handwerkskammer(id: 'mannheim', name: 'HWK Mannheim Rhein-Neckar-Odenwald', region: 'Mannheim'),
    Handwerkskammer(id: 'muenster', name: 'HWK Münster', region: 'Münster'),
    Handwerkskammer(id: 'oldenburg', name: 'HWK Oldenburg', region: 'Oldenburg'),
    Handwerkskammer(id: 'osnabrueck_emsland', name: 'HWK Osnabrück-Emsland-Grafschaft Bentheim', region: 'Osnabrück'),
    Handwerkskammer(id: 'ostfriesland', name: 'HWK für Ostfriesland', region: 'Aurich'),
    Handwerkskammer(id: 'ostthueringen', name: 'HWK für Ostthüringen', region: 'Gera'),
    Handwerkskammer(id: 'pfalz', name: 'HWK der Pfalz', region: 'Kaiserslautern'),
    Handwerkskammer(id: 'potsdam', name: 'HWK Potsdam', region: 'Potsdam'),
    Handwerkskammer(id: 'reutlingen', name: 'HWK Reutlingen', region: 'Reutlingen'),
    Handwerkskammer(id: 'rheinhessen', name: 'HWK Rheinhessen', region: 'Mainz'),
    Handwerkskammer(id: 'rostock', name: 'HWK Ostmecklenburg-Vorpommern', region: 'Rostock'),
    Handwerkskammer(id: 'saarland', name: 'HWK des Saarlandes', region: 'Saarbrücken'),
    Handwerkskammer(id: 'schwerin', name: 'HWK Schwerin', region: 'Schwerin'),
    Handwerkskammer(id: 'stuttgart', name: 'HWK Region Stuttgart', region: 'Stuttgart'),
    Handwerkskammer(id: 'suedthueringen', name: 'HWK Südthüringen', region: 'Suhl'),
    Handwerkskammer(id: 'suedwestfalen', name: 'HWK Südwestfalen', region: 'Arnsberg'),
    Handwerkskammer(id: 'trier', name: 'HWK Trier', region: 'Trier'),
    Handwerkskammer(id: 'ulm', name: 'HWK Ulm', region: 'Ulm'),
    Handwerkskammer(id: 'wiesbaden', name: 'HWK Wiesbaden', region: 'Wiesbaden'),
  ];

  final List<Betrieb> _allBetriebe = [
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
        telefon: '+49 711 123456',
        handwerkskammerId: 'stuttgart'),
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
        telefon: '+49 761 987654',
        handwerkskammerId: 'freiburg'),
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
        telefon: '+49 30 1122334',
        handwerkskammerId: 'berlin'),
    Betrieb(
        name: 'Bäckerei Knete Kross',
        branche: 'Lebensmittelhandwerk',
        ort: 'Köln',
        logo:
            'https://images.unsplash.com/photo-1598373182133-52452f7691ef?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Frische Backwaren mit Tradition und Leidenschaft. Lerne das Bäckerhandwerk in einem Familienbetrieb.',
        aufgabenbereiche: [
          'Teigherstellung',
          'Backen von Brot und Brötchen',
          'Kundenberatung'
        ],
        webseite: 'www.knete-kross.de',
        adresse: 'Musterstraße 1, 50667 Köln',
        ansprechpartner: 'Herr Kross',
        email: 'info@knete-kross.de',
        telefon: '+49 221 555667',
        handwerkskammerId: 'koeln'),
     Betrieb(
        name: 'Innovatec GmbH',
        branche: 'IT & Hardware',
        ort: 'München',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Hardware-Lösungen für die Industrie.',
        aufgabenbereiche: ['Systemintegration', 'Netzwerktechnik'],
        webseite: 'www.example.com',
        adresse: 'Balanstraße 73, 81541 München, Deutschland',
        ansprechpartner: 'Frau Huber',
        email: 'jobs@example.com',
        telefon: '+49 89 123456',
        handwerkskammerId: 'muenchen_oberbayern'),
    Betrieb(
        name: 'Hafen-Logistik AG',
        branche: 'Logistik',
        ort: 'Hamburg',
        logo:'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Ihr Partner für weltweite Logistik.',
        aufgabenbereiche: ['Spedition', 'Lagerlogistik'],
        webseite: 'www.example.com',
        adresse: 'Bei St. Annen 1, 20457 Hamburg, Deutschland',
        ansprechpartner: 'Herr Jansen',
        email: 'contact@example.com',
        telefon: '+49 40 987654',
        handwerkskammerId: 'hamburg'),
    Betrieb(
        name: 'HSBA',
        branche: 'Bildung',
        ort: 'Hamburg',
        logo:
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Die Business School in Hamburg. Wir bieten duale Studiengänge und Weiterbildungen an.',
        aufgabenbereiche: ['Duales Studium BWL', 'Master in Global Management'],
        webseite: 'www.hsba.de',
        adresse: 'Willy-Brandt-Straße 75, 20459 Hamburg, Deutschland',
        ansprechpartner: 'Studienberatung',
        email: 'info@hsba.de',
        telefon: '+49 40 361380',
        handwerkskammerId: 'hamburg'),
  ];

  String? _selectedKammerId;
  List<Betrieb> _filteredBetriebe = [];

  @override
  void initState() {
    super.initState();
    _filteredBetriebe = _allBetriebe;
  }

  void _filterBetriebe() {
    setState(() {
      if (_selectedKammerId == null) {
        _filteredBetriebe = _allBetriebe;
      } else {
        _filteredBetriebe = _allBetriebe
            .where((b) => b.handwerkskammerId == _selectedKammerId)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterDropdown(),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredBetriebe.length,
            itemBuilder: (context, index) {
              final betrieb = _filteredBetriebe[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(betrieb.logo),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(betrieb.name, style: const TextStyle(fontWeight: FontWeight.bold)),
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
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButton<String>(
        value: _selectedKammerId,
        isExpanded: true,
        hint: const Text('Nach Handwerkskammer filtern'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedKammerId = newValue;
          });
          _filterBetriebe();
        },
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Alle anzeigen'),
          ),
          ..._handwerkskammern.map<DropdownMenuItem<String>>((Handwerkskammer kammer) {
            return DropdownMenuItem<String>(
              value: kammer.id,
              child: Text(kammer.name),
            );
          }).toList(),
        ],
      ),
    );
  }
}
