import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/setting.dart';
import 'package:tastesonway/theme_data.dart';
import './screens/dashboard.dart';
import 'screens/menu/your_menus.dart';
import 'package:flutter/services.dart';
import 'screens/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Taste On Way",
        home: new Home(),
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
          backgroundColor: Color.fromRGBO(50, 54, 64, 1),
          inactiveColor: Color.fromRGBO(105, 111, 130, 1),
          iconSize: 30,
          activeColor: orangeColor(),
          items: [
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
                return CupertinoPageScaffold(child: Dashboard());
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: YourMenus());
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: Setting());
              });
            case 3:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: Profile());
              });
          }
          return Container();
        });
  }
}
