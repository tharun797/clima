import 'package:geolocator/geolocator.dart';

class Location {

  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print('User denied request permission');
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude =  position.latitude;
      longitude =  position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

