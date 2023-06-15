import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/screens/orders/history/orderhistory.dart';
import 'package:tastesonway/screens/register/language%20screen.dart';
import 'package:tastesonway/screens/review%20history/review_history.dart';
import 'package:tastesonway/screens/edit address/edit_address.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../undermaintenance.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int refreshCounter = 0;
  bool isServicePresent = false;
  String selectedlang = 'Eng';
  var languages = [
    'Eng',
    'हिंदी',
    'ગુજરાતી',
  ];
  late Locale _currentLocale;
  bool ownerAvailable = false;
  String profileRejectMessage = '';
  bool is_profile_updated_first_time = false;
  int owner_status = OWNER_PROFILE_STATUS_IN_REVIEW;
  static int OWNER_PROFILE_STATUS_IN_REVIEW = 1;
  static int OWNER_PROFILE_STATUS_APPROVED = 2;
  static int OWNER_PROFILE_STATUS_REJECTED = 3;
  static int OWNER_PROFILE_STATUS_BLOCKED = 4;

  void getOwnerAvaibility() async {
    const url = "$baseUrl/kitchen-owner-login-registration";

    final tokenResponse = await http.post(Uri.parse(url), body: {
      "language_id": "1",
      "mobile_number": "8487854544",
      "device_token":
          "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
      "device_id": "51689555c4cf988a",
      "platform": "1",
      "gender": "1",
      "referral_code": "a5265bb5",
      "short_code": "IN",
      "country_code": "91"
    });
    if (tokenResponse.statusCode == 200) {
      final json = jsonDecode(tokenResponse.body);
      final data = json['data'][0]['user_availability'];
      ownerAvailable = data == 'true';
      setState(() {});
    } else if (tokenResponse.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? getOwnerAvaibility() : null;
      }
    } else {
      print("failed with:${tokenResponse.statusCode}");
    }
  }

  void updateOwnerAvaibility(int status) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
        Uri.parse("$baseUrl/update-kitchen-owner-availability"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "user_availability": "$status"
        });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Your availability is updated successfully.!')),
      );
      print(data['message']);
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
          tokenRefreshed ? updateOwnerAvaibility(status) : null;
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something Went Wrong Please Try Again!')),
      );
      throw Exception('Failed to fetch data from API');
    }
  }

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
    super.initState();
    getOwnerAvaibility();
    _getCurrentLocale();
    getInfo();
  }

  Future<void> _getCurrentLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    String? countryCode = prefs.getString('country');
    if (languageCode != null) {
      setState(() {
        _currentLocale = Locale(languageCode, countryCode);
      });
    }
  }

  Future<void> _setLanguagePreference(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    await prefs.setString('country', locale.countryCode ?? '');
    Get.updateLocale(locale); // update the app's localization
    setState(() {}); // update the app's UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Settings'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
          getOwnerAvaibility();
          _getCurrentLocale();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'key_Start_receiving_orders'.tr,
                          textAlign: TextAlign.center,
                          style: inputTextStyle16(),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                            thumbColor: Colors.black,
                            activeColor: Colors.green,
                            value: ownerAvailable,
                            onChanged: (bool? value) {
                              if ((owner_status ==
                                          OWNER_PROFILE_STATUS_IN_REVIEW &&
                                      !is_profile_updated_first_time) ||
                                  owner_status ==
                                      OWNER_PROFILE_STATUS_APPROVED ||
                                  (owner_status ==
                                          OWNER_PROFILE_STATUS_REJECTED &&
                                      !is_profile_updated_first_time)) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: cardColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        title: Text(
                                            !ownerAvailable
                                                ? 'key_Start_receiving_orders'
                                                    .tr
                                                : 'key_Kitchen_Closed'.tr,
                                            style: cardTextStyle18()),
                                        content: Text(
                                            !ownerAvailable
                                                ? 'key_Are_you_sure_you_want_to_open_your_Kitchen'
                                                    .tr
                                                : 'key_You_can_reopen_the_kitchen'
                                                    .tr,
                                            style: mTextStyle14()),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: fontColor(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: Text('key_CANCEL'.tr,
                                                style: mTextStyle14()),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: orangeColor(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: Text(
                                              !ownerAvailable
                                                  ? 'key_Yes_Start'.tr
                                                  : 'key_Yes_Close'.tr,
                                              style: mTextStyle14(),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                              setState(() {
                                                ownerAvailable =
                                                    !ownerAvailable;
                                              });
                                              updateOwnerAvaibility(
                                                  ownerAvailable ? 1 : 2);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                showInReviewMessage(owner_status);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                                const EditAddress()));
                  } else {
                    showInReviewMessage(owner_status);
                  }
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'key_Change_Address'.tr,
                          style: inputTextStyle16(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'key_You_can_Change'.tr,
                          style: inputTextStyle16(),
                        ),
                        DropdownButton(
                          underline: const SizedBox(),
                          value: selectedlang,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(255, 114, 105, 1),
                          ),
                          items: languages.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: cardTextStyle16(),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedlang = newValue!;
                            });
                            selectedlang == "Eng"
                                ? await _setLanguagePreference(
                                    const Locale('en', 'US'))
                                : newValue == "हिंदी"
                                    ? await _setLanguagePreference(
                                        const Locale('hi', 'IN'))
                                    : await _setLanguagePreference(
                                        const Locale('gj', 'IN'));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                                const OrderHistory()));
                  } else {
                    showInReviewMessage(owner_status);
                  }
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'key_Recived_Orders'.tr,
                          style: inputTextStyle16(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                                const ReviewHistory()));
                  } else {
                    showInReviewMessage(owner_status);
                  }
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'key_Reviews_History'.tr,
                          style: inputTextStyle16(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: cardColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title:
                              Text('key_Logout'.tr, style: cardTextStyle18()),
                          content: Text('key_are_you_sure_logout'.tr,
                              style: mTextStyle14()),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: fontColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child:
                                  Text('key_CANCEL'.tr, style: mTextStyle14()),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: orangeColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                'key_Proceed'.tr,
                                style: mTextStyle14(),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close the dialog
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const LanguageScreen()),
                                        (route) => false);
                                Fluttertoast.showToast(
                                  msg: "key_logout_success".tr,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                          ],
                        );
                      });
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'key_Logout'.tr,
                          style: inputTextStyle16(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
