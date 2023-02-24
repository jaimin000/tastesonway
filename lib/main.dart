import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/Other/setting.dart';
import 'package:tastesonway/theme_data.dart';
import 'screens/Other/dashboard.dart';
import 'screens/menu/your_menus.dart';
import 'package:flutter/services.dart';
import 'screens/Other/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Taste On Way",
        theme:ThemeData.dark(),
        home: const Home(),
        );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
}
