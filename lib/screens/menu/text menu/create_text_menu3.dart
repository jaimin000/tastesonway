import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/apiServices/ApiService.dart';
import 'package:tastesonway/main.dart';
import 'package:tastesonway/screens/dashboard/dashboard.dart';
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
  late var menuId;

  List menuList = [];

  Future<void> Menu() async {
    String token = await getToken();
    int ownerId = await getOwnerId();
    final response = await http.post(Uri.parse('$liveUrl/get-menu-item'),
        headers: {
          'Authorization':'Bearer $token',
        },
        body: {
          'menu_id': menuId.toString(),
          'category_id': '1',
          'business_owner_id': ownerId.toString()
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      menuList = (json['data'][1]['data']);
      print(menuList);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
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
    print("menuid $menuId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.popUntil(context, (route) => route.isFirst);
            },
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
                  child: CircularProgressIndicator(color: Colors.redAccent,),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return SingleChildScrollView(
                child:
                  Container(
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            const SizedBox(
                              width: 5,
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
                            const SizedBox(
                              width: 5,
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
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.50,
                          child: ListView.builder(
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            menuList[index]['picture'],
                                            height: 90,
                                            width: 95,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                menuList[index]['name'],
                                                style: mTextStyle20(),
                                              ),
                                              Text(
                                                '₹ ${menuList[index]['amount']}',
                                                style: cTextStyle18(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await Share.share("🍴👨‍🍳 MENU BY ${menuList[0]['business_owner_address']['office_name']} 👨‍🍳🍴\n\n"
                            "${menuList.map((menu) =>
                                "MENU & PRICE\n🍛 ${menu['name']}: ₹ ${menu['amount']} 💰\n\n").join().toString()}"
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
