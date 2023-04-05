import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tastesonway/screens/register/questions.dart';
import 'package:tastesonway/screens/register/searchLocation.dart';
import 'package:tastesonway/theme_data.dart';

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
  final _formKey = GlobalKey<FormState>();
  var addressType = [
    'Home',
    'Office',
    'Other',
  ];
  String dropdownvalue = 'Home';



  void _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latLng = LatLng(position.latitude, position.longitude);
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
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

  void _getAddressFromLatLng(Position position) async {
    print(position.latitude);
    print(position.longitude);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality}";
                //", ${place.postalCode}, ${place.country}";
      });
      print("this is current address $_currentAddress");
    } catch (e) {
      print(e);
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
                          child: CircularProgressIndicator(
                          color: orangeColor(),
                        ))
                      : GoogleMap(
                          markers: {
                            Marker(
                              markerId: MarkerId("user_location"),
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
              padding: EdgeInsets.all(10),
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
                    "Select Current Location",
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
                          primary: orangeColor(),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchLocation()));
                        },
                      ),
                    ],
                  ),
                  _isLocationConfirm
                      ? Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all( 3.0),
                          child: Column(
                            children: [
                              SizedBox(
                                //height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
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
                                    hintText: 'Kitchen Owner Name',
                                    hintStyle: inputTextStyle16(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter kitchen owner name';
                                    }
                                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                      return 'Please enter a valid name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    ownerName = value!;
                                    print(ownerName);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
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
                                    hintText: 'Address*',
                                    hintStyle: inputTextStyle16(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Address';
                                    }
                                    if (value.length < 10) {
                                      return 'Address must be at least 10 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    address = value!;
                                    print(address);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
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
                                    hintText: 'Landmark',
                                    hintStyle: inputTextStyle16(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter landmark';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    landmark = value!;
                                    print(landmark);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
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
                              SizedBox(
                                height: 3,
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
                                          'Select Address Type',
                                          textAlign: TextAlign.left,
                                          style: inputTextStyle16(),
                                        ),
                                        DropdownButton(
                                          underline: const SizedBox(),
                                          value: dropdownvalue,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Color.fromRGBO(255, 114, 105, 1),
                                          ),
                                          items: addressType.map((String items) {
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
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
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
                              SizedBox(height: 5,),
                              SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
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
                                            'Proceed',
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
                                    'Confirm Location',
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
