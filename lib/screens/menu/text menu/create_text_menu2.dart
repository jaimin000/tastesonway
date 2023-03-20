import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/menu/text%20menu/add_new_item.dart';
import 'package:tastesonway/screens/menu/text%20menu/create_text_menu3.dart';
import '../../../apiServices/ApiService.dart';
import '../../../theme_data.dart';
import 'package:http/http.dart' as http;


class CreateTextMenu2 extends StatefulWidget {
  CreateTextMenu2({Key? key}) : super(key: key);
  @override
  State<CreateTextMenu2> createState() => _CreateTextMenu2State();
}

class _CreateTextMenu2State extends State<CreateTextMenu2> {
  bool _check1 = false;
  bool _checkAll = false;
  bool isPermanentMenu = true;
  List<dynamic> menuData = [];
  Future<void> getMenu() async {
    String token = await getToken();
    int ownerId = await getOwnerId();
    final response = await http.post(
      Uri.parse('http://192.168.1.26:24/api/v2/get-menu-item'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'business_owner_id': '$ownerId'},
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      menuData = json['data'][1]['data'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Create Text Menu",
                  style: mTextStyle20(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color:
                        Color.fromRGBO(53, 56, 66, 1),
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
                  SizedBox(
                    width: 5,
                  ),
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
                            'Step 2',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(53, 56, 66, 1),
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
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
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
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
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
                                Navigator.push(
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
                        SizedBox(height: 5),
                        Text(
                          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                          style: cTextStyle12(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.white), //<-- SEE HERE
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: orangeColor(),
                              ),
                              contentPadding: EdgeInsets.all(10.0),
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
                        SizedBox(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      value: _checkAll,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _checkAll = value ?? false;
                                          _check1 = value ?? false;
                                        });
                                        Colors.black;
                                      },
                                      focusColor: orangeColor(),
                                      fillColor:
                                      MaterialStateProperty.all(orangeColor()),
                                      side: BorderSide(
                                        color: orangeColor(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        'Select All',
                                        style: inputTextStyle16(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                              FutureBuilder(
                                future: getMenu(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(color: orangeColor(),strokeWidth: 2),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: menuData
                                          .map(
                                            (item) => SizedBox(
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: _check1,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _check1 = value ?? false;
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
                                                        item['name'],
                                                        overflow: TextOverflow.clip,
                                                        style: inputTextStyle14(),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                        "₹ ${item['amount']}",
                                                        overflow: TextOverflow.clip,
                                                        style: inputTextStyle14(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                overflow: Overflow.visible,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                    child: Image.network(
                                                      item['picture'],
                                                      height: 60,
                                                      width: 65,
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (BuildContext
                                                      context,
                                                          Object exception,
                                                          StackTrace? stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/tea.jpg',
                                                          height: 60,
                                                          width: 65,
                                                          fit: BoxFit.fill,);
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 45,
                                                    right: 10,
                                                    child: Card(
                                                      shadowColor: Colors.black,
                                                      color: orangeColor(),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                      ),
                                                      child: SizedBox(
                                                        width: 40,
                                                        height: 20,
                                                        child: Align(
                                                            alignment:
                                                            Alignment.center,
                                                            child: Text(
                                                              'Edit',
                                                              style: mTextStyle14(),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          .toList(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => CreateTextMenu3()));
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
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
