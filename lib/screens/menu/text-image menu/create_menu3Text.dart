import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/apiServices/api_service.dart';
import '../../../utils/sharedpreferences.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/theme_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'menuIdController.dart';

class CreateTextMenu3 extends StatefulWidget {
  const CreateTextMenu3({Key? key}) : super(key: key);
  @override
  State<CreateTextMenu3> createState() => _CreateTextMenu3State();
}

class _CreateTextMenu3State extends State<CreateTextMenu3> {
  int refreshCounter = 0;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  var menuId;

  List menuList = [];

  Future<void> Menu() async {
    String token = await Sharedprefrences.getToken();
    String? ownerId = await Sharedprefrences.getId();
    final response =
        await http.post(Uri.parse('$baseUrl/get-menu-item'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'menu_id': menuId.toString(),
      'category_id': '1',
      'business_owner_id': ownerId
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      menuList = (json['data'][1]['data']);
      // print(menuList);
    } else if(response.statusCode == 401) {
      print("refresh token called");if (refreshCounter == 0) {
        refreshCounter++;
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ? Menu() : null;}
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
    }
  }

  Future<void> UpdateMenu() async {
    debugPrint("this is menuid$menuId");
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse('$baseUrl/create-or-update-menu'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
          'is_menu_completed':'1',
      'id': menuId.toString(),
          "type": '1'
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      //menuList = (json['data'][1]['data']);
      print(json['message']);
      return ScaffoldSnackbar.of(context).show(json['message']);

    } else if(response.statusCode == 401) {
      print("refresh token called");if (refreshCounter == 0) {
        refreshCounter++;
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ? UpdateMenu() : null;}
    }else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      return ScaffoldSnackbar.of(context).show(json['message']);
      // print(json['message']);
    }
  }

  // function getMessage(){
  //   String message;
  //   List messages=[];
  //    for(int i=0;i<menuList.length;i++){
  //      messages.add("MENU & PRICE\n🍛 ${menuList[i]['name']}: ₹ ${menuList[i]['amount']} 💰,");
  //    }
  //
  // }

  @override
  void initState() {
    super.initState();
    Menu();
    final MenuIdController menuIdController = Get.find<MenuIdController>();
    menuId = menuIdController.menuId;
    // print("menuid $menuId");
    UpdateMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          leading:  BackButton(
            onPressed:() => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          elevation: 0,
          backgroundColor: backgroundColor(),
          title: Text(
            'key_Create_Text_Menu'.tr,
            style: cardTitleStyle20(),
          ),
        ),
        body: FutureBuilder(
            future: Menu(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "key_Create_Text_Menu".tr,
                          style: mTextStyle20(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(53, 56, 66, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 45,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'key_step1'.tr,
                                    style: mTextStyle16(),
                                  )),
                            ),
                          ),

                          Card(
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(53, 56, 66, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 45,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'key_step2'.tr,
                                    style: mTextStyle16(),
                                  )),
                            ),
                          ),

                          Card(
                            shadowColor: Colors.black,
                            color: orangeColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 45,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'key_step3'.tr,
                                    style: mTextStyle16(),
                                  )),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: menuList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                        shadowColor: Colors.black,
                                        color: cardColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.all(8),
                                            child: Row(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  menuList[index]['picture'],
                                                  height: 90,
                                                  width: 95,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          menuList[index]
                                                              ['name'],
                                                          style: mTextStyle20(),
                                                        ),
                                                        Text(
                                                          '₹ ${menuList[index]['amount']}',
                                                          style: cTextStyle18(),
                                                        )
                                                      ]))
                                            ]))));
                              })),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          dynamic id = await Sharedprefrences.getId();
                          var fullName = await Sharedprefrences.getFullName();
                          var menuName = await Sharedprefrences.getMenuName();
                          var profileImage = await Sharedprefrences.getProfilePic();
                          var parameters = DynamicLinkParameters(
                            uriPrefix: "https://tastesonway.page.link",
                            link: Uri.parse(
                                'https://www.tastesonway.com/welcome?menuId=$menuId&buissnessownerId=$id&chefName=$menuName&profileImage=$profileImage'),
                            navigationInfoParameters:
                            const NavigationInfoParameters(
                                forcedRedirectEnabled: true),
                            androidParameters: const AndroidParameters(
                              packageName: 'com.testing.tastesonway.ios.android',
                            ),
                            iosParameters: const IOSParameters(
                                bundleId: 'com.testing.tastesonway.ios',
                                appStoreId: '123456789',
                                minimumVersion: '1.0.0'),
                          );
                          // var dynamicUrl = await parameters.buildUrl();
                          // var shortLink = await parameters.buildShortLink();
                          // var shortUrl = shortLink.shortUrl;
                          final ShortDynamicLink shortLink =
                          await dynamicLinks.buildShortLink(parameters);
                          // final ShortDynamicLink shortLink = await DynamicLinkParameters.shortenUrl(
                          //     Uri.parse('https://example.page.link/?link=https://example.com/&apn=com.example.android&ibn=com.example.ios'),
                          //     DynamicLinkParametersOptions(ShortDynamicLinkPathLength.unguessable),
                          // );

                          var shortUrl = shortLink.shortUrl;
                          await Share.share(
                              "🍴👨‍🍳 MENU BY ${menuList[0]?['business_owner_address']?['office_name']} 👨‍🍳🍴\n\n"
                              "${menuList.map((menu) => "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()} \n\n🔗ℚ𝕦𝕚𝕔𝕜 𝕆𝕣𝕕𝕖𝕣 𝕃𝕚𝕟𝕜 : 👉 $shortUrl 🔗\n\n"
                              "📱 Sent from Tastes on Way app");
                        },
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shadowColor: Colors.black,
                            color: orangeColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    './assets/images/whatsapp.png',
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      'key_Whatsapp'.tr,
                                      style: mTextStyle14(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
