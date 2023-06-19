import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tastesonway/screens/register/questions.dart';
import 'package:tastesonway/screens/register/searchLocation.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../models/dropdown.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int refreshCounter = 0;
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
  String message = "";
  String cityId = '';
  String stateId = '';
  String areaName = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var addressType = [
    'Home',
    'Office',
    'Other',
  ];
  String selectedaddressType = 'Home';

  List<DropdownItem> _dropdownStates = [];
  List<DropdownItem> _dropdownCities = [];

  // List<DropdownItem> _dropdownArea = [];

  DropdownItem? _selectedState;
  DropdownItem? _selectedCity;

  // DropdownItem? _selectedArea;

  Future<List<DropdownItem>> fetchStates() async {
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse("$baseUrl/get-states"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "country_id": "1"
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final statesData = data['data'];
      List<DropdownItem> items = [];

      if (statesData is List) {
        // API response is an array
        for (var item in statesData) {
          items
              .add(DropdownItem(id: item['id'].toString(), name: item['name']));
        }
      } else if (statesData is Map<String, dynamic>) {
        // API response is a single object
        items.add(DropdownItem(
            id: statesData['id'].toString(), name: statesData['name']));
      }
      return items;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  Future<List<DropdownItem>> fetchCities(String stateId) async {
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse("$baseUrl/get-cities"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "state_id": stateId
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cityData = data['data'];
      List<DropdownItem> items = [];

      if (cityData is List) {
        // API response is an array
        for (var item in cityData) {
          items
              .add(DropdownItem(id: item['id'].toString(), name: item['name']));
        }
        setState(() {});
      } else if (cityData is Map<String, dynamic>) {
        // API response is a single object
        items.add(DropdownItem(
            id: cityData['id'].toString(), name: cityData['name']));
        setState(() {});
      }
      print("items $items");
      _dropdownCities = items;
      setState(() {});
      return items;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  // Future<List<DropdownItem>> fetchCityArea(String cityId) async {
  //   String token = await Sharedprefrences.getToken();
  //   final response =
  //   await http.post(Uri.parse("$baseUrl/get-city-area"), headers: {
  //     'Authorization': 'Bearer $token',
  //   }, body: {
  //     "city_id": cityId
  //   });
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final cityAreaData = data['data'];
  //     print("cityAreaData: $cityAreaData");
  //     List<DropdownItem> items = [];
  //
  //     if (cityAreaData is List) {
  //       // API response is an array
  //       for (var item in cityAreaData) {
  //         items
  //             .add(DropdownItem(id: item['id'].toString(), name: item['name']));
  //       }
  //     } else if (cityAreaData is Map<String, dynamic>) {
  //       // API response is a single object
  //       items.add(DropdownItem(
  //           id: cityAreaData['id'].toString(), name: cityAreaData['name']));
  //     }
  //     // print("items $items");
  //     setState(() {
  //       // Update the city list in the UI
  //       _dropdownArea = items;
  //     });
  //     return items;
  //   } else {
  //     throw Exception('Failed to fetch data from API');
  //   }
  // }

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
    } else {
      print(await _determinePosition());
      if (await _determinePosition() != null) {
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
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if Location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the Location services.
      ScaffoldSnackbar.of(context).show("Permission service was denied, but is needed for core functionality.");
      Future.delayed(const Duration(seconds: 4), () {
        Geolocator.openLocationSettings().then((value) => _determinePosition);
      });
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the Location services.
        ScaffoldSnackbar.of(context).show("Permission was denied, but is needed for core functionality.");
        Future.delayed(const Duration(seconds: 4), () {
          Geolocator.openLocationSettings().then((value) => _determinePosition);
        });
        Future.delayed(Duration(seconds: 10), _determinePosition);
        // return Future.error('Location permissions are disabled.');
        return null;
      }else{
        ScaffoldSnackbar.of(context).show("Permission was denied, but is needed for core functionality.");
        Future.delayed(const Duration(seconds: 4), () {
          Geolocator.openLocationSettings().then((value) => _determinePosition);
        });
        Future.delayed(Duration(seconds: 10), _determinePosition);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldSnackbar.of(context).show("Permission was denied, but is needed for core functionality.");
      Future.delayed(const Duration(seconds: 4), () {
        Geolocator.openLocationSettings().then((value) => _determinePosition);
      });
      Future.delayed(Duration(seconds: 10), _determinePosition);
      // return Future.error('Location permissions are disabled permanently.');
      return null;
    }

    return Geolocator.getCurrentPosition();
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
    if (selectedaddressType == 'Home') {
      type = 1;
    } else if (selectedaddressType == 'Office') {
      type = 2;
    } else {
      type = 3;
    }
    String token = await Sharedprefrences.getToken();
    final response = await http
        .post(Uri.parse('$baseUrl/create-or-update-address'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "office_name": ownerName ?? '',
      "city_id": cityId ?? '',
      "state_id": stateId ?? '',
      // "area": areaName ?? '',
      "area": sublocality,
      "address": address,
      "land_mark": landmark,
      "pin_code": pincode,
      "address_type": "$type",
      "latitude": "${latLng.latitude}",
      "longitude": "${latLng.longitude}"
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Sharedprefrences.setAddressDetailAdded(true);
      setState(() {
        isLoading = false;
        message = jsonData['message'];
        var data = jsonData['data'];
        print(data);
      });
      ScaffoldSnackbar.of(context).show(message);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Questions()));
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchData() : null;
      }
    } else {
      final jsonData = json.decode(response.body);
      message = jsonData['message'];
      setState(() {
        isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context).show(message);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    fetchStates().then((items) {
      setState(() {
        _dropdownStates = items;
        _dropdownCities = [];
        // _dropdownArea=[];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeColor(),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
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
                                target:
                                    LatLng(latLng.latitude, latLng.longitude),
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
                              style: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchLocation()))
                                  .then((value) {
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
                                child: SizedBox(
                                  height: 300,
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      SizedBox(
                                        //height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            hintText:
                                                'key_Enter_Your_Kitchen_Owner_Name'
                                                    .tr,
                                            hintStyle: inputTextStyle16(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'key_please_enter_your_Kitchen_Owner_Name_indentity'
                                                  .tr;
                                            }
                                            if (!RegExp(r'^[a-zA-Z\s]+$')
                                                .hasMatch(value)) {
                                              return 'key_please_enter_your_Kitchen_Owner_Name_indentity'
                                                  .tr;
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            hintText:
                                                'key_Enter_Your_Address'.tr,
                                            hintStyle: inputTextStyle16(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'key_please_enter_your_Address_indentity'
                                                  .tr;
                                            }
                                            if (value.length < 8) {
                                              return 'key_please_enter_your_Address_indentity'
                                                  .tr;
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            hintText:
                                                'key_Enter_Your_Landmark'.tr,
                                            hintStyle: inputTextStyle16(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'key_please_enter_your_Landmark_indentity'
                                                  .tr;
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'key_please_enter_your_Pincode_indentity'
                                                  .tr;
                                            }
                                            if (!RegExp(r'^\d{6}$')
                                                .hasMatch(value)) {
                                              return 'key_please_enter_your_Pincode_indentity'
                                                  .tr;
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
                                      DropdownButtonFormField<DropdownItem>(
                                        value: _selectedState,
                                        onChanged: (newValue) {
                                          setState(() {
                                            stateId = "${newValue?.id}";
                                            _selectedState = newValue;
                                            _dropdownCities = [];
                                            // _dropdownArea =[];
                                            cityId = "";
                                            areaName = "";
                                            print("stateId $stateId");
                                          });

                                          fetchCities(stateId).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        items: _dropdownStates.isNotEmpty
                                            ? _dropdownStates.map((item1) {
                                                return DropdownMenuItem<
                                                    DropdownItem>(
                                                  value: item1,
                                                  child: Text("${item1.name}"),
                                                );
                                              }).toList()
                                            : [],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          // Remove the border
                                          filled: true,
                                          hintText: "key_State".tr,
                                          fillColor: inputColor(),
                                          // Set the background color
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 12.0,
                                          ), // Adjust the content padding
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      DropdownButtonFormField<DropdownItem>(
                                        value: _selectedCity,
                                        onChanged: (newValue) {
                                          setState(() {
                                            cityId = "${newValue?.id}";
                                            areaName = "";
                                            _selectedCity = newValue;
                                            print("cityId $cityId");
                                          });
                                          // fetchCityArea("${_selectedCity?.id}")
                                          //     .then((value) => setState(() {}));
                                        },
                                        items: _dropdownCities.isNotEmpty
                                            // No items in the dropdown
                                            ? _dropdownCities.map((item2) {
                                                return DropdownMenuItem<
                                                    DropdownItem>(
                                                  value: item2,
                                                  child: Text("${item2.name}"),
                                                );
                                              }).toList()
                                            : [],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none),
                                          // Remove the border
                                          filled: true,
                                          hintText: "key_City".tr,
                                          fillColor: inputColor(),
                                          // Set the background color
                                          contentPadding: const EdgeInsets
                                                  .symmetric(
                                              horizontal: 16.0,
                                              vertical:
                                                  12.0), // Adjust the content padding
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      // DropdownButtonFormField<DropdownItem>(
                                      //   value: _selectedArea,
                                      //   onChanged: (newValue) {
                                      //     setState(() {
                                      //       areaName = "${newValue?.name}";
                                      //       _selectedArea = newValue;
                                      //       print("areaname $areaName ");
                                      //     });
                                      //   },
                                      //   items: _dropdownArea.isNotEmpty
                                      //       ? _dropdownArea.map((item3) {
                                      //     return DropdownMenuItem<DropdownItem>(
                                      //       value: item3,
                                      //       child: Text("${item3.name}"),
                                      //     );
                                      //   }).toList():[],
                                      //   decoration: InputDecoration(
                                      //     border: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(10),
                                      //         borderSide:
                                      //         BorderSide.none), // Remove the border
                                      //     filled: true,
                                      //     hintText: "key_Area".tr,
                                      //     fillColor:
                                      //     inputColor(), // Set the background color
                                      //     contentPadding: const EdgeInsets.symmetric(
                                      //         horizontal: 16.0,
                                      //         vertical:
                                      //         12.0), // Adjust the content padding
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                37, 40, 48, 1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'key_Enter_Your_Address_Type'
                                                      .tr,
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
                                                  items: addressType
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items == 'Home'
                                                            ? 'key_Home'.tr
                                                            : items == 'Office'
                                                                ? 'key_Work'.tr
                                                                : 'key_Other'
                                                                    .tr,
                                                        style:
                                                            inputTextStyle16(),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedaddressType =
                                                          newValue!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 45,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: InkWell(
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState?.save();
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                await fetchData();
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const Questions()));
                                              }
                                            },
                                            child: Card(
                                                shadowColor: Colors.black,
                                                color: orangeColor(),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
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
    );
  }
}
