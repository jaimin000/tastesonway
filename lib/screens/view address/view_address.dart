import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/register/searchLocation.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';

class ViewAddress extends StatefulWidget {
  const ViewAddress({Key? key}) : super(key: key);

  @override
  State<ViewAddress> createState() => _ViewAddressState();
}

class _ViewAddressState extends State<ViewAddress> {
  Map addressData = {};
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  var locality;
  var subLocality;
  double latitide = 0;
  double longtude = 0;
  String addressID = '';

  bool saveAsHome = false;
  bool saveAsOffice = false;
  bool saveAsOther = false;

  TextEditingController officeAddress = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  changeLocationData() async {
    var getSubLocality = await Sharedprefrences.getSubLocality();
    var getLocality = await Sharedprefrences.getLocality();
    var TempLat = await Sharedprefrences.getTempLat();
    var TempLog = await Sharedprefrences.getTempLog();
    setState(() {
      locality = getLocality;
      subLocality = getSubLocality;
      latitide = TempLat!;
      longtude = TempLog!;
    });
  }

  Future fetchAddress() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-addresses"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      var data = jsonData['data'];
      addressData = data[0];
      officeAddress.text = addressData['office_name'].toString();
      addressController.text = addressData['address'].toString();
      landmarkController.text = addressData['land_mark'].toString();
      pincodeController.text = addressData['pin_code'].toString();
      subLocality = addressData['area'].toString();
      locality = addressData['city']['name'].toString();
      if (addressData['latitude'].toString() != 'null') {
        latitide = double.parse(addressData['latitude'].toString());
      }
      if (addressData['longitude'].toString() != 'null') {
        longtude = double.parse(addressData['longitude'].toString());
      }
      addressID = addressData['id'].toString();
      if (addressData['address_type'].toString() == 'Home') {
        saveAsHome = true;
        saveAsOffice = false;
        saveAsOther = false;
      } else if (addressData['address_type'].toString() == 'Work') {
        saveAsHome = false;
        saveAsOffice = true;
        saveAsOther = false;
      } else {
        saveAsHome = false;
        saveAsOffice = false;
        saveAsOther = true;
      }
      await Sharedprefrences.saveAddressID(addressID);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isEditable = true;
      });
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again');
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> updateAddress(String addressID) async {
    // if (_formKey.currentState.validate()) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   var area = subLocality.toString();
    //   // String area = "ddemo";
    //   var cityName = locality.toString();
    //   var address = addressController.text;
    //   var landMark = landmarkController.text ?? '';
    //
    //   var pincode = int.parse(pincodeController.text);
    //   var latitude = latitide.toString();
    //   var longitude = longtude.toString();
    //   int addressType;
    //   if (saveAsHome == true) {
    //     addressType = 1;
    //   } else if (saveAsOffice == true) {
    //     addressType = 2;
    //   } else {
    //     addressType = 3;
    //   }
    //   // await _repository
    //   //     .addAddressStore(
    //   //     cityName,
    //   //     address,
    //   //     area,
    //   //     landMark,
    //   //     pincode,
    //   //     latitude,
    //   //     longitude,
    //   //     addressType,
    //   //     officeAddress.text,
    //   //     addressID)
    //   //     .then((value) async {
    //   //   print(value.statusCode);
    //   //   dynamic status = value.body;
    //   //   dynamic user = jsonDecode(status.toString());
    //   //   if (value.statusCode != 200) {
    //   //     if (value.statusCode == 401) {
    //   //       dynamic status = value.body;
    //   //       dynamic responseJson = jsonDecode(status.toString());
    //   //       if (responseJson['message']
    //   //           .toString()
    //   //           .contains(Constant.maintenance)) {
    //   //         setState(() {
    //   //           isServicePresent = true;
    //   //           _isLoading = false;
    //   //         });
    //   //       } else {
    //   //         var prefManager = await SharedPreferences.getInstance();
    //   //         await prefManager.clear();
    //   //
    //   //         await Navigator.of(context).pushAndRemoveUntil(
    //   //             MaterialPageRoute(builder: (context) => LanguageScreen()),
    //   //                 (Route<dynamic> route) => false);
    //   //       }
    //   //     } else {
    //   //       dynamic message = user['message'];
    //   //       // state(() {
    //   //       SnackBarWidget.show(context, message.toString());
    //   //       // isShowStoreAddresssLoader = false;
    //   //       // });
    //   //       setState(() {
    //   //         _isLoading = false;
    //   //       });
    //   //     }
    //   //   } else {
    //   //     setState(() {
    //   //       _isLoading = false;
    //   //       isEdittable = false;
    //   //       isServicePresent = false;
    //   //     });
    //   //     var addressId = user['data']['id'];
    //   //     await Sharedprefrences.saveAddressID(addressId.toString());
    //   //     // Sharedprefrences.isHasAddressSave(true);
    //   //     // Sharedprefrences.setTempLocation(false);
    //   //     // Sharedprefrences.isHasAddressSave(true);
    //   //     //var id=user['data'][0]['id'];
    //   //     // state(() {
    //   //     //   isShowStoreAddresssLoader = false;
    //   //     // });
    //   //   }
    //   // });
    // }
  }

  @override
  void initState() {
    fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: isEditable
            ? Text(
                'key_Edit_Address'.tr,
                style: cardTitleStyle20(),
              )
            : Text(
                'key_View_Address'.tr,
                style: cardTitleStyle20(),
              ),
        actions: [
          !isEditable
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isEditable = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                )
              : SizedBox(),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: orangeColor()),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
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
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  'Basic Details',
                                  style: mTextStyle18(),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: orangeColor(),
                                            size: 30,
                                          ),
                                          Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    if (isEditable) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SearchLocation())).then(
                                                          (value) {
                                                        if (value == 'true') {
                                                          changeLocationData();
                                                          // Navigator.pop(context);
                                                          // getUserLocation();
                                                        }
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    subLocality != null
                                                        ? subLocality.toString()
                                                        : '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mTextStyle18(),
                                                  ))),
                                        ],
                                      )),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            if (isEditable) {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SearchLocation()))
                                                  .then((value) {
                                                if (value == 'true') {
                                                  changeLocationData();
                                                  // Navigator.pop(context);
                                                  // getUserLocation();
                                                }
                                              });
                                            }
                                          },
                                          child: isEditable
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 5,
                                                          bottom: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6)),
                                                      color: Color(0xFFF0F0F0),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFDFDFDF))),
                                                  child: Center(
                                                      child: Text(
                                                    'key_Change'.tr,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFF85649)),
                                                  )))
                                              : Container()))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: officeAddress,
                                  enabled: isEditable,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key_Please_enter_Kitchen_Owner_Name'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.white), //<-- SEE HERE
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    fillColor: inputColor(),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintText: 'key_Kitchen_Owner_Name'.tr,
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
                                child: TextFormField(
                                  enabled: isEditable,
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key_Please_enter_Address'.tr;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.white), //<-- SEE HERE
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    fillColor: inputColor(),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintText: 'key_Address'.tr,
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
                                child: TextFormField(
                                  enabled: isEditable,
                                  controller: landmarkController,
                                  style: const TextStyle(
                                      color: Colors.white), //<-- SEE HERE
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    fillColor: inputColor(),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintText: 'key_Landmark'.tr,
                                    hintStyle: inputTextStyle16(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  enabled: isEditable,
                                  controller: pincodeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key_Please_enter_pincode'.tr;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                      color: Colors.white), //<-- SEE HERE
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
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      shadowColor: Colors.black,
                                      color: orangeColor(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Proceed',
                                          style: mTextStyle14(),
                                        ),
                                      ))),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  'key_Address_Type'.tr,
                                  style: mTextStyle18(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    shadowColor: Colors.black,
                                    color: orangeColor(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: 80,
                                      height: 35,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'key_Home'.tr,
                                            style: mTextStyle16(),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(53, 56, 66, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: 80,
                                      height: 35,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'key_Work'.tr,
                                            style: mTextStyle16(),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(53, 56, 66, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: 80,
                                      height: 35,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'key_Other'.tr,
                                            style: mTextStyle16(),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
