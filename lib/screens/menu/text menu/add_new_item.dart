import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme_data.dart';
import 'create_text_menu3.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {

  bool _switchValue = false;
  int step = 1;
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String price;
  int type = 0;
  late String description;
  late File _image;
  List toppingPrice = [];
  List toppingName=[];
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
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
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
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
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
        SizedBox(height:10),
      ],
    );
  }

  List<Widget>Toppings = [];
  void addToppingWidget(){
    setState(() {
        Toppings.add(topping());
    });
  }
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
      print(_image);
    });
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
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
                  color: step == 0
                      ? orangeColor()
                      : Color.fromRGBO(53, 56, 66, 1),
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
                  color: step == 1
                      ? orangeColor()
                      : Color.fromRGBO(53, 56, 66, 1),
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
                  color: step == 2
                      ? orangeColor()
                      : Color.fromRGBO(53, 56, 66, 1),
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
                // height: 630,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
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
                        SizedBox(height: 15),
                        Text(
                          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                          style: cTextStyle12(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(37, 40, 48, 1),
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
                                      'Upload Image',
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(37, 40, 48, 1),
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            minLines: 3,
                            maxLines: 5,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
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
                        SizedBox(
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
                                    color: Color.fromRGBO(37, 40, 48, 1),
                                  ),
                                  child: Center(
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
                        SizedBox(
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
                              onTap: (){
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateTextMenu3()),);
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
