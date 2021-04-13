import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';

class LocationNotifier extends ChangeNotifier {
  static LocationNotifier? _instance;

  factory LocationNotifier() {
    if (_instance == null) {
      _instance = LocationNotifier._privateConstructor();
    }

    return _instance!;
  }

  LocationNotifier._privateConstructor();

  bool loading = true;
  bool gpsServiceEnabled = false;
  Position? currentLocation;

  Future<void> fetechLocation(BuildContext context) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied,'
        ' we cannot request permissions.',
      );
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
          'Location permissions are denied'
          ' (actual value: $permission).',
        );
      }
    }

    // var prgDialog = AppProgressDialog(context).instance;
    // prgDialog.show();

    gpsServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (gpsServiceEnabled) {
      currentLocation = await Geolocator.getCurrentPosition();
      print(
        "currentLocation Lat: ${currentLocation!.latitude}\n"
        "currentLocation Lng: ${currentLocation!.longitude}\n",
      );
    }

    // prgDialog.hide();
    loading = false;
    notifyListeners();
  }
}
