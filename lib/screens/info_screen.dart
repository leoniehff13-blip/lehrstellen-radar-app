import 'package:flutter/material.dart';
import 'package:myapp/data/hwk_data.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Handwerkskammer> _filteredKammern = alleHandwerkskammern;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      filterKammern();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterKammern() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKammern = alleHandwerkskammern.where((kammer) {
        return kammer.name.toLowerCase().contains(query) ||
            kammer.address.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Zentralverband des Deutschen Handwerks (ZDH)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Der ZDH ist die Spitzenorganisation des Handwerks in Deutschland. Er vertritt die Interessen von rund 1 Million Handwerksbetrieben mit über 5,6 Millionen Beschäftigten.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Handwerkskammern',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'In Deutschland gibt es 53 Handwerkskammern. Sie sind die regionalen Selbstverwaltungseinrichtungen des Handwerks und vertreten die Interessen ihrer Mitgliedsbetriebe.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Suche',
                hintText: 'Handwerkskammer suchen...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredKammern.length,
            itemBuilder: (context, index) {
              return _buildKammerInfo(context, _filteredKammern[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKammerInfo(BuildContext context, Handwerkskammer kammer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () async {
          final url = Uri.parse(kammer.url);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, webOnlyWindowName: '_blank');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(kammer.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4.0),
              Text(kammer.address),
            ],
          ),
        ),
      ),
    );
  }
}
