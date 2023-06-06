import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/menu/text-image%20menu/create_menu2.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import '../../../apiServices/api_service.dart';
import '../../../utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../undermaintenance.dart';
import 'menuIdController.dart';

class CreateMenu1 extends StatefulWidget {
  final int type;

  const CreateMenu1({Key? key, required this.type}) : super(key: key);

  @override
  State<CreateMenu1> createState() => _CreateMenu1State();
}

class _CreateMenu1State extends State<CreateMenu1> {
  int type = 1;
  int refreshCounter = 0;
  bool isPermanentMenu = true;
  late String menuName;
  late int menuId;
  final _formKey = GlobalKey<FormState>();
  DateTime menuExpiryDate = DateTime.now();
  bool _isLoading = false;
  late int apiId;
  int isPermanent = 1;
  final menuIdController = Get.put(MenuIdController());
  bool isServicePresent = false;

  Future getMenuId() async {
    print(DateFormat('dd-MM-yyyy').format(menuExpiryDate));
    String token = await Sharedprefrences.getToken();
    final url = Uri.parse("$baseUrl/create-or-update-menu");
    final headers = {'Authorization': 'Bearer $token'};
    final body = isPermanent == 2
        ? {
            "is_menu_completed": "1",
            "is_permanent_menu": "$isPermanent",
            "menu_review_status": "1",
            "name": menuName,
            "type": "type",
            "date_of_menu": DateFormat('yyyy-MM-dd').format(menuExpiryDate)
          }
        : {
            "is_menu_completed": "1",
            "is_permanent_menu": "$isPermanent",
            "menu_review_status": "1",
            "name": menuName,
            "type": "type",
          };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        menuId = json['data']['id'];
        return menuId;
      } else if (response.statusCode == 401) {
        final jsonData = json.decode(response.body);
        if (jsonData['message'].toString().contains('maintenance')) {
          print('server is undermaintenance');
          setState(() {
            isServicePresent = true;
          });
        } else {
          print("refresh token called");
          if (refreshCounter == 0) {
            refreshCounter++;
            bool tokenRefreshed = await getNewToken(context);
            tokenRefreshed ? getMenuId() : null;
          }
        }
      } else {
        //  AlertDialog(
        //   title: Text('Error'),
        //   content: Text('Failed to load data'),
        // );
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: menuExpiryDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: orangeColor(),
            brightness: Brightness.light,
            onPrimary: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: orangeColor(), // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
    );
    if (picked != null && picked != menuExpiryDate) {
      setState(() {
        menuExpiryDate = picked;
        // print(DateFormat('yyyy-MM-dd').format(menuExpiryDate));
      });
    }
  }

  @override
  void initState() {
    type = widget.type;
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
          type == 1 ? 'key_Create_Text_Menu'.tr : 'key_Create_Image_Menu'.tr,
          style: cardTitleStyle20(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "true");
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeColor(),
              ),
            )
          : UnderMaintenanceWidget(
              isShow: isServicePresent,
              callback: () async {
                await getMenuId();
              },
              child: SingleChildScrollView(
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
                          type == 1
                              ? 'key_Create_Text_Menu'.tr
                              : 'key_Create_Image_Menu'.tr,
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
                        height: 25,
                      ),
                      Card(
                        shadowColor: Colors.black,
                        color: cardColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          // height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'key_Basic_Details'.tr,
                                  style: mTextStyle18(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      //<-- SEE HERE
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
                                        } else if (RegExp(r'[^\w\s]')
                                            .hasMatch(value)) {
                                          return 'key_Special_characters_not_allowed'
                                              .tr;
                                        }
                                        return null;
                                      },
                                      onSaved: (value) async {
                                        menuName = value!;
                                        await Sharedprefrences.setMenuName(
                                            menuName);
                                        print(menuName);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(37, 40, 48, 1),
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
                                                setState(() {
                                                  isPermanentMenu =
                                                      value ?? false;
                                                  isPermanentMenu == true
                                                      ? isPermanent = 1
                                                      : isPermanent = 2;
                                                  print(isPermanent);
                                                });
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
                                  Text(
                                    'key_When_will_the_Menu_be_Expired'.tr,
                                    style: mTextStyle14(),
                                  ),
                                if (!isPermanentMenu)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (!isPermanentMenu)
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: SizedBox(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              37, 40, 48, 1),
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
                                SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            menuIdController.menuId =
                                                await getMenuId();
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateMenu2(type: type)),
                                            );
                                          } catch (e) {
                                            print(e);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: cardColor(),
                                                  title: Text(
                                                    'key_error'.tr,
                                                    style: TextStyle(
                                                        color: orangeColor()),
                                                  ),
                                                  content:
                                                      Text('key_name_exits'.tr),
                                                  actions: [
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    orangeColor()),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, "true");
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                      },
                                      child: Card(
                                          shadowColor: Colors.black,
                                          color: orangeColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Proceed',
                                              style: mTextStyle14(),
                                            ),
                                          )),
                                    )),
                                const SizedBox(height: 10),
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
            ),
    );
  }
}
