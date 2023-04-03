import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tastesonway/screens/register/landing%20screen.dart';

import '../../theme_data.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool selectedEnglish = true;
  bool selectedGujarati = false;
  bool selectedHindi = false;
  bool isServicePresent = false;
  final _scrollController = ScrollController();
  String languageCode = 'en';
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: cardColor(),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 65),
                child: Center(
                    child: Text(
                      'Choose Language',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                './assets/images/language.png',
                width: 160,
                height: 160,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Select your language',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
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
                                    blurRadius: selectedEnglish == true ? 4 : 0,
                                    color: selectedEnglish == true
                                        ? Colors.grey.withOpacity(0.8)
                                        : Colors.white)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
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
                              image: DecorationImage(
                                  image: const AssetImage(
                                      './assets/images/gujarati.png'),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: selectedGujarati == true
                                        ? 4
                                        : 0,
                                    color: selectedGujarati == true
                                        ? Colors.grey.withOpacity(0.8)
                                        : Colors.white)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Gujarati',
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
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
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
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
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
                      image: DecorationImage(
                          image: AssetImage('./assets/images/hindi.png'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: selectedHindi == true ? 4 : 0,
                            color: selectedHindi == true
                                ? Colors.grey.withOpacity(0.8)
                                : Colors.white)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hindi',
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
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'अ',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Container(
                  key: _key4,
                  decoration: BoxDecoration(
                    color: Color(0xFFF85649),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      int languageId;
                      if (selectedEnglish == true) {
                        languageId = 1;
                        languageCode = 'en';
                      } else if (selectedGujarati == true) {
                        languageId = 3;
                        languageCode = 'gu';
                      } else {
                        languageId = 2;
                        languageCode = 'hi';
                      }
                      print(languageId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LandingScreen()),
                      );

                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _willPopCallback() async {
    if (isServicePresent) {
      return Future.value(false);
    } else {
      // widget.isFromMain
      //     ? SystemNavigator.pop()
           Navigator.pop(context);
      // Navigator.pop(context);
      return Future.value(true);
    }
  }

}