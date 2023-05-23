import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/register/searchLocation.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../models/dropdown.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import 'package:collection/collection.dart';

class ViewAddress extends StatefulWidget {
  const ViewAddress({Key? key}) : super(key: key);

  @override
  State<ViewAddress> createState() => _ViewAddressState();
}

class _ViewAddressState extends State<ViewAddress> {
  Map addressData = {};
  Map updatedAddressData = {};
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  var locality;
  var state;
  var subLocality;
  var addressType;
  double latitide = 0;
  double longtude = 0;
  String addressID = '';
  String cityId = '';
  String stateId = '';
  String areaName = '';
  int type = 1;


  TextEditingController officeAddress = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  List<DropdownItem> _dropdownStates = [];
  List<DropdownItem> _dropdownCities = [];
  List<DropdownItem> _dropdownArea = [];

  DropdownItem? _selectedState;
  DropdownItem? _selectedCity;
  DropdownItem? _selectedArea;

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
      state = addressData['state']['name'].toString();
      addressType = addressData['address_type'].toString();
      stateId = addressData['state_id'].toString();
      cityId = addressData['city_id'].toString();
      areaName = addressData['area'].toString();
      print(state);
      if (addressType == 'Other') {
        type = 3;
        setState(() {});
      } else if (addressType == 'Work') {
        type = 2;
        setState(() {});
      } else {
        type = 1;
        setState(() {});
      }
      if (addressData['latitude'].toString() != 'null') {
        latitide = double.parse(addressData['latitude'].toString());
      }
      if (addressData['longitude'].toString() != 'null') {
        longtude = double.parse(addressData['longitude'].toString());
      }
      addressID = addressData['id'].toString();
      await Sharedprefrences.saveAddressID(addressID);
      setState(() {
        isLoading = false;
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ?fetchAddress():null;
    }else {
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
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var area = subLocality.toString();
      var cityName = locality.toString();
      var address = addressController.text;
      var landMark = landmarkController.text ?? '';
      var pincode = int.parse(pincodeController.text);
      var latitude = latitide.toString();
      var longitude = longtude.toString();
      String token = await Sharedprefrences.getToken();
      Map body = {
        "city_id": cityId ?? '',
        "state_id": stateId ?? '',
        "area": areaName ?? '',
        "address_id": addressID,
        "office_name": officeAddress.text,
        "address": address,
        "land_mark": landMark,
        "pin_code": "$pincode",
        "address_type": "1",
        "latitude": latitude,
        "longitude": longitude,
        "address_type": "$type",
      };

      print(body);
      final response = await http.post(
        Uri.parse("$baseUrl/create-or-update-address"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: body
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var message = jsonData['message'];
        updatedAddressData = jsonData['data'];
        print(updatedAddressData);
        ScaffoldSnackbar.of(context).show(message);
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      }
      else if(response.statusCode == 401) {
        print("refresh token called");
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ?updateAddress(addressID):null;
      }else {
        print('Request failed with status: ${response.statusCode}.');
        ScaffoldSnackbar.of(context)
            .show('we are currently available in 3 places Prahlad Nagar, Paldi, University Area.');
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

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
        setState(() {
        });
      } else if (cityData is Map<String, dynamic>) {
        // API response is a single object
        items.add(DropdownItem(
            id: cityData['id'].toString(), name: cityData['name']));
        setState(() {
        });
      }
      print("items $items");
      _dropdownCities = items;
      setState(() {
      });
      return items;

    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  Future<List<DropdownItem>> fetchCityArea(String cityId) async {
    String token = await Sharedprefrences.getToken();
    final response =
    await http.post(Uri.parse("$baseUrl/get-city-area"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "city_id": cityId
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cityAreaData = data['data'];
      print("cityAreaData: $cityAreaData");
      List<DropdownItem> items = [];

      if (cityAreaData is List) {
        // API response is an array
        for (var item in cityAreaData) {
          items
              .add(DropdownItem(id: item['id'].toString(), name: item['name']));
        }
      } else if (cityAreaData is Map<String, dynamic>) {
        // API response is a single object
        items.add(DropdownItem(
            id: cityAreaData['id'].toString(), name: cityAreaData['name']));
      }
      // print("items $items");
      setState(() {
        // Update the city list in the UI
        _dropdownArea = items;
      });
      return items;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  void initState() {
    fetchAddress();
    super.initState();
    fetchStates().then((items) {
      setState(() {
        _dropdownStates = items;
        _dropdownCities = [];
        _dropdownArea=[];
      });
    });
    // fetchCities("11").then((items) {
    //   setState(() {
    //     _dropdownCities = items;
    //   });
    // });
    // fetchCityArea("1").then((items) {
    //   setState(() {
    //     _dropdownArea = items;
    //   });
    // });
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
                _dropdownArea = [];
                _dropdownCities=[];
              });
            },
            icon: const Icon(Icons.edit),
          )
              : const SizedBox(),
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
                                                            const SearchLocation())).then(
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
                                                    const SearchLocation()))
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
                                            const BorderRadius
                                                .all(
                                                Radius.circular(
                                                    6)),
                                            color: const Color(
                                                0xFFF0F0F0),
                                            border: Border.all(
                                                color: const Color(
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
                            style: const TextStyle(color: Colors.white),
                            //<-- SEE HERE
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
                            style: const TextStyle(color: Colors.white),
                            //<-- SEE HERE
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
                        // DropdownButtonFormField<DropdownItem>(
                        //   value: _selectedState,
                        //   onChanged: isEditable
                        //       ? (newValue) {
                        //       stateId = "${_selectedState?.id}";
                        //       _selectedState = newValue;
                        //           // .firstWhere((item) => item.name == newValue);
                        //       print("stateId $stateId");
                        //     fetchCities("$stateId").then((value){
                        //       setState((){});
                        //       });
                        //   }
                        //       : null,
                        //   items: _dropdownStates.map((item) {
                        //     return DropdownMenuItem<DropdownItem>(
                        //       value: item,
                        //       child: Text("${item.name}"),
                        //     );
                        //   }).toList(),
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide.none,
                        //     ), // Remove the border
                        //     filled: true,
                        //     hintText: state,
                        //     fillColor: inputColor(), // Set the background color
                        //     contentPadding: const EdgeInsets.symmetric(
                        //       horizontal: 16.0,
                        //       vertical: 12.0,
                        //     ), // Adjust the content padding
                        //   ),
                        // ),

                        DropdownButtonFormField<DropdownItem>(
                          value: _selectedState,
                          onChanged: isEditable
                              ? (newValue) {
                            setState(() {
                              stateId = "${newValue?.id}";
                              _selectedState = newValue;
                              _dropdownCities =[];
                              _dropdownArea =[];
                              cityId = "";
                              areaName = "";
                              print("stateId $stateId");
                            });

                            fetchCities(stateId).then((value) {
                              setState(() {});
                            });
                          }
                              : null,
                          items:_dropdownStates.isNotEmpty? _dropdownStates.map((item1) {
                            return DropdownMenuItem<DropdownItem>(
                              value: item1,
                              child: Text("${item1.name}"),
                            );
                          }).toList():[],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ), // Remove the border
                            filled: true,
                            hintText: state,
                            fillColor: inputColor(), // Set the background color
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ), // Adjust the content padding
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        DropdownButtonFormField<DropdownItem>(
                          value:_selectedCity ?? _dropdownCities.firstOrNull,
                          onChanged: isEditable
                              ? (newValue) {
                            setState(() {
                              cityId = "${newValue?.id}";
                              areaName = "";
                              _selectedCity = newValue;
                              print("cityId $cityId");
                            });
                            fetchCityArea("${_selectedCity?.id}")
                                .then((value) => setState(() {}));
                          }
                              : null,
                          items: _dropdownCities.isNotEmpty
                               // No items in the dropdown
                              ? _dropdownCities.map((item2) {
                            return DropdownMenuItem<DropdownItem>(
                              value: item2,
                              child: Text("${item2.name}"),
                            );
                          }).toList() : [],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide.none), // Remove the border
                            filled: true,
                            hintText: locality,
                            fillColor:
                            inputColor(), // Set the background color
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical:
                                12.0), // Adjust the content padding
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<DropdownItem>(
                          value: _selectedArea,
                          onChanged: isEditable ? (newValue) {
                            setState(() {
                              areaName = "${newValue?.name}";
                              _selectedArea = newValue;
                              print("areaname $areaName ");
                            });
                          }:null,
                          items: _dropdownArea.isNotEmpty
                              ? _dropdownArea.map((item3) {
                            return DropdownMenuItem<DropdownItem>(
                              value: item3,
                              child: Text("${item3.name}"),
                            );
                          }).toList():[],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide.none), // Remove the border
                            filled: true,
                            hintText: subLocality,
                            fillColor:
                            inputColor(), // Set the background color
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical:
                                12.0), // Adjust the content padding
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
                            style: const TextStyle(color: Colors.white),
                            //<-- SEE HERE
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
                            style: const TextStyle(color: Colors.white),
                            //<-- SEE HERE
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
                            child: InkWell(
                              onTap: () async {
                                if (isEditable) {
                                  updateAddress(addressID);
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
                            InkWell(
                              onTap: () {
                                if (isEditable) {
                                  setState(() {
                                    type = 1;
                                  });
                                }
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                color: type == 1
                                    ? orangeColor()
                                    : const Color.fromRGBO(53, 56, 66, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
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
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                if (isEditable) {
                                  setState(() {
                                    type = 2;
                                  });
                                }
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                color: type == 2
                                    ? orangeColor()
                                    : const Color.fromRGBO(53, 56, 66, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
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
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                if (isEditable) {
                                  setState(() {
                                    type = 3;
                                  });
                                }
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                color: type == 3
                                    ? orangeColor()
                                    : const Color.fromRGBO(53, 56, 66, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
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