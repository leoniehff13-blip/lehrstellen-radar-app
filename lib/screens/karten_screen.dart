import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KartenScreen extends StatefulWidget {
  const KartenScreen({super.key});

  @override
  State<KartenScreen> createState() => _KartenScreenState();
}

class _KartenScreenState extends State<KartenScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // The URL for the embedded Google Map.
    // This example centers the map on Germany.
    const String mapUrl = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6433225.996452225!2d10.451526!3d51.165691!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x479a721ec2b1be6b%3A0x75e85d6b8e91e55b!2sGermany!5e0!3m2!1sen!2sde!4v1700000000000';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can use this to show a loading indicator.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // By returning NavigationDecision.navigate, we allow the webview to load the URL.
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(mapUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
