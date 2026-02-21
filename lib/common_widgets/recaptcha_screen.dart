import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecaptchaScreen extends StatefulWidget {
  const RecaptchaScreen({super.key});

  @override
  _RecaptchaScreenState createState() => _RecaptchaScreenState();
}

class _RecaptchaScreenState extends State<RecaptchaScreen> {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        /*onNavigationRequest: (NavigationRequest request) {
          if (request.url.contains('https://www.google.com/recaptcha/api2/')) {
            // Handle reCAPTCHA response here
            print('reCAPTCHA response: ${request.url}');
          }
          return NavigationDecision.navigate;
        },*/
      ),
    )
    ..loadFlutterAsset("assets/webView/index.html");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('reCAPTCHA Verification'),
      ),
      body: WebViewWidget(
        /*initialUrl: 'https://www.google.com/recaptcha/api2/demo',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains('https://www.google.com/recaptcha/api2/')) {
            // Handle reCAPTCHA response here
            print('reCAPTCHA response: ${request.url}');
          }
          return NavigationDecision.navigate;
        },*/
        controller: controller,
      ),
    );
  }
}
