import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tastesonway/screens/register/questions.dart';
import 'package:tastesonway/screens/register/searchLocation.dart';
import 'package:tastesonway/utils/theme_data.dart';

import '../../utils/sharedpreferences.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late GoogleMapController _mapController;
  bool _isLoading = true;
  bool _isLocationConfirm = false;
  LatLng latLng = const LatLng(23.0000, 72.000);
  String _currentAddress = "";
  String ownerName = "";
  String address = "";
  String landmark = "";
  String pincode = "";
  String sublocality = "";
  String locality = "";
  final _formKey = GlobalKey<FormState>();
  var addressType = [
    'Home',
    'Office',
    'Other',
  ];
  String selectedaddressType = 'Home';

  void _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    var tempLocation = await Sharedprefrences.getTempLocation() ?? false;
    var getSubLocality = await Sharedprefrences.getSubLocality();
    var getLocality = await Sharedprefrences.getLocality();
    double? TempLat = await Sharedprefrences.getTempLat();
    double? TempLog = await Sharedprefrences.getTempLog();

    if (tempLocation) {
      setState(() {
        latLng = LatLng(TempLat!, TempLog!);
        _currentAddress = "$getSubLocality $getLocality";
        _isLoading = false;
      });
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(TempLat!, TempLog!),
          zoom: 15,
        ),
      ));
    }
    else {
      LocationPermission permission = await Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      _getAddressFromLatLng(position);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ));
    }
  }

  void _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.subLocality} ${place.locality}";
        sublocality = place.subLocality!;
        locality = place.locality!;
      });
      print("this is current address $_currentAddress");
    } catch (e) {
      print(e);
    }
  }

  Future fetchData() async {
    int type;
    if(selectedaddressType =='Home'){
      type = 1;
    }else if(selectedaddressType =='Office'){
      type = 2;
    }else{
      type = 3;
    }
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
        Uri.parse('https://dev-api.tastesonway.com/api/v2/create-or-update-address'),
        headers: {'Authorization': 'Bearer $token',
        },
        body: {
          "city_name": "$locality",
          "area":"$sublocality",
          "address": "$address",
          "land_mark": "$landmark",
          "pin_code": "$pincode",
          "address_type": "$type",
          "latitude":"${latLng.latitude}",
          "longitude":"${latLng.longitude}"
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
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  _isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                          color: orangeColor(),
                        ))
                      : GoogleMap(
                          markers: {
                            Marker(
                              markerId: const MarkerId("user_location"),
                              position:
                                  LatLng(latLng.latitude, latLng.longitude),
                            )
                          },
                          onMapCreated: (controller) =>
                              _mapController = controller,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latLng.latitude, latLng.longitude),
                            zoom: 15,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cardColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "key_Select_delivery_location".tr,
                    style: cardTextStyle16(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 25,
                        color: orangeColor(),
                      ),
                      _isLoading
                          ? SizedBox(
                              width: 150,
                              child: LinearProgressIndicator(
                                color: orangeColor(),
                              ))
                          : Text(_currentAddress,
                              overflow: TextOverflow.ellipsis,
                              style: mTextStyle16()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orangeColor(),
                        ),
                        child: Text(
                          'key_Edit'.tr,
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchLocation())).then((value) {
                            if (value == 'true') {
                              _getCurrentLocation();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  _isLocationConfirm
                      ? Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  //height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    //<-- SEE HERE
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      fillColor: inputColor(),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'key_Enter_Your_Kitchen_Owner_Name'.tr,
                                      hintStyle: inputTextStyle16(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'key_please_enter_your_Kitchen_Owner_Name_indentity'.tr;
                                      }
                                      if (!RegExp(r'^[a-zA-Z\s]+$')
                                          .hasMatch(value)) {
                                        return 'key_please_enter_your_Kitchen_Owner_Name_indentity'.tr;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      ownerName = value!;
                                      print(ownerName);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    //<-- SEE HERE
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      fillColor: inputColor(),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'key_Enter_Your_Address'.tr,
                                      hintStyle: inputTextStyle16(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'key_please_enter_your_Address_indentity'.tr;
                                      }
                                      if (value.length < 8) {
                                        return 'key_please_enter_your_Address_indentity'.tr;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      address = value!;
                                      print(address);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    //<-- SEE HERE
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      fillColor: inputColor(),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'key_Enter_Your_Landmark'.tr,
                                      hintStyle: inputTextStyle16(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'key_please_enter_your_Landmark_indentity'.tr;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      landmark = value!;
                                      print(landmark);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    //<-- SEE HERE
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      fillColor: inputColor(),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'key_pincode'.tr,
                                      hintStyle: inputTextStyle16(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'key_please_enter_your_Pincode_indentity'.tr;
                                      }
                                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                                        return 'key_please_enter_your_Pincode_indentity'.tr;
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
                                  height: 3,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(37, 40, 48, 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'key_Enter_Your_Address_Type'.tr,
                                            textAlign: TextAlign.left,
                                            style: inputTextStyle16(),
                                          ),
                                          DropdownButton(
                                            underline: const SizedBox(),
                                            value: selectedaddressType,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromRGBO(
                                                  255, 114, 105, 1),
                                            ),
                                            items:
                                                addressType.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items=='Home'?'key_Home'.tr: items=='Office'?'key_Work'.tr:'key_Other'.tr,
                                                  style: inputTextStyle16(),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedaddressType = newValue!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                //   child: SizedBox(
                                //     width: MediaQuery.of(context).size.width,
                                //     child: ElevatedButton(
                                //       style: ElevatedButton.styleFrom(
                                //         primary: orangeColor(),
                                //       ),
                                //       child: const Text(
                                //         'Save Location',
                                //         style: TextStyle(fontSize: 16),
                                //       ),
                                //       onPressed: () {
                                //         Navigator.push(context,
                                //             MaterialPageRoute(builder: (context) =>  const Question1()));
                                //       },
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState?.save();
                                          await fetchData();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Questions()));
                                        }
                                      },
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
                                              'key_Save_Address'.tr,
                                              style: mTextStyle14(),
                                            ),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isLocationConfirm = true;
                              });
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
                                    'key_Confirm_Location'.tr,
                                    style: mTextStyle14(),
                                  ),
                                )),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
