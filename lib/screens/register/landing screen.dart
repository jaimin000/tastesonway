import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/register/language%20screen.dart';
import 'package:tastesonway/screens/register/userPersonalDetail.dart';
import 'package:tastesonway/screens/signup/signup.dart';
import '../../utils/theme_data.dart';
import 'package:page_indicator/page_indicator.dart';


class LandingScreen extends StatefulWidget {

  const LandingScreen({Key? key}) : super(key: key);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final int _currentPage = 0;
  final PageController _pageController = PageController(
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: cardColor(),
    body: Column(
      children: <Widget>[
        Expanded(
          flex: 12,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: PageIndicatorContainer(
              length: 3,
              indicatorSpace: 10.0,
              padding: const EdgeInsets.all(10),
              indicatorColor: Color(0xFFF85649).withOpacity(0.3),
              indicatorSelectorColor: Colors.red,
              shape: IndicatorShape.circle(),
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 50),
                          child: Image.asset(
                            'assets/images/slider_1.png',
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Text(
                              'key_Capture_your'.tr,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                            ),
                           Text(
                              'key_orders_from_chat'.tr,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              'key_Apps_easily'.tr,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'assets/images/slider_2.png',
                            height: 323,
                            width: 895,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children:  [
                            Text(
                              'key_Design_Cool'.tr,
                              style: const TextStyle(
                                fontSize: 30,

                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'key_Menus'.tr,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30, top: 50),
                          child: Image.asset('assets/images/slider_3.png'),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children:  [
                            Text(
                              'key_Track_your'.tr,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'key_Expenses_and'.tr,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'key_Earnings'.tr,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: [
                Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup()),
                          );
                          //Sharedprefrences.isFirstTimeSet(false);
                        },
                        child:  Text(
                          'key_Get_Stated'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ))),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
