import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'core/consts/consts.dart';
import 'core/page_routes/routes.dart';
import 'core/services/location.dart';
import 'core/themes/app_theme.dart';
import 'features/base_providers.dart';
import 'features/customer_providers.dart';
import 'features/data/repositories/auth_repository.dart';
import 'features/delivery_providers.dart';
import 'features/market_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]); // prevent application rotation

  Routes.createRoutes();
  Routes.createCustomerRoutes();
  Routes.createMarketRoutes();
  Routes.createDeliveryRoutes();

  final _authRepository = AuthRepository();
  _AppUserType userType;

  final value = await _authRepository.userType;
  if (value != null && value.isNotEmpty) {
    userType = _AppUserTypeParser.fromString(value);
  } else {
    userType = _AppUserType.Customer;
  }

  runApp(
    App(userType: userType),
  );
}

class App extends StatefulWidget {
  const App({@required this.userType});

  final _AppUserType? userType;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppUserType? userType;
  late String fontFamily;
  late TextDirection textDirection;
  late Locale locale;

  Future<void> initializeState() async {
    LocationService.setSavedLocation();
    userType = widget.userType;

    String? languageCode =
        await FlutterSecureStorage().read(key: storageKeyLocalCode);

    var tempLocale = languageCode == null ? Locale(languageCode) : Locale('fa');

    locale = AppLocalizations(tempLocale).locale;

    if (locale.languageCode == 'fa') {
      fontFamily = 'Yekan';
      textDirection = TextDirection.rtl;
    } else {
      fontFamily = 'Arial';
      textDirection = TextDirection.ltr;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    var themeData;
    switch (userType) {
      case _AppUserType.Customer:
        themeData = AppTheme.customerThemeData(fontFamily);
        break;
      case _AppUserType.Market:
        themeData = AppTheme.marketThemeData(fontFamily);
        break;
      case _AppUserType.Delivery:
        themeData = AppTheme.deliveryThemeData(fontFamily);
        break;
      case null:
        themeData = AppTheme.customerThemeData(fontFamily);
        break;
    }

    var mainWidget = Directionality(
      textDirection: textDirection,
      child: MaterialApp(
        title: 'Tezal Market',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        // routing setting
        navigatorKey: Routes.sailor.navigatorKey,
        onGenerateRoute: Routes.sailor.generator(),
        builder: (context, child) => Directionality(
          textDirection: textDirection,
          child: child!,
        ),
        // localization settings
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("en"),
          Locale("fa"),
          Locale("tr"),
        ],
        locale: locale,
      ),
    );

    return MultiProvider(
      providers: baseProviders
        ..addAll(customerProviders)
        ..addAll(marketProviders)
        ..addAll(deliveryProviders),
      child: mainWidget,
    );
  }
}

enum _AppUserType {
  Customer,
  Market,
  Delivery,
}

class _AppUserTypeParser {
  static const _customerKey = "customer";
  static const _marketKey = "market";
  static const _deliveryKey = "delivery";

  static _AppUserType fromString(String userType) {
    if (userType.trim().isEmpty) return _AppUserType.Customer;

    switch (userType.toLowerCase()) {
      case _customerKey:
        return _AppUserType.Customer;
      case _marketKey:
        return _AppUserType.Market;
      case _deliveryKey:
        return _AppUserType.Delivery;
      default:
        return _AppUserType.Customer;
    }
  }
}
