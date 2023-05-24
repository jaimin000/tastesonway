import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../../utils/theme_data.dart';
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
  bool isLoading = true;

  Future fetchMenu() async {
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
      print(menuList);
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchMenu() : null;
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

  @override
  void initState() {
    fetchMenu();
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            step = 0;
                          });
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
                          setState(() {
                            step = 1;
                          });
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
                Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.67,
                        child: ListView.builder(
                          itemCount: menuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      shadowColor: Colors.black,
                                      color: cardColor(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (menuList[index]['name']).toString().toUpperCase(),
                                                  style: cTextStyle20(),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:30,
                                                      width:30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(4.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${menuList[index]['menu_item_count']}',
                                                          style: cardTextStyle16(),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      'Items',
                                                      style: mTextStyle16(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.remove_red_eye_rounded,size: 20,),
                                                    SizedBox(width: 20,),
                                                    Icon(Icons.share,size: 20,),
                                                  ],
                                                ),
                                                Text(
                                                  menuList[index]['menu_review_status'] == 1?'Pending':menuList[index]['menu_review_status'] == 2?'Approved':'Rejected',
                                                  style: cardTextStyle16(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )

                                  ));
                            }),
                      ),

                    ]))
              ]));
  }
}
