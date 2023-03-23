import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyWebsite extends StatefulWidget {
  const MyWebsite({Key? key}) : super(key: key);

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: backgroundColor(),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'My Website',
          style: cardTitleStyle20(),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
            WebView(
            initialUrl: 'https://www.tastesonway.com',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },

            onProgress: (int progress) {
              print("WebView is loading (progress : $progress%)");
            },
            navigationDelegate: (NavigationRequest request) {
              // if (request.url.startsWith('https://www.youtube.com/')) {
              //   print('blocking navigation to $request}');
              //   return NavigationDecision.prevent;
              // }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              setState(() {
                _isLoading = false;
              });
            },
            gestureNavigationEnabled: true,
          ),
          _isLoading?Center(child: CircularProgressIndicator(
            color: orangeColor(),
          )):Stack(),
        ],

      ),
    );
  }
}
