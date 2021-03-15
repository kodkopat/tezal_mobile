import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('location');
    if (data == null) {
      await setSavedLocation();
      return getSavedLocation();
    }
    try {
      return Position(
          longitude: double.parse(data.split('/')[0]),
          latitude: double.parse(data.split('/')[1]));
    } catch (e) {
      await setSavedLocation();
      return getSavedLocation();
    }
  }

  static Future setSavedLocation() async {
    var prefs = await SharedPreferences.getInstance();
    var pos = await determinePosition();
    await prefs.setString(
        'location', pos.longitude.toString() + '/' + pos.latitude.toString());
  }

  static void refreshLocation() {
    determinePosition().then((value) {
      longitude = value.longitude;
      latitude = value.latitude;
    });
  }
}
