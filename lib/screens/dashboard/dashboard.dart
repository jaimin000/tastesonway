import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/apiServices/api_service.dart';
import 'package:tastesonway/screens/dashboard/stories.dart';
import 'package:tastesonway/screens/earning%20summary/earning_summary.dart';
import 'package:tastesonway/screens/menu/text%20menu/create_text_menu1.dart';
import 'package:tastesonway/screens/menu/your_menus.dart';
import 'package:tastesonway/screens/orders/received_orders.dart';
import 'package:tastesonway/screens/profile/profile.dart';
import 'package:tastesonway/screens/orders/yourorders.dart';
import 'dart:core';
import '../../utils/sharedpreferences.dart';
import '../../utils/theme_data.dart';
import '../menu/image menu/create_img_menu1.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int totalMenu = 0;
  int totalMenuItem = 0;
  int theme = 0;
  int todayOrder = 0;
  int tommorrowOrder = 0;
  int laterOrder = 0;
  int earningWeek = 0;
  int earningMonth = 0;
  int earningSummary = 0;

  Future fetchData() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
        Uri.parse("$baseUrl/kitchen-owner-dashboard"),
        headers: {'Authorization': 'Bearer $token',
        },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        var dashboardData = jsonData['data'];
        print(dashboardData);
        totalMenu = dashboardData['total_menus'];
         totalMenuItem = dashboardData['total_menu_items'];
         theme = dashboardData['total_theme'];
         todayOrder = dashboardData['total_today_order'];
         tommorrowOrder = dashboardData['total_tomorrow_order'];
         laterOrder = dashboardData['total_later_date'];
         earningWeek = dashboardData['total_earning_summary_of_week'];
         earningMonth = dashboardData['total_earning_summary_of_month'];
         earningSummary = dashboardData['total_earning_summary'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Sania Fraser",
                  style: mTextStyle20(),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) => Profile()));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Profile()),
                // );
              },
              child: const CircleAvatar(
                backgroundImage:
                NetworkImage(
                    'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 105,
              child: Stories(),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: const TextStyle(color: Colors.white), //<-- SEE HERE
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: inputColor(),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'key_find_dishes'.tr,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                    suffixIcon:
                        Image.asset('./assets/images/dashboard/Filter.png')),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("key_Quick_Link".tr, style: mTextStyle20()),
                  Row(
                    children: [
                      Text("key_all".tr, style: mTextStyle14()),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        './assets/images/dashboard/Arrow - Right.png',
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const YourOrders()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => YourOrders()));
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/dashboard/food.png'),
                                Text(
                                  'key_Orders'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const YourMenus()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => YourMenus()));
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/dashboard/menu.png'),
                                Text(
                                  'key_Menu'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'key_other'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("key_Your_Menus".tr, style: mTextStyle20()),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const YourMenus()),
                      // );
                      Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>const YourMenus()));
                    },
                    child: Row(
                      children: [
                        Text("key_all".tr, style: mTextStyle14()),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          './assets/images/dashboard/Arrow - Right.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const CreateTextMenu()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => CreateTextMenu()));
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_Create_Text_Menu".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const CreateImgMenu()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => CreateImgMenu()));
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_Create_Image_Menu".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("$totalMenu", style: cTextStyle36()),
                              Text(
                                'key_Your_Menus'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("$totalMenuItem", style: cTextStyle36()),
                              Text(
                                'key_Items_In_Menu'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$theme', style: cTextStyle36()),
                              Text(
                                'key_My_Menu_Designs'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ReceivedOrders()),
                // );
                Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) => ReceivedOrders()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("key_Your_Orders".tr, style: mTextStyle20()),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const YourOrders()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => YourOrders()));
                      },
                      child: Row(
                        children: [
                          Text("key_all".tr, style: mTextStyle14()),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            './assets/images/dashboard/Arrow - Right.png',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const YourOrders()),
                          // );
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) => YourOrders()));
                        },
                        child: Container(
                          width: 300,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Frame 48095724.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_view_orders".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ),
                      ), //
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ReceivedOrders()),
                        // );
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => ReceivedOrders()));
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 300,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Frame 48095724.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_view_received_orders".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$todayOrder', style: cTextStyle36()),
                              Text(
                                'key_Today'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$tommorrowOrder', style: cTextStyle36()),
                              Text(
                                'key_Tomorrow'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('$laterOrder', style: cTextStyle36()),
                              Text(
                                'key_Later'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('key_Earning_Summary'.tr, style: mTextStyle20()),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const EarningSummary()),
                      // );
                      Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                              builder: (BuildContext context) => EarningSummary()));
                    },
                    child: Row(
                      children: [
                        Text("key_all".tr, style: mTextStyle14()),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          './assets/images/dashboard/Arrow - Right.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) => EarningSummary()));
              },
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389-1.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_Earning_Summary".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389-1.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("key_Expenses_Summary".tr,
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 250,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹$earningWeek', overflow:TextOverflow.ellipsis,style: cTextStyle36()),
                              Text(
                                'key_This_Week'.tr,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 220,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹$earningMonth',overflow:TextOverflow.ellipsis, style: cTextStyle36()),
                              Text(
                                'key_This_Month'.tr,
                                style: cTextStyle18(),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 220,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹$earningSummary',overflow:TextOverflow.ellipsis, style: cTextStyle36()),
                              Text(
                                'key_Total'.tr,
                                style: cTextStyle18(),
                                overflow: TextOverflow.clip,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
