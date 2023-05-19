import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/register/language screen.dart';
import '../utils/sharedpreferences.dart';

const localUrl = "http://192.168.1.26:24/api/v2";
const devUrl = "https://dev-api.tastesonway.com/api/v2";
const storyUrl = "https://dev-api.tastesonway.com/api";
const liveUrl = "https://api.tastesonway.com/api/v2";

const baseUrl = localUrl;

Future<void> getNewToken(BuildContext context) async {
  String token = await Sharedprefrences.getToken();
  final response =
  await http.post(Uri.parse('$baseUrl/refresh-token'),
      headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "refresh_token": await Sharedprefrences.getRefreshToken()
  });
  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    String newtoken = json['data']['original']['access_token'].toString();
   await Sharedprefrences.setRefreshToken(newtoken);
   print("refresh token setted $newtoken");
    // return token;
  }else {
    print(response.body);
    print("from else");
    final json = jsonDecode(response.body);
    print(json['message']);
    print('Request failed with status: ${response.statusCode}.');
    print("going back to the login");
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.remove('user');
    await FirebaseAuth.instance.signOut();
    print("refresh token failed");
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(
            builder: (context) => const LanguageScreen()),
            (route) => false);
  }
}
