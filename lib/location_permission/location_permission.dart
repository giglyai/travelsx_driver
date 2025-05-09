import 'package:geolocator/geolocator.dart';

class LocationPermissionHandler {
  static final LocationPermissionHandler _singleton =
      LocationPermissionHandler._internal();
  factory LocationPermissionHandler() => _singleton;
  LocationPermissionHandler._internal() {
    requestLocationPermission();
  }

  // Future<bool> handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
  //         const SnackBar(
  //             content: Text(
  //                 'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
  //         const SnackBar(
  //             content: Text(
  //                 'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  static LocationPermissionHandler get instance => _singleton;
}
