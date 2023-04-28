import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Fssai extends StatefulWidget {
  const Fssai({Key? key}) : super(key: key);

  @override
  State<Fssai> createState() => _FssaiState();
}

class _FssaiState extends State<Fssai> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool _isLoading = true;
  bool isShowDialog = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: backgroundColor(),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'key_Fssai_Registration'.tr,
          style: cardTitleStyle20(),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
        WebView(
        initialUrl: 'https://foscos.fssai.gov.in/apply-for-lic-and-reg',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains(
              'https://foscos.fssai.gov.in/public/fbo/application-registratin-receipt')) {
            // print('blocking navigation to $request}');
            // return NavigationDecision.prevent;
            setState(() {
              isShowDialog = true;
            });
            // }else if(request.url.contains('https://foscos.fssai.gov.in/officer/')){
            //   print("herererere");
            //   setState(() {
            //     isShowDialog = true;
            //   });
          }
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
          _isLoading?Center(child: SpinKitFadingCircle(
            color: orangeColor(),
          )):Stack(),
        ],

      ),
    );
  }
}
