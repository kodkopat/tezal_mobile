import 'package:flutter/foundation.dart';

import '../themes/theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();

  bool _isDark = false;

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    themePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
