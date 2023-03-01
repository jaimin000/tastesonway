import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/login%20-%20signup/login.dart';
import 'package:tastesonway/screens/review%20history/review_history.dart';
import 'package:tastesonway/screens/view%20address/view_address.dart';
import 'package:tastesonway/screens/orders/yourorders.dart';
import 'package:tastesonway/theme_data.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Settings',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(37, 40, 48, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Receiving Orders',
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
            SizedBox(height: 15),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewAddress()),
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Change Your Address',
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const YourOrders()),
                );
              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Orders',
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
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
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Review History',
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil( CupertinoPageRoute(builder: (context) => Login()), (route) => false);

              },
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Logout',
                        style: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),



          ],
        ),
      ),
    );
  }
}
