import 'package:flutter/material.dart';

class DirectionNotifier extends ChangeNotifier {
  static DirectionNotifier? _instance;

  factory DirectionNotifier() {
    if (_instance == null) {
      _instance = DirectionNotifier._privateConstructor();
    }

    return _instance!;
  }

  DirectionNotifier._privateConstructor();

  TextDirection value = TextDirection.rtl;

  void refreshLocalization(BuildContext context) {
    final Locale appLocale = Localizations.localeOf(context);

    value = (appLocale.languageCode == "fa")
        ? TextDirection.rtl
        : TextDirection.ltr;

    notifyListeners();
  }
}
