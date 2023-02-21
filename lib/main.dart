import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tastesonway/screens/discount/fixed_discount.dart';
import 'package:tastesonway/screens/menu/add_new_item.dart';
import 'package:tastesonway/screens/bank/bank_details.dart';
import 'package:tastesonway/screens/bank/banking_details.dart';
import 'package:tastesonway/screens/discount/choose_promo.dart';
import 'package:tastesonway/screens/discount/create_discount_coupon.dart';
import 'package:tastesonway/screens/menu/create_image_menu.dart';
import 'package:tastesonway/screens/menu/edit_item.dart';
import 'package:tastesonway/screens/earning%20summary/payment_received.dart';
import 'package:tastesonway/screens/earning%20summary/pending_payment.dart';
import 'package:tastesonway/screens/discount/tryme.dart';
import 'package:tastesonway/screens/bank/upi_details.dart';
import 'package:tastesonway/theme_data.dart';
import './screens/dashboard.dart';
import 'screens/menu/your_menus.dart';
import 'screens/menu/create_text_menu.dart';
import './screens/profile.dart';
import 'package:flutter/services.dart';
import 'screens/earning summary/earning_summary.dart';
import 'screens/earning summary/payment_details.dart';
import 'screens/discount/discount.dart';

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
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => Home(),
        //   '/profile': (context) => Profile(),
        //   '/textmenu': (context) => CreateTextMenu(),
        //   '/imagemenu': (context) => CreateImageMenu(),
        //   '/additem': (context) => AddNewItem(),
        //   '/edititem': (context) => EditItem(),
        //   '/yourmenu': (context) => YourMenus(),
        //   '/earning': (context) => EarningSummary(),
        //   '/paymentdetails': (context) => PaymentDetails(),
        //   '/paymentreceived': (context) => PaymentReceived(),
        //   '/pendingpayment': (context) => PendingPayment(),
        //   '/bank': (context) => BankingDetails(),
        //   '/bankdetails': (context) => BankDetails(),
        //   '/upidetails': (context) => UPIDetails(),
        //   '/discount': (context) => Discount(),
        //   '/creatediscount': (context) => CreateDiscountCoupon(),
        //   '/fixeddiscount': (context) => FixedDiscount(),
        //
        // }
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
                return CupertinoPageScaffold(child: EarningSummary());
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
