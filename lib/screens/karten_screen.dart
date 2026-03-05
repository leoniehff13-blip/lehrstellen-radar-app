import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

import '../data/hwk_data.dart';
import '../models/betrieb.dart';

class KartenScreen extends StatefulWidget {
  final List<Betrieb>? betriebe;

  const KartenScreen({super.key, this.betriebe});

  @override
  State<KartenScreen> createState() => _KartenScreenState();
}

class _KartenScreenState extends State<KartenScreen> {
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];
  bool _isLoading = true;

  final List<Betrieb> _betriebe = [
    Betrieb(
        name: 'Tietz GmbH & Co. KG',
        branche: 'Zimmerei',
        ort: 'Pinneberg',
        logo:
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Wir lieben Holz.',
        aufgabenbereiche: [
          'Fachwerkrestaurierung historischer Gebäude',
          'Holzbrückenbau',
          'Flechtwerkfassaden & Skulpturales Holzdesign'
        ],
        webseite: 'www.muster-gmbh.de',
        adresse: 'Ossenpadd 8, 25421 Pinneberg',
        ansprechpartner: 'Frau Dr. Tietz',
        email: 'bewerbung@muster-gmbh.de',
        telefon: '+49 711 123456',
        handwerkskammerId: 'hamburg'), // Assuming Hamburg chamber is closest
    Betrieb(
        name: 'Holzbau Bötzelen',
        branche: 'Zimmerei',
        ort: 'Sittensen',
        logo:
            'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=100&auto=format&fit=crop',
        beschreibung:
            'Traditionelles Handwerk trifft auf moderne Technik. Bei uns lernst du den Umgang mit dem Werkstoff Holz von Grund auf.',
        aufgabenbereiche: [
          'Schiffsinnenausbau in Holz',
          'Sakralbau (Kirchendächer, Glockentürme)',
          'Baumhausbau & Hochseilgärten'
        ],
        webseite: 'www.holzbau-schmidt.de',
        adresse: 'Appeler Weg 60, 27419 Sittensen',
        ansprechpartner: 'Frau Bötzelen',
        email: 'info@holzbau-schmidt.de',
        telefon: '+49 761 987654',
        handwerkskammerId:
            'braunschweig_lueneburg_stade'), // Assuming this chamber covers Sittensen
    Betrieb(
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
        handwerkskammerId: 'bielefeld'),
    Betrieb(
        name: 'Elektriker Knete Kross',
        branche: 'Elektriker',
        ort: 'Wolfsburg',
        logo:
            'https://images.unsplash.com/photo-1598373182133-52452f7691ef?q=80&w=100&auto=format&fit=crop',
        beschreibung: 'Abfahrt',
        aufgabenbereiche: [
          'Motorenprüfung',
          'Frequenzumrichter einstellen',
          'Notstromanlagen warten'
        ],
        webseite: 'www.knete-kross.de',
        adresse: 'Rundling 4, 38448 Wolfsburg',
        ansprechpartner: 'Herr Kross',
        email: 'info@knete-kross.de',
        telefon: '+49 221 555667',
        handwerkskammerId:
            'braunschweig_lueneburg_stade'), // Assuming this chamber covers Wolfsburg
  ];

  String? _selectedKammerId;

  @override
  void initState() {
    super.initState();
    _updateMapContent(_betriebe);
  }

  void _filterAndGeocodeBetriebe() {
    final filteredBetriebe = _selectedKammerId == null
        ? _betriebe
        : _betriebe
            .where((b) => b.handwerkskammerId == _selectedKammerId)
            .toList();

    _updateMapContent(filteredBetriebe);
  }

  Future<void> _updateMapContent(List<Betrieb> betriebe) async {
    setState(() {
      _isLoading = true;
      _markers.clear();
    });

    final List<Marker> resolvedMarkers = [];
    for (final betrieb in betriebe) {
      final latLng = await _getLatLngFromAddress(betrieb.adresse);
      if (latLng != null) {
        resolvedMarkers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: latLng,
            child: Tooltip(
              message: "${betrieb.name}\n${betrieb.branche}",
              child: IconButton(
                icon: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () {
                  _showBetriebDetailsPopup(context, betrieb);
                },
              ),
            ),
          ),
        );
      }
    }

    if (!mounted) return;

    setState(() {
      _markers.addAll(resolvedMarkers);
      _isLoading = false;
    });

    if (_selectedKammerId == null) {
      _mapController.move(const LatLng(51.1657, 10.4515), 6.0);
    }
  }

  void _showBetriebDetailsPopup(BuildContext context, Betrieb betrieb) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: controller,
                child: _BetriebsDetailSheet(betrieb: betrieb),
              ),
            );
          },
        );
      },
    );
  }

  Future<LatLng?> _getLatLngFromAddress(String address) async {
    final url = Uri.parse(
        'https://photon.komoot.io/api/?q=${Uri.encodeComponent(address)}&limit=1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          final coordinates = data['features'][0]['geometry']['coordinates'];
          final lon = coordinates[0];
          final lat = coordinates[1];
          return LatLng(lat, lon);
        }
      } else {
        developer.log(
            'Photon API request failed with status: ${response.statusCode}.',
            name: 'KartenScreen');
      }
    } catch (e) {
      developer.log('Error during geocoding: $e',
          name: 'KartenScreen', error: e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterDropdown(),
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: const LatLng(51.1657, 10.4515),
                  initialZoom: 6.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.myapp',
                  ),
                  MarkerLayer(markers: _markers),
                ],
              ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
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
          _filterAndGeocodeBetriebe();
        },
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Alle anzeigen'),
          ),
          ...alleHandwerkskammern
              .map<DropdownMenuItem<String>>((Handwerkskammer kammer) {
            return DropdownMenuItem<String>(
              value: kammer.id,
              child: Text(kammer.shortName),
            );
          }).toList(), // Add .toList() here
        ],
      ),
    );
  }
}

class _BetriebsDetailSheet extends StatelessWidget {
  final Betrieb betrieb;

  const _BetriebsDetailSheet({required this.betrieb});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  betrieb.logo,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: Icon(Icons.business,
                          size: 40, color: Colors.grey[600])),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        betrieb.name,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        betrieb.branche,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                    ]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            betrieb.beschreibung,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          _buildInfoRow(context, Icons.location_on_outlined, betrieb.adresse),
          const SizedBox(height: 12),
          _buildInfoRow(context, Icons.person_outline, betrieb.ansprechpartner),
          const SizedBox(height: 12),
          _buildInfoRow(context, Icons.email_outlined, betrieb.email),
          const SizedBox(height: 12),
          _buildInfoRow(context, Icons.phone_outlined, betrieb.telefon),
          const SizedBox(height: 12),
          _buildInfoRow(context, Icons.language_outlined, betrieb.webseite),
          const SizedBox(height: 16),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text(
              'Gesuchtes Aufgabenprofil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: betrieb.aufgabenbereiche
                .map((aufgabe) => ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 8.0, right: 8.0),
                      leading:
                          Icon(Icons.check_circle, color: theme.primaryColor),
                      title: Text(aufgabe),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.primaryColor.withOpacity(0.8), size: 22),
        const SizedBox(width: 16),
        Expanded(
            child: Text(text,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15))),
      ],
    );
  }
}
