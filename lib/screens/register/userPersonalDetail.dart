import 'package:flutter/material.dart';
import 'package:tastesonway/screens/discount/choose_promo.dart';
import 'package:tastesonway/screens/register/addressPage.dart';
import 'package:tastesonway/screens/register/questions1.dart';
import 'package:tastesonway/theme_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class userPersonalDetail extends StatefulWidget {
  const userPersonalDetail({Key? key}) : super(key: key);

  @override
  State<userPersonalDetail> createState() => _userPersonalDetailState();
}

class _userPersonalDetailState extends State<userPersonalDetail> {
  int _current = 0;
  String dropdownvalue = 'Male';
  var items = [
    'Male',
    'Female',
    'Other',
  ];
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
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
          'Personal Details',
          style: cardTitleStyle20(),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(53, 56, 66, 1),
                        ),
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.camera_alt_rounded, color: orangeColor(),size: 35,),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      fillColor: inputColor(),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Email',
                      hintStyle: inputTextStyle16(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(

                      contentPadding: const EdgeInsets.all(10.0),
                      fillColor: inputColor(),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Pincode',
                      hintStyle: inputTextStyle16(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child:
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Gender',
                            textAlign: TextAlign.left,
                            style: inputTextStyle16(),
                          ),
                          DropdownButton(
                            underline: const SizedBox(),
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down,color: Color.fromRGBO(255, 114, 105, 1),),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items,style: inputTextStyle16(),),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:10),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
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
                            'Date of birth',
                            style: inputTextStyle16(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // TextField(
                  //   style: const TextStyle(color: Colors.white),
                  //   cursorColor: Colors.white,
                  //   decoration: InputDecoration(
                  //
                  //     contentPadding: const EdgeInsets.all(10.0),
                  //     fillColor: inputColor(),
                  //     filled: true,
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide.none),
                  //     hintText: 'Date of birth',
                  //     hintStyle: inputTextStyle16(),
                  //   ),
                  // ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  const AddressPage()));
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
