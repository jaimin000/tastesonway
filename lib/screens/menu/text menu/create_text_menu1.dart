import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/menu/text%20menu/create_text_menu2.dart';
import '../../../apiServices/ApiService.dart';
import '../../../theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'menuIdController.dart';

class CreateTextMenu extends StatefulWidget {
  const CreateTextMenu({Key? key}) : super(key: key);
  @override
  State<CreateTextMenu> createState() => _CreateTextMenuState();
}

class _CreateTextMenuState extends State<CreateTextMenu> {
  bool isPermanentMenu = true;
  late String menuItemName;
  late int menuId;
  final _formKey = GlobalKey<FormState>();
  DateTime menuExpiryDate = DateTime.now();
  bool _isLoading = false;
  late int apiId;
   int type = 1;
  final menuIdController = Get.put(MenuIdController());

  Future getMenuId() async  {
    print(DateFormat('dd-MM-yyyy').format(menuExpiryDate));
    String token = await getToken();
    final url = Uri.parse(
      "$devUrl/v2/create-or-update-menu");
    final headers= {'Authorization': 'Bearer $token'};
    final body=  type == 2 ? {
        "is_menu_completed": "1",
        "is_permanent_menu": "1",
        "menu_review_status": "1",
        "name": menuItemName,
        "type": "$type",
        "date_of_menu" : "${DateFormat('yyyy-MM-dd').format(menuExpiryDate)}"
      }: {
    "is_menu_completed": "1",
    "is_permanent_menu": "1",
    "menu_review_status": "1",
    "name": menuItemName,
    "type": "$type",
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        menuId = json['data']['id'];
        return menuId;
        print(menuId);
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
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null && picked != menuExpiryDate) {
      setState(() {
        menuExpiryDate = picked;
        // print(DateFormat('yyyy-MM-dd').format(menuExpiryDate));
      });
    }
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
      body:
      _isLoading ?
      Center(
        child: CircularProgressIndicator(
          color: orangeColor(),
        ),
      ) : SingleChildScrollView(
        child:  Container(
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
                    color:
                        orangeColor(),
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
                    color:  const Color.fromRGBO(53, 56, 66, 1),
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
                    color:const Color.fromRGBO(53, 56, 66, 1),
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
                          'Basic Details',
                          style: mTextStyle18(),
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
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white), //<-- SEE HERE
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                fillColor: inputColor(),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Name Of Menu Item',
                                hintStyle: inputTextStyle16(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name for the menu item';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                menuItemName = value!;
                                print(menuItemName);
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
                                    'This is Permanent Menu',
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
                                          isPermanentMenu = value ?? false;
                                          isPermanentMenu == true ? type = 1 : type = 2;
                                          print(type);
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
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(37, 40, 48, 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat('dd-MM-yyyy').format(menuExpiryDate),
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
                                    menuIdController.menuId = await getMenuId();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CreateTextMenu2()),
                                    );
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: cardColor(),
                                          title: Text('Error',style: TextStyle(color: orangeColor()),),
                                          content: Text('Name Already Exists :\nPlease try again with different name'),
                                          actions: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(orangeColor()),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
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
                                    borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
