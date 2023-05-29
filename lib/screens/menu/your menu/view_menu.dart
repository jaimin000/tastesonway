import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/models/MenuItemModel.dart';
import 'package:tastesonway/screens/menu/your%20menu/edit%20menu%20item.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import '../../../apiServices/api_service.dart';
import '../../../utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'add_menu_item.dart';

class ViewMenu extends StatefulWidget {
  final int menuId;
  final int status;
  final String menuName;
  final String date;
  final String type;
  ViewMenu({required this.menuId,required this.status, required this.menuName, required this.date, required this.type});

  @override
  State<ViewMenu> createState() => _ViewMenuState();
}

class _ViewMenuState extends State<ViewMenu> {
  int refreshCounter = 0;
  bool isPermanentMenu = true;
  bool isLoading = true;
  List<MenuItemModel> menuItemList = [];
  late List<dynamic> menuData = [];
  int? menuId;
  int type = 1;
  late String menuName;
  List<String> menuItemId = [];
  int isPermanent = 1;
  bool isEditable = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController menuNameController = TextEditingController();
  DateTime menuExpiryDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: menuExpiryDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null && picked != menuExpiryDate) {
      setState(() {
        menuExpiryDate = picked;
        // print(DateFormat('yyyy-MM-dd').format(menuExpiryDate));
      });
    }
  }

  DateTime FormateDate(String dateString) {
    List<String> dateParts = dateString.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  Future<void> getMenuItem() async {
    String token = await Sharedprefrences.getToken();
    String? ownerId = await Sharedprefrences.getId();
    final response = await http.post(
      Uri.parse('$baseUrl/get-menu-item'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'business_owner_id': ownerId,
        "menu_id": widget.menuId.toString(),
        "category_id": "1"
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      menuData = json['data'][1]['data'];
      for (int i = 0; i < menuData.length; i++) {
        menuItemList.add(MenuItemModel(
          id: menuData[i]['id'],
          menu_id: menuData[i]['menu_id'],
          name: menuData[i]['name'],
          type: menuData[i]['type'],
          price: menuData[i]['amount'],
          image: menuData[i]['picture'],
          description: menuData[i]['description'] ?? "",
          toppingName: menuData[i]['toppingName'] ?? "",
          //     for (int j = 0; i < menuData[i]['item_ingridient'].length; j++) {
          // toppingName: menuData[i]['item_ingridient'][j]['name'] ?? "",
          // toppingPrice: menuData[i]['item_ingridient'][j]['price'] ?? "",
          // }
        ));
        print(" menuData : $menuData");
      }
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? getMenuItem() : null;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteMenuItem(String id) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/delete-menu'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "menu_id": id,
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json['message']);
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? deleteMenuItem(widget.menuId.toString()) : null;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future EditMenu(String id,int type) async  {
    String token = await Sharedprefrences.getToken();
    final url = Uri.parse(
        "$baseUrl/create-or-update-menu");
    final headers= {'Authorization': 'Bearer $token'};
    final body=  isPermanent == 2 ? {
      "id": id,
      "is_menu_completed": "1",
      "is_permanent_menu": "$isPermanent",
      "menu_review_status": "1",
      "name": menuNameController.text.toString(),
      "type": "$type",
      "date_of_menu" : DateFormat('yyyy-MM-dd').format(menuExpiryDate)
    }: {
      "id": id,
      "is_menu_completed": "1",
      "is_permanent_menu": "$isPermanent",
      "menu_review_status": "1",
      "type": "$type",
      "name": menuNameController.text.toString(),
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json['message']);
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
              content: Text(json['message'])),
        );
      }
      else if(response.statusCode == 401) {
        print("refresh token called");if (refreshCounter == 0) {
          refreshCounter++;
          bool tokenRefreshed = await getNewToken(context);
          tokenRefreshed ?EditMenu(id,type):null;}
      }
      else {
        final json = jsonDecode(response.body);
        print('Request failed with status: ${response.statusCode}.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(json['message'])),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    getMenuItem();
    menuId = widget.menuId;
    menuNameController.text = widget.menuName;
    widget.status == 2 ? isPermanentMenu = false : true;
    menuExpiryDate = FormateDate(widget.date.toString());
    type = widget.type == 'Image'? 2 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_View_menu'.tr,
          style: cardTitleStyle20(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "true");
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          isEditable
              ? IconButton(
                  onPressed: () async {
                    await deleteMenuItem(widget.menuId.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Menu Deleted Successfully!')),
                    );
                    Navigator.pop(context, "true");
                  },
                  icon: const Icon(Icons.delete),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isEditable = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeColor(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'key_Basic_Details'.tr,
                                style: mTextStyle18(),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    enabled: isEditable,
                                    controller: menuNameController,
                                    style: const TextStyle(
                                        color: Colors.white), //<-- SEE HERE
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      fillColor: inputColor(),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'key_Name_your_menu'.tr,
                                      hintStyle: inputTextStyle16(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'key_Please_enter_MenuName'.tr;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      // menuName = value!;
                                      // print(menuName);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'key_this_is_permanent_menu'.tr,
                                          textAlign: TextAlign.center,
                                          style: inputTextStyle16(),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                            thumbColor: Colors.black,
                                            activeColor: orangeColor(),
                                            value: isPermanentMenu,
                                            onChanged: (bool? value) {
                                              isEditable ?
                                              setState(() {
                                                isPermanentMenu =
                                                    value ?? false;
                                                isPermanentMenu == true
                                                    ? isPermanent = 1
                                                    : isPermanent = 2;
                                                print(isPermanent);
                                              }):null;
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (!isPermanentMenu)
                                InkWell(
                                  onTap: () {
                                    isEditable ? _selectDate(context) : null;
                                  },
                                  child: SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(37, 40, 48, 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(menuExpiryDate),
                                          style: inputTextStyle16(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (!isPermanentMenu)
                                const SizedBox(
                                  height: 10,
                                ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'key_Dishes_in_the_menu'.tr,
                                    style: mTextStyle18(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isEditable ?
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddMenuItem(
                                                  menuId: widget.menuId,
                                                )),
                                      ).then((value) {
                                        if (value == "true") {
                                          setState(() {
                                            getMenuItem();
                                          });
                                        }
                                      }) : null;
                                    },
                                    child: Card(
                                      shadowColor: Colors.black,
                                      color: orangeColor(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: SizedBox(
                                        width: 100,
                                        height: 35,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'key_ADD_ITEM'.tr,
                                              style: mTextStyle14(),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
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
                                    isLoading
                                        ? SizedBox(
                                            height: 150,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: orangeColor())))
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: ListView.builder(
                                                itemCount: menuItemList.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    height: 80,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                child: Text(
                                                                  menuItemList[
                                                                          index]
                                                                      .name
                                                                      .toUpperCase(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      mTextStyle16(),
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                child: Text(
                                                                  "₹ ${menuItemList[index].price}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      mTextStyle14(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            isEditable ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditMenuItem(
                                                                  id: menuItemList[
                                                                          index]
                                                                      .id,
                                                                  menu_id: menuItemList[
                                                                          index]
                                                                      .menu_id,
                                                                  name: menuItemList[
                                                                          index]
                                                                      .name,
                                                                  type: menuItemList[
                                                                          index]
                                                                      .type
                                                                      .toString(),
                                                                  price: menuItemList[
                                                                          index]
                                                                      .price,
                                                                  description:
                                                                      menuItemList[
                                                                              index]
                                                                          .description,

                                                                )
                                                              ),
                                                            ):null;
                                                          },
                                                          child: Stack(
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                child: Image
                                                                    .network(
                                                                  menuItemList[
                                                                          index]
                                                                      .image,
                                                                  height: 60,
                                                                  width: 65,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      'assets/images/tea.jpg',
                                                                      height:
                                                                          60,
                                                                      width: 65,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 45,
                                                                right: 10,
                                                                child: Card(
                                                                  shadowColor:
                                                                      Colors
                                                                          .black,
                                                                  color:
                                                                      orangeColor(),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 40,
                                                                    height: 20,
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          'key_Edit'
                                                                              .tr,
                                                                          style:
                                                                              mTextStyle14(),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isEditable
                        ? SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                              onTap: () {
                                EditMenu(widget.menuId.toString(),type);
                                // Navigator.pop(context,'true');
                              },
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'key_Proceed'.tr,
                                      style: mTextStyle14(),
                                    ),
                                  )),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
    );
  }
}
