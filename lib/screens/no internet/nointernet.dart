import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/signup/signup.dart';
import 'package:tastesonway/utils/theme_data.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/no_internet.png',width: 250,height: 400,),
            const SizedBox(height: 16),
            const Text(
              'No internet connection available \n Please check your connection',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: orangeColor(),
              ),
              onPressed: () => _checkInternetConnectivity(context),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _checkInternetConnectivity(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection available.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
