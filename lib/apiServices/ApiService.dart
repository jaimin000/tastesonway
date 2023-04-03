import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var tokenvalue;
var ownerId;

const devUrl = "http://192.168.1.26:24/api";
const liveUrl = "https://dev-api.tastesonway.com/api/v2";

Future<String> getToken() async {
  const url =
  "$devUrl/users/kitchen-owner-login-registration";

  final tokenResponse = await http.post(Uri.parse(url), body: {
    "language_id": await getLanguageId(),
    "mobile_number": await getPhone(),
    "device_token":
        "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
    "device_id": "51689555c4cf988a",
    "platform": "1",
    "gender": "1",
    "referral_code": "a5265bb5",
    "short_code": "IN",
    "country_code": "91"
  });
  final json = jsonDecode(tokenResponse.body);
  tokenvalue = (json['data'][0]['token']).toString();
  return tokenvalue;
}


Future<int> getOwnerId() async {
  const url =
      "$devUrl/v2/kitchen-owner-login-registration";

  final tokenResponse = await http.post(Uri.parse(url), body: {
    "language_id": "1",
    "mobile_number": "7069836196",
    "device_token":
    "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
    "device_id": "51689555c4cf988a",
    "platform": "1",
    "gender": "1",
    "referral_code": "a5265bb5",
    "short_code": "IN",
    "country_code": "91"
  });
  final json = jsonDecode(tokenResponse.body);
  ownerId = json['data'][0]['id'];
  print(ownerId);
  return ownerId;
}

Future<int?> getLanguageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(prefs.getInt('languageId'));
  return prefs.getInt('languageId');
}

Future getPhone() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(prefs.getString('user').toString());
  return prefs.getString('user').toString();
}