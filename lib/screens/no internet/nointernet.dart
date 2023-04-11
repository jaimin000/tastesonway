import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
             Text(
              'key_No_Internet_connection_found'.tr,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: orangeColor(),
              ),
              onPressed: () => _checkInternetConnectivity(context),
              child:  Text('key_Try_Again'.tr),
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
