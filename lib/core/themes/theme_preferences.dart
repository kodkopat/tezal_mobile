// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemePreferences {
  static final _storageKey = "THEME_STORAGE_KEY";

  ThemePreferences() : _secureStorage = FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  void setDarkTheme(bool value) async {
    _secureStorage.write(
      key: _storageKey,
      value: value.toString(),
    );
  }

  Future<bool> getDarkTheme() async {
    final result = await _secureStorage.read(
      key: _storageKey,
    );

    return result.toLowerCase() == "true";
  }
}
