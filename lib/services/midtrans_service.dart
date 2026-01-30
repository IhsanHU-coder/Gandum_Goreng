import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWebView extends StatelessWidget {
  final String url;

  const SnapWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: WebViewWidget(controller: controller),
    );
  }
}
