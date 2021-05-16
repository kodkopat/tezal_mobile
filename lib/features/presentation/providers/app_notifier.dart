import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../app_localizations.dart';
import '../../../core/consts/consts.dart';
import '../../../core/services/location.dart';
import '../../../core/themes/app_theme.dart';
import '../../data/models/app_user_type.dart';
import '../../data/repositories/auth_repository.dart';

class AppNotifier extends ChangeNotifier {
  static AppNotifier? _instance;

  factory AppNotifier(AuthRepository authRepository) {
    if (_instance == null) {
      _instance = AppNotifier._privateConstructor(authRepository);
    }

    return _instance!;
  }

  final AuthRepository authRepo;

  AppNotifier._privateConstructor(this.authRepo);

  bool loading = true;

  AppUserType? userType;
  Locale? locale;
  String? fontFamily;
  TextDirection? textDirection;
  ThemeData? themeData;

  Future<void> initialize() async {
    LocationService.setSavedLocation();

    var fetchUserTypeResult = await authRepo.userType;
    if (fetchUserTypeResult != null && fetchUserTypeResult.isNotEmpty) {
      userType = AppUserTypeParser.fromString(fetchUserTypeResult);
    } else {
      userType = AppUserType.Customer;
    }

    var currentLanguageCode =
        await FlutterSecureStorage().read(key: storageKeyLocalCode);

    var tempLocale = currentLanguageCode == null
        ? Locale('fa')
        : Locale(currentLanguageCode);

    locale = AppLocalizations(tempLocale).locale;

    if (locale!.languageCode == 'fa') {
      fontFamily = 'Yekan';
      textDirection = TextDirection.rtl;
    } else {
      fontFamily = 'Lato';
      textDirection = TextDirection.ltr;
    }

    switch (userType) {
      case AppUserType.Customer:
        themeData = AppTheme.customerThemeData(fontFamily!);
        break;
      case AppUserType.Market:
        themeData = AppTheme.marketThemeData(fontFamily!);
        break;
      case AppUserType.Delivery:
        themeData = AppTheme.deliveryThemeData(fontFamily!);
        break;
      case null:
        themeData = AppTheme.customerThemeData(fontFamily!);
        break;
    }

    loading = false;
    notifyListeners();
  }

  void refresh() async {
    initialize();
  }
}
