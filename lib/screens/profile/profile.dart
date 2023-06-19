import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
import 'package:tastesonway/screens/menu/menu%20items/menu_items.dart';
import 'package:tastesonway/screens/menu/my_menu_design.dart';
import 'package:tastesonway/screens/setting/setting.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../orders/yourorders.dart';
import '../register/editProfile.dart';
import '../tutorials/tutorials.dart';
import '../bank/banking_details.dart';
import '../undermaintenance.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int refreshCounter = 0;
  String name = "";
  String email = "";
  String pincode = "";
  String profile = "";
  String gender = '1';
  String dob = "";
  bool isServicePresent = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future fetchData() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-kitchen-owner-profile"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(response.body);
      var profileData = jsonData['data'];
      name = profileData['name'];
      email = profileData['email'];
      pincode = profileData['pin_code'].toString();
      profile = profileData['avatar'];
      gender = profileData['gender'].toString();
      dob = profileData['date_of_birth'].toString();
      print(pincode);
      print(dob);
      setState(() {});
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

  bool ownerAvailable = false;
  String profileRejectMessage = '';
  bool is_profile_updated_first_time = false;
  int owner_status = OWNER_PROFILE_STATUS_IN_REVIEW;
  static int OWNER_PROFILE_STATUS_IN_REVIEW = 1;
  static int OWNER_PROFILE_STATUS_APPROVED = 2;
  static int OWNER_PROFILE_STATUS_REJECTED = 3;
  static int OWNER_PROFILE_STATUS_BLOCKED = 4;

  getInfo() async {
    owner_status = await Sharedprefrences.getOwnerStatus();
    is_profile_updated_first_time =
        (await Sharedprefrences.getProfileUpdatedTime())!;
    profileRejectMessage =
        (await Sharedprefrences.getRejectMessage()) as String;
    print(owner_status);
    print(is_profile_updated_first_time);
    print(profileRejectMessage);
  }

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

  @override
  void initState() {
    fetchData();
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor(),
      body: UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
          await fetchData();
        },
        child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: <
            Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                          !is_profile_updated_first_time) ||
                      owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                      (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                          !is_profile_updated_first_time)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPersonalDetail(
                                  profile: profile.toString(),
                                  name: name,
                                  email: email,
                                  gender: gender.toString(),
                                  pincode: pincode.toString(),
                                  dob: dob.toString(),
                                )));
                  } else {
                    showInReviewMessage(owner_status);
                  }
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            ListView(
              clipBehavior: Clip.none,
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
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   color: const Color.fromRGBO(39, 42, 50, 1),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.star_border,
                //             color: fontColor(),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text('4.8(163)', style: cTextStyle12())
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.timer_sharp,
                //             color: fontColor(),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text('20 min', style: cTextStyle12())
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.local_fire_department_outlined,
                //             color: fontColor(),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text('150 kcal', style: cTextStyle12())
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
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
                          if ((owner_status == OWNER_PROFILE_STATUS_IN_REVIEW &&
                                  !is_profile_updated_first_time) ||
                              owner_status == OWNER_PROFILE_STATUS_APPROVED ||
                              (owner_status == OWNER_PROFILE_STATUS_REJECTED &&
                                  !is_profile_updated_first_time)) {
                            Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const DiscountPage()));
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Coupon.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Create_a_Discount_Coupan'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const MyWebsite()));
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Website.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_My_Website'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const Fssai()));
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Fssai.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Fssai_Registration'.tr,
                                textAlign: TextAlign.center,
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
                            Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const BankingDetails()));
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Bank Details.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Bank_Details'.tr,
                                textAlign: TextAlign.center,
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
                            Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const YourOrders()));
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Your Orders.png',
                                height: 65,
                                width: 65,
                              ),
                              Text(
                                'key_Your_Orders'.tr,
                                textAlign: TextAlign.center,
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
                            Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const MenuItems()));
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Menu Items.png',
                                height: 65,
                                width: 65,
                              ),
                              Text(
                                'key_Menu_Items'.tr,
                                textAlign: TextAlign.center,
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
                            Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        const MenuDesign()));
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/My Menu Design.png',
                                height: 45,
                                width: 45,
                              ),
                              Text(
                                'key_My_Menu_Designs'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      Tutorials()));
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/VideoTutorials.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Tutorials'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var parameters = DynamicLinkParameters(
                            uriPrefix: "https://tastesonway.page.link",
                            navigationInfoParameters:
                                const NavigationInfoParameters(
                                    forcedRedirectEnabled: true),
                            link: Uri.parse(
                                'https://www.tastesonway.com/downloadApp'),
                            androidParameters: const AndroidParameters(
                              packageName:
                                  'com.testing.tastesonway.ios.android',
                            ),
                            iosParameters: const IOSParameters(
                                bundleId: 'com.testing.tastesonway.ios.android.ios',
                                appStoreId: '1581955986',
                                minimumVersion: '1.0.0'),
                          );
                          // var shortLink = await parameters.buildShortLink();
                          final ShortDynamicLink shortLink =
                              await dynamicLinks.buildShortLink(parameters);
                          var shortUrl = shortLink.shortUrl;

                          var text =
                              'Hi,\nI request you to check out\nTastes on Way Owner App. I have been using it and I absolutely love it!\n You can download the app from the\nthe link below \n$shortUrl';
                          // await Share.text("Share App", text, "text/plain");
                          await Share.share(text, subject: 'Share App');

                          // Platform.isAndroid
                          //     ? await Share.share("👋 Hey there!\nCheck out the Tastes on Way Owner App! 📱🍽️\nI've been using it and I absolutely love it! 😍\nYou can download it here:\n👉 https://tastesonwayowner.page.link/D4UMk9hpTkTbNXtA6")
                          //     : await Share.share("👋 Hey there!\nCheck out the Tastes on Way Owner App! 📱🍽️\nI've been using it and I absolutely love it! 😍\nYou can download it here:\n👉 https://apps.apple.com/in/app/tastes-on-way-owner/id1581405879");
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/share.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Share_Tastes_on_way'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ContactUs()));

                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Contact Us.png',
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                'key_Contact_Us'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const FAQ()));
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/FAQ.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_FAQ'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const Setting()));
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                './assets/images/profile/Settings.png',
                                height: 55,
                                width: 55,
                              ),
                              Text(
                                'key_Settings'.tr,
                                textAlign: TextAlign.center,
                                style: cTextStyle18(),
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
      ),
    );
  }
}
