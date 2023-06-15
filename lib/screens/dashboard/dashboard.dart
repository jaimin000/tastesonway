import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/apiServices/api_service.dart';
import 'package:tastesonway/screens/dashboard/stories.dart';
import 'package:tastesonway/screens/earning%20summary/earning_summary.dart';
import 'package:tastesonway/screens/menu/your%20menu/your_menus.dart';
import 'package:tastesonway/screens/notificationService.dart';
import 'package:tastesonway/screens/orders/history/orderhistory.dart';
import 'package:tastesonway/screens/profile/profile.dart';
import 'package:tastesonway/screens/orders/yourorders.dart';
import 'dart:core';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../../utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../menu/text-image menu/create_menu1.dart';
import '../register/language screen.dart';
import '../undermaintenance.dart';

class Dashboard extends StatefulWidget {
  final bool isFromMain;

  const Dashboard({Key? key, this.isFromMain = false}) : super(key: key);

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
  String profilePhoto = "";
  String userName = "";
  final currentTime = DateTime.now();
  String greeting = "";
  int refreshCounter = 0;
  bool isServicePresent = false;
  String profileRejectMessage = '';

  bool is_profile_updated_first_time = false;
  int owner_status = OWNER_PROFILE_STATUS_IN_REVIEW;
  static int OWNER_PROFILE_STATUS_IN_REVIEW = 1;
  static int OWNER_PROFILE_STATUS_APPROVED = 2;
  static int OWNER_PROFILE_STATUS_REJECTED = 3;
  static int OWNER_PROFILE_STATUS_BLOCKED = 4;

  void showInReviewMessage(int ownerStatus) {
    if (ownerStatus == OWNER_PROFILE_STATUS_IN_REVIEW) {
      ScaffoldSnackbar.of(context).show('key_profile_in_review_msg'.tr);
    } else if (ownerStatus == OWNER_PROFILE_STATUS_REJECTED) {
      ScaffoldSnackbar.of(context)
          .show('key_profile_rejected_msg\n $profileRejectMessage'.tr);
    } else {
      ScaffoldSnackbar.of(context).show('key_profile_blocked_msg'.tr);
    }
  }

