import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/screens/dashboard/dashboard.dart';
import 'package:tastesonway/screens/register/language%20screen.dart';
import 'package:tastesonway/screens/setting/setting.dart';
import 'package:tastesonway/utils/languages.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'screens/menu/your menu/your_menus.dart';
import 'package:flutter/services.dart';
import 'screens/profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getValidationData();
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    // await Future.delayed(Duration(seconds: 3));
    // var data = await FirebaseDynamicLinks.instance.getInitialLink();
    // var deepLink = data?.link;
    // final queryParams = deepLink!.queryParameters;
    // if (queryParams.isNotEmpty) {
    //   var userName = queryParams['userId'];
    // }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      dynamicLinkData.link.data;
      // if(dynamicLinkData != null) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const OrderDetails()));
      // }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  String? isUser;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String token = await Sharedprefrences.getToken() ?? "";

    // var obtainedUser = sharedPreferences.getString('user');
    setState(() {
      isUser = token.toString();
    });
    print(isUser);
  }

  @override
  build(BuildContext context) {
    return FutureBuilder(
      future: Sharedprefrences.getLanguagePreference(),
      builder: (context, AsyncSnapshot<Locale> snapshot) {
        if (snapshot.hasData) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Taste On Way",
            locale: snapshot.data,
            translations: Languages(),
            theme: ThemeData(
              shadowColor: Colors.transparent,
              primaryColor: orangeColor(),
              brightness: Brightness.dark,
              fontFamily: 'Poppins',
              accentColor: orangeColor(),
            ),
            home: isUser == "null" || isUser == ""   ? const LanguageScreen() : const Home(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  CupertinoTabController tabController = CupertinoTabController(initialIndex: 0);
  final int _currentIndex = 0;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            // const NoInternetScreen();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [firstTabNavKey, secondTabNavKey, thirdTabNavKey,fourthTabNavKey];
    final List<Widget> homeScreenList = [
      const Dashboard(),
      const YourMenus(),
      const Setting(),
      const Profile(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: orangeColor(),
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
        ),
        home: WillPopScope(
        onWillPop: () async {
      return !await listOfKeys[tabController.index].currentState!.maybePop();
    },
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: const Color.fromRGBO(50, 54, 64, 1),
            inactiveColor: const Color.fromRGBO(105, 111, 130, 1),
            iconSize: 30,
            activeColor: orangeColor(),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded)),
              BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu)),
              BottomNavigationBarItem(icon: Icon(Icons.settings)),
              BottomNavigationBarItem(icon: Icon(Icons.person_sharp)),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              navigatorKey: listOfKeys[index], //set navigatorKey here which was initialized before
              builder: (context) {
                return homeScreenList[index];
              },
            );
          }),
        ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Image.asset('assets/images/no_internet.png',width: 250,height: 400,),
          content: Text('key_No_Internet_connection_found'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text('key_Try_Again'.tr,style: const TextStyle(color: Color.fromRGBO(255, 114, 105, 1)),),
            ),
          ],
        ),
      );
}



