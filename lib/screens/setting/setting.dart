import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/screens/register/language%20screen.dart';
import 'package:tastesonway/screens/review%20history/review_history.dart';
import 'package:tastesonway/screens/view%20address/view_address.dart';
import 'package:tastesonway/screens/orders/yourorders.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../utils/sharedpreferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String selectedlang = 'Eng';
  var languages = [
    'Eng',
    'हिंदी',
    'ગુજરાતી',
  ];
  bool _switchValue = true;
  late Locale _currentLocale;


  @override
  void initState() {
    super.initState();
    _getCurrentLocale();
  }

  Future<void> _getCurrentLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    String? countryCode = prefs.getString('country');
    if (languageCode != null) {
      setState(() {
        _currentLocale = Locale(languageCode, countryCode);
      });
    }
  }

  Future<void> _setLanguagePreference(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    await prefs.setString('country', locale.countryCode ?? '');
    Get.updateLocale(locale); // update the app's localization
    setState(() {}); // update the app's UI
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Settings'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 40, 48, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'key_Start_receiving_orders'.tr,
                        textAlign: TextAlign.center,
                        style: inputTextStyle16(),
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                          thumbColor: Colors.black,
                          activeColor: Colors.green,
                          value: _switchValue,
                          onChanged: (bool? value) {
                            setState(() {
                              _switchValue = value ?? false;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAddress()),
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'key_Change_Address'.tr,
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 40, 48, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'key_You_can_Change'.tr,
                        style: inputTextStyle16(),
                      ),
                      DropdownButton(
                        underline: const SizedBox(),
                        value: selectedlang,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(255, 114, 105, 1),
                        ),
                        items: languages.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: cardTextStyle16(),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) async {
                          setState(() {
                            selectedlang = newValue!;
                          });
                          selectedlang == "Eng"
                              ? await _setLanguagePreference(const Locale('en', 'US'))
                              : newValue == "हिंदी"
                          ? await _setLanguagePreference(const Locale('hi', 'IN'))
                              : await _setLanguagePreference(Locale('gj', 'IN'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YourOrders()),
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'key_Your_Orders'.tr,
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReviewHistory()),
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'key_Reviews_History'.tr,
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('user');
                await FirebaseAuth.instance.signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    CupertinoPageRoute(
                        builder: (context) => const LanguageScreen()),
                    (route) => false);
                Fluttertoast.showToast(
                  msg: "key_logout_success".tr,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'key_Logout'.tr,
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
