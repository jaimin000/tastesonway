import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../../apiServices/api_service.dart';
import '../../../models/MenuItemModel.dart';
import '../../../utils/sharedpreferences.dart';
import '../../undermaintenance.dart';
import '../your menu/edit menu item.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  int refreshCounter = 0;
  String searchQuery = '';
  bool _isLoading = true;
  bool isServicePresent = false;
  late List<dynamic> menuData = [];
  List<MenuItemModel> menuItemList = [];

  Future getMenuItem() async {
    String? ownerId = await Sharedprefrences.getId();
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse('$baseUrl/get-menu-item'), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'business_owner_id': ownerId,
    });
    if (response.statusCode == 200) {
      _isLoading = false;
      final Map<String, dynamic> data = json.decode(response.body);
      menuData = data['data'][1]['data'];
      for (int i = 0; i < menuData.length; i++) {
        menuItemList.add(MenuItemModel(
          id: menuData[i]['id'],
          menu_id: menuData[i]['menu_id'],
          name: menuData[i]['name'],
          type: menuData[i]['type'],
          price: menuData[i]['amount'],
          image: menuData[i]['picture'],
          description: menuData[i]['description'] ?? "",

        ));
      }
      setState(() {});
    } else if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      if (jsonData['message']
          .toString()
          .contains('maintenance')) {
        print('server is undermaintenance');
        setState(() {
          isServicePresent = true;
        });
      }
      else if(!isServicePresent) {
        print("refresh token called");
        if (refreshCounter == 0) {
          refreshCounter++;
          bool tokenRefreshed = await getNewToken(context);
          tokenRefreshed ? getMenuItem(): null;
        }
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget buildNoData() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 150,),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/dataNotFound.png',
            width: 251,
            height: 221,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'key_Data_Not_Found'.tr,
          style: mTextStyle16(),
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    getMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor(),
          title: Text(
            'List of Items',
            style: cardTitleStyle20(),
          ),
        ),
        body: _isLoading? Center(
          child: CircularProgressIndicator(
            color: orangeColor(),
          ),
        ) :
        UnderMaintenanceWidget(
          isShow: isServicePresent,
          callback: () async {
            await getMenuItem();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(

                    children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        style: const TextStyle(color: Colors.white), //<-- SEE HERE
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
                          hintText: 'Search Menu Items',
                          hintStyle: inputTextStyle16(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                          });
                        },
                      ),
                    ),
                  ),
                  menuItemList.isNotEmpty ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: menuItemList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (searchQuery.isNotEmpty && !menuItemList[index].name.toLowerCase().contains(searchQuery)) {
                          return Container(); // Skip rendering if the item doesn't match the search query
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditMenuItem(
                                    id: menuItemList[index].id,
                                    menu_id: menuItemList[index].menu_id,
                                    name:menuItemList[index].name,
                                    type:menuItemList[index].type.toString(),
                                    price:menuItemList[index].price,
                                    description:menuItemList[index].description,
                                  )),
                            ).then((value) {
                              setState(() {
                                if (value == "true") {
                                  setState(() {
                                    menuItemList = [];
                                    menuData=[];
                                    getMenuItem();
                                  });
                                }
                              });
                            });
                          },
                          child: Column(children: [
                            const SizedBox(height: 10),
                            SizedBox(
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
                                        child: Row(children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.network(
                                              menuItemList[index].image,
                                              height: 100,
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
                                                      menuItemList[index]
                                                          .name,
                                                      style: mTextStyle20(),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(
                                                      '₹ ${menuItemList[index].price}',
                                                      style: cTextStyle18(),
                                                    )
                                                  ]))
                                        ]))))
                          ]),
                        );
                      }):buildNoData(),
                ])),
          ),
        ));
  }
}
