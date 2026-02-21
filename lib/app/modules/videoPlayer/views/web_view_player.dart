// webview_player_widget.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPlayerWidget extends StatefulWidget {
  final String url;

  const WebViewPlayerWidget({super.key, required this.url});

  @override
  State<WebViewPlayerWidget> createState() => _WebViewPlayerWidgetState();
}

class _WebViewPlayerWidgetState extends State<WebViewPlayerWidget> {
  late final WebViewController _controller;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => setState(() => _isLoaded = true),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: _isLoaded ? 1 : 0,
          child: WebViewWidget(controller: _controller),
        ),
        if (!_isLoaded)
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      ],
    );
  }
}
