import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:google_maps_webservice/places.dart' as Places;
import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';


class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  int refreshCounter = 0;

  final _controller = TextEditingController();
  final Places.GoogleMapsPlaces _places = Places.GoogleMapsPlaces(
      apiKey: 'AIzaSyAgAXZ8dszokAmE1E9rm9LHlIt1IOd0NSI');
  var uuid = const Uuid();
  List<dynamic> predictions = [];
  bool _isLoading = false;
  bool isServicePresent = false;
  bool hasLocationPermission = false;
  LatLng latLng = const LatLng(23.0000, 72.000);
  String _currentAddress = "";

  Future<void> autoCompleteSearch(String value) async {
    var kPLACESAPIKEY = 'AIzaSyAgAXZ8dszokAmE1E9rm9LHlIt1IOd0NSI';
    var uuids = uuid.v4();

    Future getAllPlaces(String value, String PLACESAPIKEY, String uuid) async {
      var baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      var request =
          '$baseURL?input=$value&key=$PLACESAPIKEY&sessiontoken=$uuid';
      var response = await http.get(Uri.parse(request));
      return response;
    }
    await getAllPlaces(value, kPLACESAPIKEY, uuids)
        .then((allPalcesResponse) async {
      print(allPalcesResponse);

      dynamic status = allPalcesResponse.body;
      if (allPalcesResponse.statusCode == 200) {
        setState(() {
          isServicePresent = false;
        });

        dynamic result = json.decode(status.toString());
        if (result['status'] == 'OK') {
          print(result);
          setState(() {
            predictions = result['predictions'] as List;
          });
        }
        if (result['status'] == 'ZERO_RESULTS') {
          setState(() {
            predictions = [];
          });
        }
      } else if(allPalcesResponse.statusCode == 401) {
        print("refresh token called");if (refreshCounter == 0) {
          refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ?autoCompleteSearch(value):null;}
      }else {
        throw Exception('Failed to fetch suggestion');
      }
    });
  }

  Future<void> displayPrediction(String placeId, String description) async {
    setState(() {
      _isLoading = true;
    });
    try {
      var detail =
      await _places.getDetailsByPlaceId(placeId);
      var lat = detail.result.geometry?.location.lat;
      var lng = detail.result.geometry?.location.lng;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
      print(placemarks);
      // var address = await Geocoder.local.findAddressesFromQuery(description);
      // List<Location> locations = await locationFromAddress(description);
      await Sharedprefrences.setTempLocation(true);
      if (placemarks.first.subLocality != null) {
        await Sharedprefrences.setSubLocality(
            placemarks.first.subLocality.toString());
      } else {
        await Sharedprefrences.setSubLocality(
            placemarks.first.name.toString());
      }
      await Sharedprefrences.setLocality(
          placemarks.first.locality.toString());
      await Sharedprefrences.setTempLat(lat);
      await Sharedprefrences.setTempLog(lng);
      Navigator.pop(context, 'true');
    } catch (e) {
      print('Error occured: $e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void getCurrentLocation() async {
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
  }

  void _getAddressFromLatLng(Position position) async {
    var tempLocation = await Sharedprefrences.getTempLocation() ?? false;
    var getSubLocality = await Sharedprefrences.getSubLocality();
    var getLocality = await Sharedprefrences.getLocality();
    var TempLat = await Sharedprefrences.getTempLat();
    var TempLog = await Sharedprefrences.getTempLog();

    if (tempLocation) {
      setState(() {
        _currentAddress =
        "$getSubLocality $getLocality";
      });
    }
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      if (place != null) {
        Sharedprefrences.setTempLocation(true);
        if (place.subLocality != null) {
          Sharedprefrences.setSubLocality(
              place.subLocality.toString());
        } else {
          Sharedprefrences.setSubLocality(
              place.locality.toString());
        }
        Sharedprefrences.setLocality(place.locality.toString());
        Sharedprefrences.setTempLat(position.latitude);
        Sharedprefrences.setTempLog(position.longitude);
        Navigator.pop(context, 'true');
        setState(() {
          _isLoading = false;
          _currentAddress =
          "${place.subLocality} ${place.locality}";
        });
        print("this is current address $_currentAddress");
      }
      else {
        Navigator.pop(context, 'true');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
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
            'key_Search_Location'.tr,
            style: cardTitleStyle20(),
          ),
        ),
        body:
        _isLoading? Center(child: CircularProgressIndicator(color: orangeColor(),)):InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Container(
              color: backgroundColor(),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: cardColor(),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search, color: orangeColor(),),
                              suffixIcon:
                              _controller.text.length > 2
                                  ? IconButton(
                                onPressed: () {
                                  var
                                  currentFocus =
                                  FocusScope.of(
                                      context);
                                  if (!currentFocus
                                      .hasPrimaryFocus &&
                                      currentFocus
                                          .focusedChild !=
                                          null) {
                                    currentFocus
                                        .focusedChild
                                        ?.unfocus();
                                  }
                                  setState(() {
                                    _controller.clear();
                                    predictions.clear();
                                  });
                                },
                                icon: Icon(Icons.clear, color: orangeColor(),),
                              )
                                  : null,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'key_Search_for_your_location'.tr),
                          onChanged: (value) {
                            if (value.length > 2) {
                              autoCompleteSearch(value);
                            } else {
                              if (predictions.isNotEmpty &&
                                  mounted) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        visualDensity: const VisualDensity(
                            vertical: -4),
                        contentPadding: const EdgeInsets.symmetric(
                        ),
                        dense: true,
                        leading: Icon(
                          Icons.my_location_outlined,
                          color: orangeColor(),
                          size: 16,
                        ),
                        minLeadingWidth: 10,
                        title: Text(
                          'key_Use_current_location'.tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: orangeColor()),
                        ),
                        onTap: () {
                          getCurrentLocation();
                        },
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: predictions.length,
                          shrinkWrap: true,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) =>
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: Icon(
                                  Icons.pin_drop_outlined,
                                  color: orangeColor(),
                                ),
                                title: Text(predictions[index]
                                ['description']
                                    .toString(), style: mTextStyle14(),),
                                onTap: () {
                                  print(predictions[index]['place_id']
                                      .toString());
                                  displayPrediction(
                                      predictions[index]['place_id']
                                          .toString(),
                                      predictions[index]
                                      ['description']
                                          .toString());
                                },
                              ),
                        ),
                      ),

                    ],
                  )),
            ),
          ),
        ),
      );
    }
  }
