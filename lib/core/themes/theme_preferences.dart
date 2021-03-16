import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static final _storageKey = "THEME_STORAGE_KEY";

  void setDarkTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_storageKey, value);
  }

  Future<bool> getDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_storageKey) ?? false;
  }
}
