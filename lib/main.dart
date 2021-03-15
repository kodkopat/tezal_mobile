import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/screens/Customer/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:tezal/screens/Delivery/DeliveryMainPage.dart';
import 'package:tezal/screens/Market/MarketMainPage.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:tezal/services/LocationService.dart';
import 'app_localizations.dart';
import 'models/LoginModel.dart';

void main() {
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
    LocationService.setSavedLocation();
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
    String initialRoute = "/";
    var routes;

    switch (appType) {
      case "customer":
        routes = {
          '/': (context) => MainPage(),
        };
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
        routes = {
          '/': (context) => MarketMainPage(),
        };
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
        routes = {
          '/': (context) => DeliveryMainPage(),
        };
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
      initialRoute: initialRoute,
      routes: routes,
      localizationsDelegates: deligates,
      locale: locale,
      supportedLocales: supportedLocales,
      title: 'TezAl Market',
      debugShowCheckedModeBanner: false,
      theme: themeData,
    );
  }
}
