import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastesonway/utils/sharedpreferences.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import '../../apiServices/api_service.dart';
import '../../utils/snackbar.dart';

class EditPersonalDetail extends StatefulWidget {
  final String name;
  final String email;
  final String pincode;
  final String profile;
  final String gender;
  final String dob;
  const EditPersonalDetail({
    required this.profile,required this.dob,required this.gender,
    required this.name,required this.email,required this.pincode});

  @override
  State<EditPersonalDetail> createState() => _EditPersonalDetailState();
}

class _EditPersonalDetailState extends State<EditPersonalDetail> {
  int refreshCounter = 0;
  bool isEditable = false;
  DateTime? selectedDate;
  File? _image;
  DateTime currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

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

  // void _showErrorDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       backgroundColor: cardColor(),
  //       title: const Text('Error'),
  //       content: Text('key_please_select_Image'.tr),
  //       actions: [
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: orangeColor(), // Background color
  //           ),
  //           onPressed: () => Navigator.pop(context),
  //           child:  Text('key_OKAY'.tr),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future updateProfile() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
        Uri.parse('$baseUrl/kitchen-owner-update-profile'),
        headers: {'Authorization': 'Bearer $token',
        },
        body: {
          'country_code':await Sharedprefrences.getCountryCode(),
          'short_code':await Sharedprefrences.getShortCode(),
          'name':nameController.text.toString(),
          'email':emailController.text.toString(),
          'pin_code':pincodeController.text.toString(),
          'date_of_birth':DateFormat('dd-MM-yyyy').format(selectedDate!),
          'gender': gender == 'Male'? '1' : '2',
        }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
        var message = jsonData['message'];
        print(message);
      ScaffoldSnackbar.of(context)
          .show(message);
      setState(() {
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ?updateProfile():null;}
    }else {
      ScaffoldSnackbar.of(context)
          .show("Something went wrong please try again!");
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  DateTime FormateDate(String dateString) {
    List<String> dateParts = dateString.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  @override
  void initState() {
    nameController.text = widget.name;
    emailController.text = widget.email;
    pincodeController.text = widget.pincode;
    selectedDate = FormateDate(widget.dob.toString());
    gender = widget.gender == '1'? 'Male':'Female';
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
          'key_Personal_Details'.tr,
          style: cardTitleStyle20(),
        ),
        actions: [
          !isEditable ? IconButton(onPressed: () {
            isEditable = true;
            setState(() {
            });
          },icon: const Icon(Icons.edit),) : SizedBox()
        ],
      ),
      body: ListView(
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
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: const Color.fromRGBO(53, 56, 66, 1),
                        backgroundImage: NetworkImage(widget.profile),
                         // _image != null ? FileImage(_image!) : null,
                        child: widget.profile == null
                            ? const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.red,
                          size: 35,
                        )
                            : null,
                      ),
                      onTap: () async {
                        isEditable ? await _pickImage(ImageSource.gallery) : null;
                      },
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
                        enabled: isEditable,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        controller: nameController,
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
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        enabled: isEditable,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        controller: emailController,
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
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        enabled: isEditable,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        controller: pincodeController,
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
                                onChanged: isEditable ? (String? newValue) {
                                   setState(() { gender = newValue!;
                                  });
                                } : null,
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
                          isEditable? _selectDate(context) : null;
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
                                    'key_Select_Your_Birth_Date'.tr,
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
                            // if (_image == null) {
                            //   _showErrorDialog(context);
                            // }else
                              if(selectedDate == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("key_Please_Enter_DateOfBirth".tr),
                                ),
                              );
                            }
                            else {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                print({
                                  'country_code':await Sharedprefrences.getCountryCode(),
                                  'short_code':await Sharedprefrences.getShortCode(),
                                  'name':nameController.text.toString(),
                                  'email':emailController.text.toString(),
                                  'pin_code':pincodeController.text.toString(),
                                  'date_of_birth':DateFormat('dd-MM-yyyy').format(selectedDate!),
                                  'gender': gender == 'Male'? '1' : '2',
                                });
                                // Sharedprefrences.setFullName(name);
                                // Sharedprefrences.setProfilePic(_image.toString());
                                // Sharedprefrences.setEmail(email);
                                // Sharedprefrences.setGender(gender);
                                // Sharedprefrences.setPincode(pincode);
                                // Sharedprefrences.setBirthdate(DateFormat('yyyy-MM-dd')
                                //     .format(selectedDate!));
                                // print("this is data ${await Sharedprefrences.getFullName()},${await Sharedprefrences.getGender()}"
                                //     "${await Sharedprefrences.getEmail()},${await Sharedprefrences.getProfilePic()},"
                                //     "${await Sharedprefrences.getPincode()}, ${await Sharedprefrences.getBirthdate()}");
                                updateProfile();
                                Get.back();
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
                                  'key_Proceed'.tr,
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
