import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_localizations.dart';
import 'core/page_routes/routes.dart';
import 'models/LoginModel.dart';
import 'services/FlatColors.dart';

void main() {
  Routes.createRoutes();
  Routes.createCustomerRoutes();
  Routes.createMarketRoutes();
  Routes.createDeliveryRoutes();

  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_AppState>().restartApp();
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    // LocationService.setSavedLocation();
    super.initState();
  }

  Key key = UniqueKey();
  String appType = "customer";
  //String appType = "market";
  void restartApp() {
    storage.read(key: 'userinfo').then((value) {
      if (value != null && value.isNotEmpty) {
        var model = LoginModel.fromJson(json.decode(value));
        setState(() {
          key = UniqueKey();
          appType = model.data.type.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deligates = [
      AppLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
    var locale = Locale("fa", "IR");
    // var locale = Locale("en", "US");
    String fontFamily = locale.languageCode == 'fa' ? 'Yekan' : 'Arial';
    var supportedLocales = [Locale("en", "US"), Locale("fa", "IR")];
    var themeData;

    switch (appType) {
      case "customer":
        themeData = ThemeData(
          fontFamily: fontFamily,
          primaryColor: FlatColors.green_light,
          primaryColorDark: FlatColors.grey_dark,
          primaryColorLight: FlatColors.green_light,
          accentColor: FlatColors.green_light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
        break;
      case "market":
        themeData = ThemeData(
          fontFamily: fontFamily,
          primaryColor: FlatColors.blue_light,
          primaryColorDark: FlatColors.blue_dark,
          primaryColorLight: FlatColors.blue_light,
          accentColor: FlatColors.blue_light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
        break;
      case "delivery":
        themeData = ThemeData(
          fontFamily: fontFamily,
          primaryColor: FlatColors.pink_light,
          primaryColorDark: FlatColors.pink_dark,
          primaryColorLight: FlatColors.pink_light,
          accentColor: FlatColors.pink_light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
        break;
    }

    return MaterialApp(
      title: 'TezAl Market',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      // routing setting
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      // localization settings
      supportedLocales: supportedLocales,
      localizationsDelegates: deligates,
      locale: locale,
    );
  }
}

class AppUserType {
  static const customer = "customer";
  static const market = "market";
  static const delivery = "delivery";
}
