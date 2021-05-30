// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';

import '../consts/consts.dart';

class LocationService {
  static double longitude = 0;
  static double latitude = 0;
  static bool hasValue = longitude > 0 && latitude > 0;

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Position> getSavedLocation() async {
    var secureStorage = FlutterSecureStorage();
    String? p = await secureStorage.read(
      key: storageKeyUserLocation,
    ); // p stands for current position

    if (p == null) {
      await setSavedLocation();
      return getSavedLocation();
    }
    try {
      var latitude = double.parse(p.split('/')[0]);
      var longitude = double.parse(p.split('/')[1]);

      return Position(
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      await setSavedLocation();
      return getSavedLocation();
    }
  }

  static Future setSavedLocation() async {
    var p = await determinePosition(); // p stands for current position
    var secureStorage = FlutterSecureStorage();
    await secureStorage.write(
      key: storageKeyUserLocation,
      value: "${p.latitude}/${p.longitude}",
    );
  }

  static void refreshLocation() {
    determinePosition().then(
      (value) {
        longitude = value.longitude;
        latitude = value.latitude;
      },
    );
  }
}