  Future fetchData() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/kitchen-owner-dashboard"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (currentTime.hour < 12) {
      greeting = 'Good Morning';
    } else if (currentTime.hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        isServicePresent = false;
        var dashboardData = jsonData['data'];
        totalMenu = dashboardData['total_menus'];
        totalMenuItem = dashboardData['total_menu_items'];
        theme = dashboardData['total_theme'];
        todayOrder = dashboardData['total_today_order'];
        tommorrowOrder = dashboardData['total_tomorrow_order'];
        laterOrder = dashboardData['total_later_date'];
        earningWeek = dashboardData['total_earning_summary_of_week'];
        earningMonth = dashboardData['total_earning_summary_of_month'];
        earningSummary = dashboardData['total_earning_summary'];
        owner_status =
            int.parse(dashboardData['userData']['status'].toString());
        profileRejectMessage =
            dashboardData['userData']['reason_for_reject'].toString();
        Sharedprefrences.setOwnerStatus(owner_status);
        Sharedprefrences.setRejectMessage(profileRejectMessage);

        if (dashboardData['userData']['is_profile_updated_first_time']
                .toString() ==
            '2') {
          is_profile_updated_first_time = false;
          Sharedprefrences.setProfileUpdatedTime(is_profile_updated_first_time);
        } else {
          is_profile_updated_first_time = true;
          Sharedprefrences.setProfileUpdatedTime(is_profile_updated_first_time);
        }
      });
    } else if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      if (jsonData['message'].toString().contains('maintenance')) {
        print('server is undermaintenance');
        setState(() {
          isServicePresent = true;
        });
      } else if (!isServicePresent) {
        print("refresh token called");
        if (refreshCounter == 0) {
          refreshCounter++;
          bool tokenRefreshed = await getNewToken(context);
          tokenRefreshed ? fetchData() : null;
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future fetchProfile() async {
    String token = await Sharedprefrences.getToken() ?? "";
    final response = await http.get(
      Uri.parse("$baseUrl/get-kitchen-owner-profile"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        var profileData = jsonData['data'];
        profilePhoto = profileData['avatar'];
        userName = profileData['name'];
        // print('this is profile photo '+profilePhoto);
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchProfile() : null;
      }
    } else {
      print('refresh token failed');
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future updateDeviceToken(deviceToken, deviceId, platform) async {
    String token = await Sharedprefrences.getToken() ?? "";
    final response =
        await http.post(Uri.parse("$baseUrl/update-user-device"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'device_token': deviceToken,
      'device_id': deviceId,
      'platform': platform,
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed
            ? updateDeviceToken(deviceToken, deviceId, platform)
            : null;
      }
    } else {
      print('refresh token failed');
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  initNotification() {
    print('init notification called');
    FirebaseMessaging.instance.getToken().then((token) async {
      await updateDeviceToken(
          token, await getDeviceId(), Platform.isAndroid ? '1' : '2');
    });
    if (widget.isFromMain) {
      NotificationService().init();
      NotificationService().setupFlutterNotifications();
      NotificationService().onMessageNotification();
      NotificationService().onNotificationClick();
    }
    // if (widget.isFromMain) {
    //   init();
    //   checkForInitialMessage();
    //   registerNotification();
    //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //     print(message.notification!.title);
    //     print(message.data['order_id']);
    //     print(message.data['Bank_Status']);
    //     print(message.data['notification_type']);
    //     if (message != null) {
    //       if (message.data != null) {
    //         if (message.data['order_id'] != null) {
    //           SchedulerBinding.instance.addPostFrameCallback((_) {
    //             Navigator.of(GlobalVariable.navState.currentContext)
    //                 .push(MaterialPageRoute(
    //                 builder: (context) => OrderReceivedDetailsScreen(
    //                   orderID: int.parse(
    //                       message.data['order_id'].toString()),
    //                 )))
    //                 .whenComplete(getDashbaordDetails);
    //           });
    //         } else if (message.data['notification_type'] != null) {
    //           SchedulerBinding.instance.addPostFrameCallback((_) {
    //             Navigator.of(GlobalVariable.navState.currentContext)
    //                 .push(MaterialPageRoute(
    //                 builder: (context) => ReviewHistoryScreen()))
    //                 .whenComplete(getDashbaordDetails);
    //           });
    //         }
    //       }
    //     }
    //   });
    // }
  }

  @override
  void initState() {
    initNotification();
    fetchProfile();
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
                Text(
                  greeting,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  userName,
                  style: mTextStyle20(),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                print('owner status is $owner_status');
                if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                        !is_profile_updated_first_time) ||
                    owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                    (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                        !is_profile_updated_first_time)) {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                          builder: (BuildContext context) => const Profile()))
                      .then((value) {
                    if (value == "true") {
                      setState(() {
                        fetchData();
                      });
                    }
                  });
                } else {
                  showInReviewMessage(owner_status);
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePhoto),
              ),
            ),
          ],
        ),
      ),
      body: UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
          await fetchProfile();
          await fetchData();
        },
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 105,
              child: Stories(
                photoUrl: profilePhoto,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Divider(
            //   color: Colors.grey,
            //   height: 1,
            //   thickness: 1,
            //   indent: 16,
            //   endIndent: 16,
            // ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("key_Quick_Link".tr, style: mTextStyle20()),
                  GestureDetector(
                    onTap: () {
                      if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                              !is_profile_updated_first_time) ||
                          owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                          (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                              !is_profile_updated_first_time)) {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    const Profile()));
                      } else {
                        showInReviewMessage(owner_status);
                      }
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
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const YourOrders()))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                                  './assets/images/dashboard/food.png',
                                  width: 50,
                                  height: 50,
                                ),
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
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const YourMenus()))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                                  './assets/images/dashboard/menu.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'key_Menu'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const Profile()));
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                                Text(
                                  'key_other'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
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
                      if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                              !is_profile_updated_first_time) ||
                          owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                          (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                              !is_profile_updated_first_time)) {
                        Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    const YourMenus()))
                            .then((value) {
                          if (value == "true") {
                            setState(() {
                              fetchData();
                            });
                          }
                        });
                      } else {
                        showInReviewMessage(owner_status);
                      }
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
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const CreateMenu1(type: 1)))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                              child: SizedBox(
                                width: 150,
                                child: Text("key_Create_Text_Menu".tr,
                                    overflow: TextOverflow.clip,
                                    style: cardTextStyle20()),
                              ),
                            ),
                          ),
                        ), //
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const CreateMenu1(type: 2)))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                              child: SizedBox(
                                width: 150,
                                child: Text("key_Create_Image_Menu".tr,
                                    style: cardTextStyle20()),
                              ),
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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("$totalMenu", style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_Your_Menus'.tr,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("$totalMenuItem", style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_Items_In_Menu'.tr,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('$theme', style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_My_Menu_Designs'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
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
                if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                        !is_profile_updated_first_time) ||
                    owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                    (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                        !is_profile_updated_first_time)) {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              const YourOrders()))
                      .then((value) {
                    if (value == "true") {
                      setState(() {
                        fetchData();
                      });
                    }
                  });
                } else {
                  showInReviewMessage(owner_status);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("key_Your_Orders".tr, style: mTextStyle20()),
                    InkWell(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const YourOrders()))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                  !is_profile_updated_first_time) ||
                              owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                              (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                  !is_profile_updated_first_time)) {
                            Navigator.of(context, rootNavigator: true)
                                .push(CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const YourOrders()))
                                .then((value) {
                              if (value == "true") {
                                setState(() {
                                  fetchData();
                                });
                              }
                            });
                          } else {
                            showInReviewMessage(owner_status);
                          }
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
                              child: SizedBox(
                                width: 150,
                                child: Text("key_view_orders".tr,
                                    overflow: TextOverflow.clip,
                                    style: cardTextStyle20()),
                              ),
                            ),
                          ),
                        ),
                      ), //
                    ),
                    InkWell(
                      onTap: () {
                        if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                !is_profile_updated_first_time) ||
                            owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                            (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                !is_profile_updated_first_time)) {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const OrderHistory()))
                              .then((value) {
                            if (value == "true") {
                              setState(() {
                                fetchData();
                              });
                            }
                          });
                        } else {
                          showInReviewMessage(owner_status);
                        }
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
                              child: SizedBox(
                                width: 170,
                                child: Text("key_view_received_orders".tr,
                                    overflow: TextOverflow.clip,
                                    style: cardTextStyle20()),
                              ),
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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('$todayOrder', style: cTextStyle36()),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'key_Today'.tr,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('$tommorrowOrder', style: cTextStyle36()),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'key_Tomorrow'.tr,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('$laterOrder', style: cTextStyle36()),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'key_Later'.tr,
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
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
                      if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                              !is_profile_updated_first_time) ||
                          owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                          (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                              !is_profile_updated_first_time)) {
                        Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    EarningSummary(
                                        week: earningWeek,
                                        month: earningMonth,
                                        total: earningSummary)))
                            .then((value) {
                          if (value == "true") {
                            setState(() {
                              fetchData();
                            });
                          }
                        });
                      } else {
                        showInReviewMessage(owner_status);
                      }
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
                if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                        !is_profile_updated_first_time) ||
                    owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                    (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                        !is_profile_updated_first_time)) {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                          builder: (BuildContext context) => EarningSummary(
                              week: earningWeek,
                              month: earningMonth,
                              total: earningSummary)))
                      .then((value) {
                    if (value == "true") {
                      setState(() {
                        fetchData();
                      });
                    }
                  });
                } else {
                  showInReviewMessage(owner_status);
                }
              },
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                              './assets/images/dashboard/Rectangle 39389-1.png'),
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 150,
                            child: Text("key_Earning_Summary".tr,
                                style: cardTextStyle20()),
                          ),
                        ),
                      ),
                    ), //
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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('₹$earningWeek',
                                    overflow: TextOverflow.ellipsis,
                                    style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_This_Week'.tr,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('₹$earningMonth',
                                    overflow: TextOverflow.ellipsis,
                                    style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_This_Month'.tr,
                                  style: cTextStyle18(),
                                  overflow: TextOverflow.ellipsis,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('₹$earningSummary',
                                    overflow: TextOverflow.ellipsis,
                                    style: cTextStyle36()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'key_Total'.tr,
                                  style: cTextStyle18(),
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            )),
                      ),
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
