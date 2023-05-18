import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tastesonway/screens/contact%20us/contactus.dart';
import 'package:tastesonway/screens/fssai/fssai.dart';
import 'package:tastesonway/screens/my%20website/my_website.dart';
import 'package:tastesonway/screens/discount/discount_page.dart';
import 'package:tastesonway/screens/faq/faq.dart';
import 'package:tastesonway/screens/menu/menu_items.dart';
import 'package:tastesonway/screens/menu/my_menu_design.dart';
import 'package:tastesonway/screens/orders/received_orders.dart';
import 'package:tastesonway/screens/setting/setting.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../orders/yourorders.dart';
import '../tutorials/tutorials.dart';
import '../bank/banking_details.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name ="";
  String profile ="";

  Future fetchData() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-kitchen-owner-profile"),
      headers: {'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        var profileData = jsonData['data'];
        name = profileData['name'];
        profile = profileData['avatar'];
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
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor(),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/profile/image 28.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 312.58,
                          height: 189.19,
                          //margin: EdgeInsets.only(left: 82.87, top: 55.24),
                        ),
                        Positioned(
                          left: -380,
                          top: 150.78,
                          child: Container(
                            width: 1003.91,
                            height: 1037.91,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(39, 42, 50, 1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                         Positioned(
                          top: 70,
                          right: 70,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(profile),
                            radius: 80,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                color: const Color.fromRGBO(39, 42, 50, 1),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: mTextStyle20(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color.fromRGBO(39, 42, 50, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: fontColor(),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('4.8(163)', style: cTextStyle12())
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: fontColor(),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('20 min', style: cTextStyle12())
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_outlined,
                          color: fontColor(),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('150 kcal', style: cTextStyle12())
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                //height: 1150,
                color: const Color.fromRGBO(39, 42, 50, 1),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => DiscountPage()));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const CreateDiscountCoupon()));
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Coupon.png'),
                                Text(
                                  'key_Create_a_Discount_Coupan'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => MyWebsite()));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MyWebsite()));
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Website.png'),
                                Text(
                                  'key_My_Website'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => Fssai()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const Fssai()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Fssai.png'),
                                Text(
                                  'key_Fssai_Registration'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => BankingDetails()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const BankingDetails()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Bank Details.png'),
                                Text(
                                  'key_Bank_Details'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => YourOrders()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ReceivedOrders()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Your Orders.png'),
                                Text(
                                  'key_Your_Orders'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => MenuItems()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const MenuItems()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Menu Items.png'),
                                Text(
                                  'key_Menu_Items'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => MenuDesign()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const MenuDesign()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/My Menu Design.png'),
                                Text(
                                  'key_My_Menu_Designs'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => Tutorials()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Tutorials()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/VideoTutorials.png'),
                                Text(
                                  'key_Tutorials'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Platform.isAndroid
                            ? await Share.share("👋 Hey there!\nCheck out the Tastes on Way Owner App! 📱🍽️\nI've been using it and I absolutely love it! 😍\nYou can download it here:\n👉 https://tastesonwayowner.page.link/D4UMk9hpTkTbNXtA6")
                            : await Share.share("👋 Hey there!\nCheck out the Tastes on Way Owner App! 📱🍽️\nI've been using it and I absolutely love it! 😍\nYou can download it here:\n👉 https://apps.apple.com/in/app/tastes-on-way-owner/id1581405879");
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Shares Taste on Way.png'),
                                Text(
                                  'key_Share_Tastes_on_way'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => ContactUs()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ContactUs()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Contact Us.png'),
                                Text(
                                  'key_Contact_Us'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => FAQ()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const FAQ()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('./assets/images/profile/FAQ.png'),
                                Text(
                                  'key_FAQ'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => Setting()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const Setting()),
                        // );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 140,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/profile/Settings.png'),
                                Text(
                                  'key_Settings'.tr,
                                  textAlign: TextAlign.center,
                                  style: cTextStyle16(),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ])),
      ]),
    );
  }
}
