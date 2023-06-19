import 'package:location/location.dart';

class LocationService {

  static Future<bool> checkLocationService() async {
    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return await Location().serviceEnabled();
  }

  static Future<bool> checkLocationPermission() async {
    var permissionGranted = await Location().hasPermission();
    if (permissionGranted == PermissionStatus.granted) {
      permissionGranted = await Location().requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

}