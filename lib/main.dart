import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'core/page_routes/routes.dart';
import 'core/services/location.dart';
import 'core/themes/app_theme.dart';
import 'features/data/repositories/auth_repository.dart';
import 'features/data/repositories/customer_address_repository.dart';
import 'features/data/repositories/customer_basket_repository.dart';
import 'features/data/repositories/customer_campaign_repository.dart';
import 'features/data/repositories/customer_category_repository.dart';
import 'features/data/repositories/customer_market_repository.dart';
import 'features/data/repositories/customer_order_repository.dart';
import 'features/data/repositories/customer_product_repository.dart';
import 'features/data/repositories/customer_repository.dart';
import 'features/data/repositories/customer_search_repository.dart';
import 'features/data/repositories/customer_wallet_repository.dart';
import 'features/presentation/providers/customer_providers/address_notifier.dart';
import 'features/presentation/providers/customer_providers/basket_notifier.dart';
import 'features/presentation/providers/customer_providers/campaign_notifier.dart';
import 'features/presentation/providers/customer_providers/category_notifier.dart';
import 'features/presentation/providers/customer_providers/location_notifier.dart';
import 'features/presentation/providers/customer_providers/market_notifier.dart';
import 'features/presentation/providers/customer_providers/order_notifier.dart';
import 'features/presentation/providers/customer_providers/liked_product_notifier.dart';
import 'features/presentation/providers/customer_providers/profile_notifier.dart';
import 'features/presentation/providers/customer_providers/search_notifier.dart';
import 'features/presentation/providers/customer_providers/wallet_notifier.dart';

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
  final _authRepository = AuthRepository();

  Key key = UniqueKey();
  _AppUserType? userType;

  void restartApp() {
    _authRepository.userType.then((value) {
      if (value.isNotEmpty) {
        setState(() {
          key = UniqueKey();
          userType = _AppUserTypeParser.fromString(value);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    LocationService.setSavedLocation();
    userType = widget.userType;
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
    var supportedLocales = [
      Locale("en", "US"),
      Locale("fa", "IR"),
    ];

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

    var materialApp = MaterialApp(
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => LocationNotifier(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CampaignNotifier(
            CustomerCampaignRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryNotifier(
            CustomerCategoryRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MarketNotifier(
            CustomerMarketRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProfileNotifier(
            CustomerRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AddressNotifier(
            CustomerAddressRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => WalletNotifier(
            CustomerWalletRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SearchNotifier(
            CustomerSearchRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => LikedProductNotifier(
            CustomerProductRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BasketNotifier(
            CustomerBasketRepository(),
            CustomerProductRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderNotifier(
            CustomerOrderRepository(),
            CustomerProductRepository(),
          ),
        ),
      ],
      child: materialApp,
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
