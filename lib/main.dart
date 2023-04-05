import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/screens/dashboard/dashboard.dart';
import 'package:tastesonway/screens/no%20internet/nointernet.dart';
import 'package:tastesonway/screens/register/addressPage.dart';
import 'package:tastesonway/screens/register/questions.dart';
import 'package:tastesonway/screens/setting/setting.dart';
import 'package:tastesonway/theme_data.dart';
import 'screens/menu/your_menus.dart';
import 'package:flutter/services.dart';
import 'screens/profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'screens/register/language screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  }

  String? isUser;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedUser = sharedPreferences.getString('user');
     setState(() {
      isUser = obtainedUser.toString();
     });
    print(isUser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Taste On Way",
        theme:ThemeData(
          brightness: Brightness.dark,
          accentColor: orangeColor(),
          fontFamily: 'Poppins',
        ),
        home: isUser == "null" ?  const AddressPage() : const Home()
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

    @override
    void initState() {
      getConnectivity();
      super.initState();
    }

    getConnectivity() =>
        subscription = Connectivity().onConnectivityChanged.listen(
              (ConnectivityResult result) async {
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              NoInternetScreen();
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
    return CupertinoTabScaffold(
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
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: Dashboard());
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: YourMenus());
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: Setting());
              });
            case 3:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: Profile());
              });
          }
          return Container();
        });
  }
    showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
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
            child: const Text('OK'),
          ),
        ],
      ),
    );
}
