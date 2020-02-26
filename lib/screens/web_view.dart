import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String selectedUrl;
  final bool enableJS;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewScreen({
    @required this.selectedUrl,
    @required this.enableJS,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WebView(
        initialUrl: selectedUrl,
        javascriptMode:
            enableJS ? JavascriptMode.unrestricted : JavascriptMode.disabled,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    ));
  }
}
