import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastesonway/apiServices/ApiService.dart';
import '../../../theme_data.dart';
import 'create_text_menu2.dart';
import 'package:http/http.dart' as http;


class EditItem extends StatefulWidget {
  final int id;
  final int menu_id;
  final String name;
  final String description;
  final int price;

  const EditItem({required this.id,
    required this.menu_id,
    required this.name,
    required this.price,
    required this.description});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {

  bool _switchValue = true;
  int step = 1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  int type = 1;
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
    String token = await getToken();
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$devUrl/v2/create-or-update-menu-item'),
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
        request.fields['ingridients[$i][name]'] = '${toppingName[i]}';
        request.fields['ingridients[$i][price]'] = '${toppingPrice[i]}';
      }
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
        title: Text(
          'Edit Item',
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
                "Edit Text Menu",
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
                              hintText: 'Name Of Menu Item',
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name for the menu item';
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
                              hintText: 'Price Per Serving',
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price for the menu item';
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
                              hintText: 'Add Dish Description',
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter description for the menu item';
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
