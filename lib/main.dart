import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tastesonway/screens/addnewitem.dart';
import 'package:tastesonway/screens/createimagemenu.dart';
import 'package:tastesonway/screens/editItem.dart';
import 'package:tastesonway/themedata.dart';
import './screens/dashboard.dart';
import './screens/yourmenus.dart';
import './screens/createtextmenu.dart';
import './screens/profile.dart';
import 'package:flutter/services.dart';

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
  // int _selectedIndex = 0;
  //
  // static const List<Widget> _WidgetOptions = <Widget>[
  //   Dashboard(),
  //   CreateTextMenu(),
  //   YourMenus(),
  //   Profile(),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Color.fromRGBO(50, 54, 64, 1),
          inactiveColor: Color.fromRGBO(105, 111, 130, 1),
          iconSize: 30,
          activeColor: orangeColor(),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled)),
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
                return CupertinoPageScaffold(child: CreateTextMenu());
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: EditItem());
              });
            case 3:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: Profile());
              });
          }
          return Container();
        });
    // return Scaffold(
    //   backgroundColor: Color.fromRGBO(105, 111, 130, 1),
    //   body: Center(child: _WidgetOptions.elementAt(_selectedIndex)),
    //   bottomNavigationBar: Container(
    //     decoration: BoxDecoration(
    //       color: Color.fromRGBO(50, 54, 64, 1),
    //       // borderRadius: BorderRadius.only(
    //       //     topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    //       boxShadow: [
    //         BoxShadow(
    //           blurRadius: 20,
    //           color: Colors.black.withOpacity(.1),
    //         )
    //       ],
    //     ),
    //     child: SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
    //         child: GNav(
    //           rippleColor: Colors.grey[300]!,
    //           gap: 8,
    //           activeColor: Color.fromRGBO(255, 114, 105, 1),
    //           iconSize: 24,
    //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //           duration: Duration(milliseconds: 400),
    //           tabBackgroundColor: Color.fromRGBO(105, 111, 130, 1),
    //           color: Color.fromRGBO(142, 148, 164, 1),
    //           tabs: [
    //             GButton(
    //               icon: Icons.home,
    //               // text: 'Home',
    //             ),
    //             GButton(
    //               icon: Icons.restaurant_menu,
    //               // text: 'Likes',
    //             ),
    //             GButton(
    //               icon: Icons.settings,
    //               // text: 'Search',
    //             ),
    //             GButton(
    //               icon: Icons.person,
    //               // text: 'Profile',
    //             ),
    //           ],
    //           selectedIndex: _selectedIndex,
    //           onTabChange: (index) {
    //             setState(() {
    //               _selectedIndex = index;
    //             });
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
