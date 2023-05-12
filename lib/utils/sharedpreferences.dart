import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefrences {
  static Future<bool> setToken(value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString('BearerToken', value.toString());
  }
  static Future<dynamic> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('BearerToken');
  }

  static Future<bool> setId(value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString('Userid', value.toString());
  }
  static Future<dynamic> getId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('Userid');
  }

  static Future<bool> setMenuName(value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString('MenuName', value.toString());
  }
  static Future<dynamic> getMenuName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('MenuName');
  }

  static Future setLanguageId(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('LangId', value);
  }
  static Future getLanguageId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('LangId');
  }

  static Future<bool> setMobileNumber(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('MobileNumber', value.toString());
  }
  static Future<String?> getMobileNumber() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('MobileNumber');
  }

  static Future<bool> setCountryCode(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('CountryCode', value.toString());
  }
  static Future<String?> getCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('CountryCode');
  }

  static Future<bool> setShortCode(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('ShortCode', value.toString());
  }
  static Future<String?> getShortCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ShortCode');
  }

  static Future<bool> saveAddressID(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('AddressID', value);
  }

  static Future<String?> getAddressID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('AddressID');
  }

  static Future<void> setLanguagePreference(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    await prefs.setString('country', locale.countryCode!);
  }

  static Future<Locale> getLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language') ?? 'en';
    final countryCode = prefs.getString('country') ?? 'US';
    return Locale(languageCode, countryCode);
  }

  static Future<bool> setFullName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('FullName', value.toString());
  }
  static Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('FullName');
  }

  static Future<bool> setProfilePic(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('ProfilePic', value);
  }
  static Future<String?> getProfilePic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ProfilePic');
  }

  static Future<bool> setEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('Email', value);
  }
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Email');
  }

  static Future<bool> setBirthdate(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('Birthdate', value);
  }
  static Future<String?> getBirthdate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Birthdate');
  }

  static Future<bool> setPincode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('Pincode', value);
  }
  static Future<String?> getPincode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Pincode');
  }

  static Future<bool> setGender(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('Gender', value);
  }
  static Future<String?> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Gender');
  }

  static Future<bool> setTempLocation(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('TempLocation', value);
  }
  static Future<bool?> getTempLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('TempLocation');
  }

  static Future<bool> setSubLocality(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('SubLocality', value);
  }
  static Future<String?> getSubLocality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('SubLocality');
  }

  static Future<bool> setLocality(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('Locality', value);
  }
  static Future<String?> getLocality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Locality');
  }

  static Future<bool> setTempLat(double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('TempLat', value);
  }
  static Future<double?> getTempLat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('TempLat');
  }

  static Future<bool> setTempLog(double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('TempLog', value);
  }
  static Future<double?> getTempLog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('TempLog');
  }
}
