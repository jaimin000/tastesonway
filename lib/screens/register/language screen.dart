import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../localization/app_translations.dart';
import '../../localization/application.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/shared_prefrences.dart';
import '../../utils/user_details.dart';
import '../../widgets/snack_bar.dart';
import '../introduction/landing_screen.dart';

class LanguageScreen extends StatefulWidget {
  final bool isFromMain;

  const LanguageScreen({Key key, this.isFromMain = false}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool selectedEnglish = true;
  bool selectedGujarati = false;
  bool selectedHindi = false;
  UserDetails userDetails;
  bool isServicePresent = false;

  final _scrollController = ScrollController();

  static List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
  };
  String languageCode = 'en';

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();
  String lan;
  final AuthRepository _repository = AuthRepository();

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap['Hindi'].toString()));
    onLocaleChange(Locale(languagesMap['Gujarati'].toString()));
    onLocaleChange(Locale(languagesMap['English'].toString()));
    _select('English');
    // WidgetsBinding.instance.addPostFrameCallback(layout);
    // Future.delayed(Duration.zero, () {
    //   initTargets(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    userDetails = Provider.of<UserDetails>(context);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: Center(
                    child: Text(
                      'Choose Language',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/images/language.png',
                width: 160,
                height: 160,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Select your language',
                style: TextStyle(fontSize: 17, color: Color(0xFF313131)),
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
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/english.png'),
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
                                    Text(
                                      'English',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    selectedEnglish == true
                                        ? Image.asset(
                                      'assets/images/right.png',
                                      height: 20,
                                      width: 20,
                                    )
                                        : Container()
                                  ],
                                ),
                              ),
                              //SizedBox(height: 10,),
                              Center(
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
                                  image: AssetImage(
                                      'assets/images/gujarati.png'),
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
                                      'assets/images/right.png',
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
                          image: AssetImage('assets/images/hindi.png'),
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
                                'assets/images/right.png',
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
                              style: TextStyle(
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
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: FlatButton(
                    onPressed: () {
                      int languageId;
                      if (selectedEnglish == true) {
                        languageId = 1;
                        lan = 'English';
                        languageCode = 'en';
                      } else if (selectedGujarati == true) {
                        languageId = 3;
                        lan = 'Gujarati';
                        languageCode = 'gu';
                      } else {
                        lan = 'Hindi';
                        languageId = 2;
                        languageCode = 'hi';
                      }
                      _select(lan);
                      // updateLanguage(language_id);
                      // userDetails.language(language_id);
                      // Sharedprefrences.setLanguageId(language_id);
                      Sharedprefrences.saveLanguage(lan);
                      Sharedprefrences.setLanguageCode(languageCode);
                      userDetails.language(languageId);

                      if (tutorialCoachMark != null) {
                        tutorialCoachMark.finish();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()));
                      // setState(() {
                      //   if((selectedEnglish==true && selectedHindi==false && selectedGujarati==false) || (selectedEnglish==false &&
                      //       selectedHindi==true && selectedGujarati==false) || (selectedEnglish==false && selectedHindi==false &&
                      //       selectedGujarati==true) || (selectedEnglish==false && selectedHindi==false &&
                      //       selectedGujarati==false)){
                      //     SnackBarWidget.show(context, "Please Select Language");
                      //   }
                      //   else{
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => LandingScreen()));
                      //   }
                      // });
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Roboto',
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
      widget.isFromMain
          ? SystemNavigator.pop()
          : Navigator.pop(context);
      // Navigator.pop(context);
      return Future.value(true);
    }
  }

  Future<void> updateLanguage(int languageID) async {
    print(languageID);
    await Sharedprefrences.setLanguageCode(languageCode);

    await _repository
        .updateLanguage(
      languageID,
    )
        .then((value) async {
      print(value);
      dynamic status = value.body;
      dynamic user = jsonDecode(status.toString());
      if (value.statusCode != 200) {
        dynamic message = user['message'];
        SnackBarWidget.show(context, message.toString());
      } else {
        print(user);
      }
    });
    // } else {
    //   setState(() {
    //     isNetworkPresent = true;
    //   });
    // }
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  _select(String language) {
    setState(() {
      onLocaleChange(Locale(languagesMap[language].toString()));
    });
  }

  void layout(Duration _) {
    Future.delayed(Duration(seconds: 1), showTutorial);
  }

  Future<void> showTutorial() async {
    var isShowTutorial =
        await Sharedprefrences.isGetShowTutorial('isShowTutorial') ?? true;
    if (isShowTutorial) {
      tutorialCoachMark = TutorialCoachMark(
        context,
        targets: targets,
        colorShadow: Colors.grey[350],
        textStyleSkip: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0),
        onFinish: () async {
          print('finish');
          await Sharedprefrences.isSetShowTutorial('isShowTutorial', false);
        },
        onClickTarget: (target) {
          print('onClickTarget: $target');
          if (target.identify.toString() == 'Target 2') {
            print('herererere');
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500),
            );
          }
        },
        onSkip: () async {
          print('skip');
          await Sharedprefrences.isSetShowTutorial('isShowTutorial', false);
        },
        onClickOverlay: (target) {
          print('onClickOverlay: $target');
        },
      )
        ..show();
    }
  }

  void initTargets(BuildContext context) {
    targets.add(
      TargetFocus(
        identify: 'Target 0',
        keyTarget: _key1,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Select English Language',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'If you select English language, the whole app will be translated into English.',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 1',
        keyTarget: _key2,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ગુજરાતી ભાષા પસંદ કરો',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'જો તમે ગુજરાતી ભાષા પસંદ કરો છો, તો આખી એપ્લિકેશન ગુજરાતીમાં અનુવાદિત કરવામાં આવશે.',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 2',
        keyTarget: _key3,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'हिंदी भाषा चुनें',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'यदि आप हिंदी भाषा का चयन करते हैं, तो संपूर्ण ऐप का हिंदी में अनुवाद किया जाएगा।',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 3',
        keyTarget: _key4,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Click Continue Button',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'If you Click Continue Button, our team will Saved Selected Language for future.',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}