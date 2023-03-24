import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastesonway/apiServices/ApiService.dart';
import '../../../theme_data.dart';
import 'create_text_menu2.dart';
import 'menuIdController.dart';
import 'package:http/http.dart' as http;


class AddNewItem extends StatefulWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {

  bool _switchValue = true;
  int step = 1;
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String price;
  int type = 1;
  late String description;
  late File _image;
  List toppingPrice = [];
  List toppingName=[];
  bool _isLoading = false;
  bool _imageSelected = false;

  Widget topping(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Name',
                  hintStyle: inputTextStyle16(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name for the topping item';
                  }
                  return null;
                },
                onSaved: (value) {
                  toppingName.add(value);
                  print(toppingName);
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Price',
                  hintStyle: inputTextStyle16(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Price for the topping item';
                  }
                  return null;
                },
                onSaved: (value) {
                  toppingPrice.add(value);
                  print(toppingPrice);
                },
              ),
            ),
            IconButton(onPressed: removeToppingWidget, icon: Icon(Icons.delete,color: orangeColor(),),),
          ],
        ),
        const SizedBox(height:10),
      ],
    );
  }

  List<Widget>Toppings = [];

  void addToppingWidget(){
    setState(() {
        Toppings.add(topping());
    });
  }
  void removeToppingWidget(){
    setState(() {
      Toppings.removeAt(0);
    });
  }

  //getting menu id from getx
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      _image = File(pickedFile!.path);
      _imageSelected = true;
      print(_image);
    });
  }
  var menuId;

  //api call
  Future CreateMenuItem() async {
    String token = await getToken();
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$devUrl/v2/create-or-update-menu-item'),
      );
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      request.fields['menu_id'] = '$menuId';
      request.fields['name'] = name;
      request.fields['description']=description;
      request.fields['category_id'] = '1';
      request.fields['amount'] = price;
      request.fields['type'] = '$type';
      for (int i = 0; i < toppingName.length; i++) {
        request.fields['ingridients[$i][name]'] = '${toppingName[i]}';
        request.fields['ingridients[$i][price]'] = '${toppingPrice[i]}';
      }
      request.files.add(
        await http.MultipartFile.fromPath(
          'picture',
          _image.path,
        ),
      );
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      print(responseData);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: cardColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Menu Item Added Successfully',
                    style: mTextStyle14(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: cardColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Error Creating Menu Item !',
                    style: mTextStyle14(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final MenuIdController menuIdController = Get.find<MenuIdController>();
    menuId = menuIdController.menuId;
    print(menuId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Add New Item',
          style: cardTitleStyle20(),
        ),
      ),
      body:_isLoading ?
      Center(
        child: CircularProgressIndicator(
          color: orangeColor(),
        ),
      ) : Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
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
            Card(
              shadowColor: Colors.black,
              color: cardColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                // height: 630,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Basic Details',
                          style: mTextStyle18(),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                          style: cTextStyle12(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
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
                              name = value!;
                              print("name : $name");
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Price Per Serving',
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price for the menu item';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              price = value!;
                              print(price);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(37, 40, 48, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: (){
                                _pickImage(ImageSource.gallery);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _imageSelected ? 'image.jpg' : 'Select Image',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      style: inputTextStyle16(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.ios_share,
                                      color: orangeColor(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
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
                                    'Type Of Dish Veg',
                                    textAlign: TextAlign.center,
                                    style: inputTextStyle16(),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                      thumbColor: Colors.black,
                                      activeColor: Colors.green,
                                      value: _switchValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _switchValue = value ?? false;
                                          _switchValue?type = 1:type=0;
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
                        SizedBox(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            minLines: 3,
                            maxLines: 5,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Add Dish Description',
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter description for the menu item';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              description = value!;
                              print(description);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Toppings',
                              style: mTextStyle18(),
                            ),
                            InkWell(
                              onTap: addToppingWidget,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        fontSize: 18,
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: Toppings.length * 70,
                          child: ListView.builder(
                              itemCount:Toppings.length,
                              itemBuilder:(context,index){
                              return Toppings[index];
                          }),
                        ),
                        SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                              onTap: ()async{
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await CreateMenuItem();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CreateTextMenu2()),);
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}