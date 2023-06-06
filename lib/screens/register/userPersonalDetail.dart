import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastesonway/screens/register/addressPage.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import '../../apiServices/api_service.dart';
import '../../utils/snackbar.dart';

class userPersonalDetail extends StatefulWidget {
  const userPersonalDetail({Key? key}) : super(key: key);

  @override
  State<userPersonalDetail> createState() => _userPersonalDetailState();
}

class _userPersonalDetailState extends State<userPersonalDetail> {
  int refreshCounter = 0;
  bool isLoading = false;
  String name = "";
  String email = "";
  String pincode = "";
  DateTime? selectedDate;
  File? _image;
  DateTime currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';
  String message="";

  var items = [
    'Male',
    'Female',
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

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate!,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: currentDate,
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

    if (pickedDate != null) {
      final DateTime minimumDate = currentDate.subtract(const Duration(days: 365 * 10));
      if (pickedDate.isAfter(minimumDate)) {
        // Show an error message or handle the validation failure
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: cardColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text('key_error'.tr,style: cardTextStyle18()),
              content: Text('key_Please_Enter_Valid_DateOfBirth'.tr),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: fontColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:
                  Text('key_OKAY'.tr, style: mTextStyle14()),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
        return null;
      }
      else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    } else {
      return null; // User canceled the date picker
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: cardColor(),
        title: const Text('Error'),
        content: Text('key_please_select_Image'.tr),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: orangeColor(), // Background color
            ),
            onPressed: () => Navigator.pop(context),
            child:  Text('key_OKAY'.tr),
          ),
        ],
      ),
    );
  }

  Future fetchData() async {
    int id = await Sharedprefrences.getLanguageId() ?? 0;
    dynamic number = await Sharedprefrences.getMobileNumber();
    print(number);
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/kitchen-owner-update-profile'),
      headers: {'Authorization': 'Bearer $token',
      },
      body: {
        'language_id':"$id",
        'country_code':await Sharedprefrences.getCountryCode(),
        'short_code':await Sharedprefrences.getShortCode(),
        'mobile_number':number.toString(),
       // 'avatar':await Sharedprefrences.getProfilePic().toString(),
         'name':name,
         'email':email,
         'pin_code':pincode,
        'date_of_birth':DateFormat('dd-MM-yyyy').format(selectedDate!),
      }
    );
    print({
      'language_id':"$id",
      'country_code':await Sharedprefrences.getCountryCode(),
      'short_code':await Sharedprefrences.getShortCode(),
      'mobile_number':number.toString(),
      'name':name,
      'email':email,
      'pin_code':pincode,
      'date_of_birth':DateFormat('dd-MM-yyyy').format(selectedDate!),
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Sharedprefrences.setPersonalDetailAdded(true);
        setState(() {
          var data = jsonData['data'];
          message = jsonData['message'];
          print(data);
          isLoading = false;
        });
      ScaffoldSnackbar.of(context).show(message);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const AddressPage()));
    } else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ?fetchData():null;
        isLoading = false;
        setState(() {
        });
      }
    }else {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      isLoading = false;
      setState(() {
      });
      ScaffoldSnackbar.of(context).show(message);
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
          'key_Personal_Details'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: isLoading? Center(child:CircularProgressIndicator(color: orangeColor(),)):ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 75,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await _pickImage(ImageSource.gallery);
                      },
                      child: CircleAvatar(
                        radius: 80,
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
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.all(10),
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
                          hintText: 'key_Name'.tr,
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'key_Please_Enter_Name'.tr;
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
                          hintText: 'key_Email'.tr,
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'key_Please_Enter_Email'.tr;
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'key_Please_Enter_Valid_Email'.tr;
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
                          hintText: 'key_pincode'.tr,
                          hintStyle: inputTextStyle16(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'key_please_Enter_Valid_pincode'.tr;
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return 'key_please_Enter_Valid_pincode'.tr;
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
                                'key_Select_your_gender'.tr,
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
                                      items == "Male"? 'key_male'.tr:'key_female'.tr,
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
                      child: InkWell(
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
                                    'key_Please_select_your_year_of_birth'.tr,
                                    style: inputTextStyle16(),
                                  ),
                                  Text(
                                    selectedDate == null
                                        ? ''
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
                    const SizedBox(height: 45),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () async {
                            if (_image == null) {
                              _showErrorDialog(context);
                            }else if(selectedDate == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content: Text("key_Please_Enter_DateOfBirth".tr),
                                ),
                              );
                            }
                            else {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const AddressPage()));
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
                                  'key_Click_Proceed_Button'.tr,
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
