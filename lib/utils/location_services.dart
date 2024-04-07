import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<void> checkAndRequestLocationService() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw LocationServiceException();
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    LocationPermission locationPermissionStatus =
        await Geolocator.checkPermission();
    if (locationPermissionStatus == LocationPermission.deniedForever) {
      throw LocationPermissionException();
    }
    if (locationPermissionStatus == LocationPermission.denied) {
      locationPermissionStatus = await Geolocator.requestPermission();
      if (locationPermissionStatus == LocationPermission.denied) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocation(void Function(Position)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    Geolocator.getPositionStream().listen(onData);
  }

  Future<Position> getCurrentLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await Geolocator.getCurrentPosition();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
