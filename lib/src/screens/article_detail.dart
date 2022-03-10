
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key}) : super(key: key);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {

  late WebViewController _controller;
  double _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final link = ModalRoute.of(context)!.settings.arguments as String;
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('文章详情'),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: link,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onProgress: (progress) {
                setState(() {
                  _loadingProgress = progress / 100;
                });
              },
              navigationDelegate: (navigation) {
                final isNormalRequest = Uri.parse(navigation.url).scheme.contains('http');
                return isNormalRequest ? NavigationDecision.navigate : NavigationDecision.prevent;
              },
            ),
            Visibility(
              visible: _loadingProgress != 1.0,
              child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withAlpha(33),
                  value: _loadingProgress,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary)
              ),
            )
          ]
        ),
      ),
    );
  }

  Future<bool> _onBack() async {
    final canGoBack = await _controller.canGoBack();
    if(canGoBack) {
      _controller.goBack();
      return false;
    }
    return true;
  }

}