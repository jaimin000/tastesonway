import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/register/language screen.dart';
import '../utils/sharedpreferences.dart';

const localUrl = "http://192.168.1.26:24/api/v2";
const devUrl = "https://dev-api.tastesonway.com/api/v2";
const storyUrl = "https://dev-api.tastesonway.com/api";
const liveUrl = "https://api.tastesonway.com/api/v2";

const baseUrl = localUrl;

String device_id = '';

// Future<String> getToken() async {
//   const url = "$baseUrl/kitchen-owner-login-registration";
//   int platform;
//   if (Platform.isAndroid) {
//     platform = 1;
//   } else {
//     platform = 2;
//   }
//   int gender = await Sharedprefrences.getGender() == "Male" ? 1 : 2;
//   final tokenResponse = await http.post(Uri.parse(url), body: {
//     "language_id": '3',
//     "mobile_number": '8780530654',
//     "short_code": 'IN',
//     "country_code": '91',
//     // "language_id": await Sharedprefrences.getLanguageId().toString(),
//     // "mobile_number": await Sharedprefrences.getMobileNumber().toString(),
//     // "short_code": await Sharedprefrences.getShortCode(),
//     // "country_code": await Sharedprefrences.getCountryCode(),
//     "device_id": "51689555c4cf988a",
//     "platform": "1",
//     "gender": "1",
//   "device_token":
//   "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
//   });
//   final json = jsonDecode(tokenResponse.body);
//   var token = (json['data'][0]['token']).toString();
//   await Sharedprefrences.setToken(token);
//   print(token);
//   return token;
// }
//
// Future<int> getOwnerId() async {
//   const url = "$baseUrl/kitchen-owner-login-registration";
//
//   final tokenResponse = await http.post(Uri.parse(url),
//       body: {
//     "language_id": "1",
//     "mobile_number": "8780530654",
//     "device_token":
//         "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
//     "device_id": "51689555c4cf988a",
//     "platform": "1",
//     "gender": "1",
//     "referral_code": "a5265bb5",
//     "short_code": "IN",
//     "country_code": "91"
//   });
//   final json = jsonDecode(tokenResponse.body);
//   var ownerId = json['data'][0]['id'];
//   print(ownerId);
//   await Sharedprefrences.setId(ownerId);
//   return ownerId;
// }

Future<bool> getNewToken(BuildContext context) async {
  String token = await Sharedprefrences.getToken();
  String refreshToken = await Sharedprefrences.getRefreshToken();
  print("this is refresh $refreshToken");

  final response = await http.post(Uri.parse('$baseUrl/refresh-token'), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "refresh_token": refreshToken
  });

  if (response.statusCode == 200) {
    print(response.body);
    final json = jsonDecode(response.body);
    String newToken = json['data']['original']['access_token'].toString();
    await Sharedprefrences.setToken(newToken);
    return true;
  } else if (response.statusCode == 401) {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('user');
    await FirebaseAuth.instance.signOut();
    print("refresh token failed");
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const LanguageScreen()),
            (route) => false);
    return false;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<String> getDeviceId() async {
  try {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      device_id = androidInfo.id;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      device_id = iosInfo.identifierForVendor!;
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
  return device_id;
}
