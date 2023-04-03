import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tastesonway/screens/register/questions1.dart';
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
            "${place.locality}, ${place.postalCode}, ${place.country}";
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
              // height: 140,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchLocation()));
                        },
                      ),
                    ],
                  ),
                  _isLocationConfirm?
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: const TextStyle(color: Colors.white), //<-- SEE HERE
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
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: const TextStyle(color: Colors.white), //<-- SEE HERE
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
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: const TextStyle(color: Colors.white), //<-- SEE HERE
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
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: const TextStyle(color: Colors.white), //<-- SEE HERE
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
                        SizedBox(height: 3,),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: const TextStyle(color: Colors.white), //<-- SEE HERE
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Address Type',
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: orangeColor(),
                              ),
                              child: const Text(
                                'Save Location',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  const Question1()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  :Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: orangeColor(),
                        ),
                        child: const Text(
                          'Confirm Location',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLocationConfirm = true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
