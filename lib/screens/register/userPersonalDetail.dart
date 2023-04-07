import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastesonway/screens/register/addressPage.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import '../../apiServices/ApiService.dart';

class userPersonalDetail extends StatefulWidget {
  const userPersonalDetail({Key? key}) : super(key: key);

  @override
  State<userPersonalDetail> createState() => _userPersonalDetailState();
}

class _userPersonalDetailState extends State<userPersonalDetail> {
  String name = "";
  String email = "";
  String pincode = "";
  DateTime? selectedDate;
  File? _image;
  DateTime currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';

  var items = [
    'Male',
    'Female',
    'Other',
  ];

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
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        lastDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 100))
    );
    if (picked != null && picked != currentDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: cardColor(),
        title: const Text('Error'),
        content: const Text('Please select an image'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: orangeColor(), // Background color
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future fetchData() async {
    int id = await Sharedprefrences.getLanguageId();
    dynamic number = await Sharedprefrences.getMobileNumber();
    print(number);
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse('https://dev-api.tastesonway.com/api/v2/kitchen-owner-update-profile'),
      headers: {'Authorization': 'Bearer $token',
      },
      body: {
        'language_id':"$id",
        'country_code':await Sharedprefrences.getCountryCode(),
        'short_code':await Sharedprefrences.getShortCode(),
        //'mobile_number':'7069836196',
        //'avatar':await Sharedprefrences.getProfilePic().toString(),
         'name':name,
         'email':email,
         'pin_code':pincode,
        'date_of_birth':DateFormat('dd-MM-yyyy').format(selectedDate!),
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
        setState(() {
          var data = jsonData['data'];
          print(data);
        });
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
                      onTap: () async {
                        await _pickImage(ImageSource.camera);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color.fromRGBO(53, 56, 66, 1),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.red,
                                size: 35,
                              )
                            : null,
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
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
                          hintText: 'Name',
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          name = value!;
                          print(name);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
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
                          hintText: 'Email',
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                          print(email);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
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
                          hintText: 'Pincode',
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pincode';
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return 'Please enter a valid 6-digit pin code';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          pincode = value!;
                          print(pincode);
                        },
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
                                value: gender,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(255, 114, 105, 1),
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: inputTextStyle16(),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    gender = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Date of Birth',
                                    style: inputTextStyle16(),
                                  ),
                                  Text(
                                    selectedDate == null
                                        ? 'No Date Chosen'
                                    :DateFormat('dd-MM-yyyy')
                                        .format(selectedDate!),
                                    style: inputTextStyle16(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () async {
                            if (_image == null) {
                              _showErrorDialog(context);
                            }else if(selectedDate == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a date of birth"),
                                ),
                              );
                            }
                            else {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                Sharedprefrences.setFullName(name);
                                Sharedprefrences.setProfilePic(_image.toString());
                                Sharedprefrences.setEmail(email);
                                Sharedprefrences.setGender(gender);
                                Sharedprefrences.setPincode(pincode);
                                Sharedprefrences.setBirthdate(DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!));
                                // print("this is data ${await Sharedprefrences.getFullName()},${await Sharedprefrences.getGender()}"
                                //     "${await Sharedprefrences.getEmail()},${await Sharedprefrences.getProfilePic()},"
                                //     "${await Sharedprefrences.getPincode()}, ${await Sharedprefrences.getBirthdate()}");
                                await fetchData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddressPage()));
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
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
