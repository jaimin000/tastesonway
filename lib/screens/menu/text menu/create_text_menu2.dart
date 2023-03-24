import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tastesonway/models/MenuItemModel.dart';
import 'package:tastesonway/screens/menu/text%20menu/add_new_item.dart';
import 'package:tastesonway/screens/menu/text%20menu/create_text_menu3.dart';
import 'package:tastesonway/screens/menu/text%20menu/edit_item.dart';
import '../../../apiServices/ApiService.dart';
import '../../../theme_data.dart';
import 'package:http/http.dart' as http;
import 'menuIdController.dart';

class CreateTextMenu2 extends StatefulWidget {
  const CreateTextMenu2({Key? key}) : super(key: key);
  @override
  State<CreateTextMenu2> createState() => _CreateTextMenu2State();
}

class _CreateTextMenu2State extends State<CreateTextMenu2> {
  bool _checkAll = false;
  bool isPermanentMenu = true;
  bool isLoading = false;
  List<MenuItemModel> menuItemList = [];
  late List<dynamic> menuData = [];
  late int menuId;
  List<String> menuItemId = [];
  final List<int> myList = [53, 54];

  Future<void> getMenu() async {
    String token = await getToken();
    int ownerId = await getOwnerId();
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse(
           //'http://192.168.1.26:24/api/v2/get-menu-item'),
          '$devUrl/v2/get-menu-item'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'business_owner_id': '$ownerId'},
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final json = jsonDecode(response.body);
      menuData = json['data'][1]['data'];
      for (int i = 0; i < menuData.length; i++) {
        menuItemList.add(MenuItemModel(
          id: menuData[i]['id'],
          menu_id: menuData[i]['menu_id'],
          name: menuData[i]['name'],
          price: menuData[i]['amount'],
          image: menuData[i]['picture'],
          description: menuData[i]['description'] ?? "",
        //     for (int j = 0; i < menuData[i]['item_ingridient'].length; j++) {
        // toppingName: menuData[i]['item_ingridient'][j]['name'] ?? "",
        // toppingPrice: menuData[i]['item_ingridient'][j]['price'] ?? "",
        // }
        ));
      }
      setState(() {
      });
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> AddMultipleMenuId() async{
    String token = await getToken();
    setState(() {
      isLoading = true;
    });
    var data = <String, dynamic>{
      'menu_id': menuId,
      'item_id': menuItemId,
    };
    final response = await http.post(
      Uri.parse('$devUrl/v2/add-multiple-menu-item'),
        headers: <String, String>{
          'Authorization':'Bearer $token',
          'Content-Type':'application/json',
          'accept': 'application/json',
        },
      body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      final json = jsonDecode(response.body);
      print(json['message']);
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
    }
  }

  @override
  void initState() {
    super.initState();
    getMenu();
    final MenuIdController menuIdController = Get.find<MenuIdController>();
    menuId = menuIdController.menuId;
    print("menuid $menuId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Create New Text Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
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
                  "Create Text Menu",
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
                            'Step 1',
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
                            'Step 2',
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
                            'Step 3',
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
                height: 25,
              ),
              Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dishes in the menu',
                              style: mTextStyle18(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddNewItem()),
                                );
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                color: orangeColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SizedBox(
                                  width: 100,
                                  height: 35,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Add New',
                                        style: mTextStyle14(),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                          style: cTextStyle12(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            style:
                                const TextStyle(color: Colors.white), //<-- SEE HERE
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
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          shadowColor: Colors.black,
                          color: inputColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      value: _checkAll,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _checkAll = value ?? false;
                                        });
                                        if (_checkAll == true) {
                                          for (int i = 0;
                                              i < menuItemList.length;
                                              i++) {
                                            menuItemList[i].isChecked = true;
                                            menuItemId.add(menuItemList[i].id.toString());

                                                }
                                        } else {
                                          for (int i = 0;
                                              i < menuItemList.length;
                                              i++) {
                                            menuItemList[i].isChecked = false;
                                            menuItemId.removeAt(i);
                                          }
                                        }
                                        Colors.black;
                                      },
                                      focusColor: orangeColor(),
                                      fillColor: MaterialStateProperty.all(
                                          orangeColor()),
                                      side: BorderSide(
                                        color: orangeColor(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        'Select All',
                                        style: inputTextStyle16(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                              isLoading
                                  ? const SizedBox(
                                      height: 150,
                                      child: Center(
                                          child: CircularProgressIndicator(color: Colors.red,)))
                                  : SizedBox(
                                height: 400,
                                    child: ListView.builder(
                                        itemCount: menuItemList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 80,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Checkbox(
                                                  value: menuItemList[index]
                                                      .isChecked,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      menuItemList[index]
                                                              .isChecked =
                                                          value ?? false;
                                                      if(menuItemList[index].isChecked){
                                                       menuItemId.add(menuItemList[index].id.toString()
                                                       );
                                                      }else{
                                                       menuItemId.removeAt(index);
                                                      }
                                                      print(menuItemId);
                                                    });
                                                    checkColor:
                                                    Colors.black;
                                                  },
                                                  focusColor: orangeColor(),
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          orangeColor()),
                                                  side: BorderSide(
                                                    color: orangeColor(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          menuItemList[index]
                                                              .name,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              inputTextStyle14(),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          "₹ ${menuItemList[index].price}",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              inputTextStyle14(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Stack(
                                                  clipBehavior: Clip.none, children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.network(
                                                        menuItemList[index].image,
                                                        height: 60,
                                                        width: 65,
                                                        fit: BoxFit.fill,
                                                        errorBuilder:
                                                            (BuildContext context,
                                                                Object exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Image.asset(
                                                            'assets/images/tea.jpg',
                                                            height: 60,
                                                            width: 65,
                                                            fit: BoxFit.fill,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 45,
                                                      right: 10,
                                                      child: InkWell(
                                                        onTap: () async {
                                                         // final result = await
                                                         Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => EditItem(
                                                                      id: menuItemList[index].id,
                                                                      menu_id: menuItemList[index].menu_id,
                                                                      name:menuItemList[index].name,
                                                                    price:menuItemList[index].price,
                                                                    description:menuItemList[index].description
                                                                  ),),);
                                                         // print("result $result");
                                                         // if(result == "true"){
                                                         //   getMenu();
                                                         // }
                                                        },
                                                        child: Card(
                                                          shadowColor:
                                                              Colors.black,
                                                          color: orangeColor(),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: SizedBox(
                                                            width: 40,
                                                            height: 20,
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Edit',
                                                                  style:
                                                                      mTextStyle14(),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async{
                             await AddMultipleMenuId();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateTextMenu3()));
                          },
                          child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: orangeColor(),
                                ),
                                child: Center(
                                  child: Text(
                                    'Proceed',
                                    style: mTextStyle14(),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
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
      ),
    );
  }
}