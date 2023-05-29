import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tastesonway/screens/menu/your%20menu/view_menu.dart';
import '../../../apiServices/api_service.dart';
import '../../../utils/sharedpreferences.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class YourMenus extends StatefulWidget {
  const YourMenus({Key? key}) : super(key: key);

  @override
  State<YourMenus> createState() => _YourMenusState();
}

class _YourMenusState extends State<YourMenus> {
  int step = 0;
  int refreshCounter = 0;
  List menuList = [];
  List menuItemList = [];
  List filteredMenuList = [];
  bool isLoading = true;

  Future fetchMenu(int step) async {
    String token = await Sharedprefrences.getToken();
    String? ownerId = await Sharedprefrences.getId();
    final response =
        await http.post(Uri.parse("$baseUrl/get-owner-menu"), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      "business_owner_id": ownerId,
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      menuList = jsonData['data']['data'];

      step == 0
          ? filteredMenuList =
              menuList.where((data) => data['type'] == 'Text').toList()
          : menuList.where((data) => data['type'] == 'Image').toList();

      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchMenu(0) : null;
      }
    } else {
      final jsonData = json.decode(response.body);
      ScaffoldSnackbar.of(context).show(jsonData['message']);
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getMenuItem(int menuId) async {
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
      menuItemList = (json['data'][1]['data']);
      print(menuItemList);
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? getMenuItem(menuId) : null;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
      setState(() {
        isLoading = false;
      });
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    return formattedDate;
  }

  showTextMenuDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        // useRootNavigator: true,
        builder: (BuildContext context) => AlertDialog(
          content: Stack(
            clipBehavior: Clip.none, children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  backgroundColor: orangeColor(),
                  child: const Icon(Icons.close),
                ),
              ),
            ),
            SingleChildScrollView(
                child: Container(
                  child: Text(text),
                )),
          ],
          ),
        ));
  }

  Widget buildNoData() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 50,),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/images/dataNotFound.png',
          width: 251,
          height: 221,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'key_Data_Not_Found'.tr,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ],
  );

  @override
  void initState() {
    fetchMenu(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor(),
          title: Text(
            'key_Your_Menus'.tr,
            style: cardTitleStyle20(),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: orangeColor(),
              ))
            : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          step = 0;
                          filteredMenuList = menuList
                              .where((data) => data['type'] == 'Text')
                              .toList();
                          setState(() {});
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: step == 0
                              ? orangeColor()
                              : const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 45,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'key_Text_Menus'.tr,
                                  style: mTextStyle16(),
                                )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          filteredMenuList = menuList
                              .where((data) => data['type'] == 'Image')
                              .toList();
                          step = 1;
                          setState(() {});
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: step == 1
                              ? orangeColor()
                              : const Color.fromRGBO(53, 56, 66, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 45,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'key_Image_Menus'.tr,
                                  style: mTextStyle16(),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          //<-- SEE HERE
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: orangeColor(),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'key_Search_menu_item'.tr,
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      filteredMenuList.isNotEmpty ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.62,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: filteredMenuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return step == 0
                                  ? InkWell(
                                      onTap: () {
                                        String currentDate = getCurrentDate();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewMenu(
                                                  type:filteredMenuList[index]['type'],
                                                      menuName:
                                                          filteredMenuList[
                                                              index]['name'],
                                                      menuId: filteredMenuList[
                                                          index]['id'],
                                                      status: filteredMenuList[
                                                              index]
                                                          ['is_permanent_menu'],
                                                      date: filteredMenuList[
                                                                      index][
                                                                  'date_of_menu'] ==
                                                              null
                                                          ? currentDate
                                                          : filteredMenuList[
                                                                  index]
                                                              ['date_of_menu'],
                                                    ))).then((value) {
                                          if (value == "true") {
                                            setState(() {
                                              fetchMenu(0);
                                            });
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                          height: 140,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                              shadowColor: Colors.black,
                                              color: cardColor(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (filteredMenuList[
                                                                      index]
                                                                  ['name'])
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: cTextStyle20(),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${filteredMenuList[index]['menu_item_count']}',
                                                                  style:
                                                                      cardTextStyle16(),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'Items',
                                                              style:
                                                                  mTextStyle16(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                      getMenuItem(
                                                                          filteredMenuList[
                                                                          index]
                                                                          ['id']);
                                                                      String text = "🍴👨‍🍳 MENU BY ${menuItemList[0]?['business_owner_address']?['office_name']} 👨‍🍳🍴\n\n"
                                                                          "${menuItemList.map((menu) => "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()}"
                                                                          "📱 Sent from Tastes on Way app";
                                                                      showTextMenuDialog(context,text);
                                                                    },
                                                                child: const Icon(
                                                                    Icons
                                                                        .remove_red_eye_sharp)),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            filteredMenuList[index]['menu_review_status'].toString() == '1' ?
                                                            SizedBox() : GestureDetector(
                                                              onTap: () async {
                                                                setState(() {
                                                                  isLoading = true;
                                                                });
                                                                await getMenuItem(
                                                                    filteredMenuList[
                                                                            index]
                                                                        ['id']);
                                                                await Share.share(
                                                                    "🍴👨‍🍳 MENU BY ${menuItemList[0]?['business_owner_address']?['office_name']} 👨‍🍳🍴\n\n"
                                                                    "${menuItemList.map((menu) => "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()}"
                                                                    "📱 Sent from Tastes on Way app");
                                                              },
                                                              child: const Icon(
                                                                Icons.share,
                                                                size: 20,
                                                              ),
                                                            )
                                                            ,
                                                          ],
                                                        ),
                                                        Text(
                                                          filteredMenuList[
                                                                          index]
                                                                      [
                                                                      'menu_review_status'] ==
                                                                  1
                                                              ? 'Pending'
                                                              : filteredMenuList[
                                                                              index]
                                                                          [
                                                                          'menu_review_status'] ==
                                                                      2
                                                                  ? 'Approved'
                                                                  : 'Rejected',
                                                          style:
                                                              cardTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        String currentDate = getCurrentDate();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewMenu(
                                                  type:filteredMenuList[index]['type'],
                                                      menuName:
                                                          filteredMenuList[
                                                              index]['name'],
                                                      menuId: filteredMenuList[
                                                          index]['id'],
                                                      status: filteredMenuList[
                                                              index]
                                                          ['is_permanent_menu'],
                                                      date: filteredMenuList[
                                                                      index][
                                                                  'date_of_menu'] ==
                                                              null
                                                          ? currentDate
                                                          : filteredMenuList[
                                                                  index]
                                                              ['date_of_menu'],
                                                    ))).then((value) {
                                          if (value == "true") {
                                            setState(() {
                                              fetchMenu(1);
                                            });
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                          height: 160,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                              shadowColor: Colors.black,
                                              color: cardColor(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (filteredMenuList[
                                                                      index]
                                                                  ['name'])
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: cTextStyle18(),
                                                        ),
                                                        SizedBox(
                                                            height: 90,
                                                            width: 140,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.network(
                                                                "${filteredMenuList[index]['image_menu_link'][0]}",
                                                                height: 90,
                                                                width: 140,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                      getMenuItem(
                                                                          filteredMenuList[
                                                                          index]
                                                                          ['id']);
                                                                      String text = "🍴👨‍🍳 MENU BY ${menuItemList[0]?['business_owner_address']?['office_name']} 👨‍🍳🍴\n\n"
                                                                          "${menuItemList.map((menu) => "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()}"
                                                                          "📱 Sent from Tastes on Way app";
                                                                      showTextMenuDialog(context,text);
                                                                    },
                                                                child: const Icon(
                                                                    Icons
                                                                        .remove_red_eye_sharp)),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            filteredMenuList[index]['menu_review_status'].toString() == '1' ?
                                                            SizedBox() : GestureDetector(
                                                              onTap: () async {
                                                                setState(() {
                                                                  isLoading = true;
                                                                });
                                                                print(filteredMenuList[
                                                                index]
                                                                ['id']);
                                                                await getMenuItem(
                                                                    filteredMenuList[
                                                                    index]
                                                                    ['id']);
                                                                await Share.share(
                                                                    "🍴👨‍🍳 MENU BY ${menuItemList[0]?['business_owner_address']?['office_name']} 👨‍🍳🍴\n\n"
                                                                        "${menuItemList.map((menu) => "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()}"
                                                                        "📱 Sent from Tastes on Way app");
                                                              },
                                                              child: const Icon(
                                                                Icons.share,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${filteredMenuList[index]['menu_item_count']}',
                                                                  style:
                                                                      cardTextStyle16(),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'Items',
                                                              style:
                                                                  mTextStyle16(),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          filteredMenuList[
                                                                          index]
                                                                      [
                                                                      'menu_review_status'] ==
                                                                  1
                                                              ? 'Pending'
                                                              : filteredMenuList[
                                                                              index]
                                                                          [
                                                                          'menu_review_status'] ==
                                                                      2
                                                                  ? 'Approved'
                                                                  : 'Rejected',
                                                          style:
                                                              cardTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ))),
                                    );
                            }),
                      ) : buildNoData(),
                    ]))
              ]));
  }
}
