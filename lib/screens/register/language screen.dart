import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/register/landing%20screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/theme_data.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Locale _currentLocale;
  bool selectedEnglish = true;
  bool selectedGujarati = false;
  bool selectedHindi = false;
  bool isServicePresent = false;
  final _scrollController = ScrollController();
  String languageCode = 'en';
  String countryCode = 'US';
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();

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
        backgroundColor: cardColor(),
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Center(
                      child: Text(
                    'key_choose_language'.tr,
                    style: const TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset(
                  './assets/images/language.png',
                  width: 160,
                  height: 160,
                ),
                const SizedBox(
                  height: 25,
                ),
                 Text(
                  'key_select_your_language'.tr,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await _setLanguagePreference(const Locale('en', 'US'));
                            setState(() {
                              selectedEnglish = true;
                              if (selectedEnglish == true) {
                                selectedGujarati = false;
                                selectedHindi = false;
                              }
                            });
                          },
                          child: Container(
                            key: _key1,
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        './assets/images/english.png'),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius:
                                          selectedEnglish == true ? 4 : 0,
                                      color: selectedEnglish == true
                                          ? Colors.grey.withOpacity(0.8)
                                          : cardColor())
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'English',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      selectedEnglish == true
                                          ? Image.asset(
                                              './assets/images/right.png',
                                              height: 20,
                                              width: 20,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                                //SizedBox(height: 10,),
                                const Center(
                                  child: Text(
                                    'A',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 77,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await _setLanguagePreference(const Locale('gj', 'IN'));
                            setState(() {
                              selectedGujarati = true;
                              if (selectedGujarati == true) {
                                selectedEnglish = false;
                                selectedHindi = false;
                              }
                            });
                          },
                          child: Container(
                            width: 160,
                            height: 160,
                            key: _key2,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        './assets/images/gujarati.png'),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius:
                                          selectedGujarati == true ? 4 : 0,
                                      color: selectedGujarati == true
                                          ? Colors.grey.withOpacity(0.8)
                                          : cardColor())
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 15),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'ગુજરાતી',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      selectedGujarati == true
                                          ? Image.asset(
                                              './assets/images/right.png',
                                              height: 20,
                                              width: 20,
                                            )
                                          : Container()
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Center(
                                    child: Text(
                                      'એ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 56,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () async {
                      await _setLanguagePreference(const Locale('hi', 'IN'));
                      setState(() {
                        selectedHindi = true;
                        if (selectedHindi == true) {
                          selectedEnglish = false;
                          selectedGujarati = false;
                        }
                      });
                    },
                    child: Container(
                        width: 160,
                        height: 160,
                        key: _key3,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image:
                                    AssetImage('./assets/images/hindi.png'),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: selectedHindi == true ? 4 : 0,
                                  color: selectedHindi == true
                                      ? Colors.grey.withOpacity(0.8)
                                      : cardColor())
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'हिंदी',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      selectedHindi == true
                                          ? Image.asset(
                                              './assets/images/right.png',
                                              height: 20,
                                              width: 20,
                                            )
                                          : Container()
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Center(
                                      child: Text(
                                    'अ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ])))),
                const SizedBox(
                  height: 45,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 15, right: 15),
                    child: Container(
                        key: _key4,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF85649),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async{
                              int languageId;
                              if (selectedHindi == true) {
                                languageId = 1;
                                languageCode = 'hi';
                                countryCode = 'IN';
                              }
                              else if (selectedGujarati == true) {
                                languageId = 2;
                                languageCode = 'gj';
                                countryCode = 'IN';

                              } else {
                                languageId = 3;
                                languageCode = 'en';
                                countryCode = 'US';
                              }
                              print('this is languageId $languageId');
                              await Sharedprefrences.setLanguagePreference(Locale(languageCode,countryCode));
                              await Sharedprefrences.setLanguageId(languageId);
                              print(await Sharedprefrences.getLanguagePreference());
                              //await Sharedprefrences.setLanguageId(languageId);
                              // print(await Sharedprefrences.getLanguageId());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LandingScreen()),
                              );
                            },
                            child:  Text(
                              'key_continue'.tr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ))))
              ],
            )));
  }
}
