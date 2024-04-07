import 'package:geolocator/geolocator.dart';

// A class to handle location services
class LocationServices {
  // A method to check and request location service
  Future<void> checkAndRequestLocationService() async {
    // Check if location service is enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Throw an exception if location service is not enabled
      throw LocationServiceException();
    }
  }

  // A method to check and request location permission
  Future<void> checkAndRequestLocationPermission() async {
    // Get the current location permission status
    LocationPermission locationPermissionStatus =
        await Geolocator.checkPermission();
    // Check if location permission is denied forever
    if (locationPermissionStatus == LocationPermission.deniedForever) {
      // Throw an exception if location permission is denied forever
      throw LocationPermissionException();
    }
    // Check if location permission is denied
    if (locationPermissionStatus == LocationPermission.denied) {
      // Request location permission
      locationPermissionStatus = await Geolocator.requestPermission();
      // Check if location permission is still denied
      if (locationPermissionStatus == LocationPermission.denied) {
        // Throw an exception if location permission is denied
        throw LocationPermissionException();
      }
    }
  }

  // A method to get real-time location
  void getRealTimeLocation(void Function(Position)? onData) async {
    // Check and request location service
    await checkAndRequestLocationService();
    // Check and request location permission
    await checkAndRequestLocationPermission();
    // Listen to the position stream
    Geolocator.getPositionStream().listen(onData);
  }

  // A method to get the current location
  Future<Position> getCurrentLocation() async {
    // Check and request location service
    await checkAndRequestLocationService();
    // Check and request location permission
    await checkAndRequestLocationPermission();
    // Return the current position
    return await Geolocator.getCurrentPosition();
  }
}

// A class to represent a location service exception
class LocationServiceException implements Exception {}

// A class to represent a location permission exception
class LocationPermissionException implements Exception {}
