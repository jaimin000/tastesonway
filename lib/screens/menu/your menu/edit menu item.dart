import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastesonway/apiServices/api_service.dart';
import '../../../utils/sharedpreferences.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/theme_data.dart';
import 'package:http/http.dart' as http;

class EditMenuItem extends StatefulWidget {
  final int id;
  final int menu_id;
  final String name;
  final String type;
  final String description;
  final int price;

  const EditMenuItem({Key? key,
    required this.id,
    required this.menu_id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<EditMenuItem> createState() => _EditMenuItemState();
}

class _EditMenuItemState extends State<EditMenuItem> {

  bool _switchValue = true;
  int step = 1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController toppingNamecontroller = TextEditingController();
  final TextEditingController toppingPricecontroller = TextEditingController();
  int type =1;
  late File _image;
  List toppingPrice = [];
  List toppingName=[];
  bool _isLoading = false;
  bool _imageEdit = false;

  Widget topping(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                controller: toppingNamecontroller,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'key_Name'.tr,
                  hintStyle: inputTextStyle16(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'key_Please_enter_item_name'.tr;
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
                controller: toppingPricecontroller,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'key_Price'.tr,
                  hintStyle: inputTextStyle16(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'key_Please_enter_item_price'.tr;
                  }
                  return null;
                },
                onSaved: (value) {
                  toppingPrice.add(value);
                  print(toppingPrice);
                },
              ),
            ),
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
      _imageEdit = true;
      print(_image);
    });
  }
  var menuId;

  //api call
  Future UpdateMenuItem() async {
    String token = await Sharedprefrences.getToken();
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/create-or-update-menu-item'),
      );
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      request.fields['menu_id'] = '${widget.menu_id}';
      request.fields['name'] = namecontroller.text;
      request.fields['category_id'] = '1';
      request.fields['amount'] = pricecontroller.text;
      request.fields['description'] = descriptioncontroller.text;
      request.fields['type'] = '$type';
      request.fields['id'] = '${widget.id}';
      for (int i = 0; i < toppingName.length; i++) {
        request.fields['ingridients[$i][name]'] = toppingNamecontroller.text;
        request.fields['ingridients[$i][price]'] = toppingPricecontroller.text;
      }
      //request.fields['ingridients[$i][price]'] = '${toppingPrice[i]}';
      //print('topping name : $toppingName[i]');

      print(pricecontroller.text);
      print(namecontroller.text);
      print(descriptioncontroller.text);
      if(_imageEdit) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            _image.path,
            // widget.image,
          ),
        );
      }
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

  Future DeleteMenuItem() async {
    print("this is selected item id ${widget.id}, ${widget.name} & ${widget.price}");
    String token = await Sharedprefrences.getToken();
    print(token);
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/delete-menu-item'),
      );
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      request.fields['menu_item_id'] = '${widget.id}';
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      print(responseData);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.name;
    pricecontroller.text = widget.price.toString();
    descriptioncontroller.text = widget.description;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,"true");
          },
          icon:const Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () async {
              await DeleteMenuItem();
              ScaffoldSnackbar.of(context).show('Menu item deleted successfully');
              Navigator.pop(context,'true');
              setState(() {
                _isLoading = false;
              });
            },
          )
        ],
        title: Text(
          'key_Edit_Item'.tr,
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
                "key_Edit_menu".tr,
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
                          'key_Basic_Details'.tr,
                          style: mTextStyle18(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: namecontroller,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: pricecontroller,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_What_the_price_per_serving'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_the_price_per_serving'.tr;
                              }
                              return null;
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
                                      'image.png',
                                      textAlign: TextAlign.center,
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
                                    'key_Veg_Only'.tr,
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
                                          _switchValue?type = 1:type=2;
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
                            controller: descriptioncontroller,
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
                              hintText: 'key_Add_Dish_Description'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_dish_description'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'key_Extra_Topping'.tr,
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                  await UpdateMenuItem();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Get.back();
                                  Navigator.pop(context,"true");
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
                                      'key_Proceed'.tr,
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