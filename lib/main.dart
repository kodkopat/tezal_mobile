import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'core/page_routes/base_routes.dart';
import 'core/page_routes/customer_routes.dart' as customer_routes;
import 'core/page_routes/delivery_routes.dart' as delivery_routes;
import 'core/page_routes/market_routes.dart' as market_routes;
import 'features/data/repositories/auth_repository.dart';
import 'features/presentation/app_notifier.dart';
import 'features/presentation/base_providers.dart';
import 'features/presentation/customer_providers.dart';
import 'features/presentation/delivery_providers.dart';
import 'features/presentation/market_providers.dart';
import 'injection_container_base_global_providers.dart';
import 'injection_container_customer_global_providers.dart';
import 'injection_container_delivery_global_providers.dart';
import 'injection_container_market_global_providers.dart';
import 'injection_container_repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]); // prevent application rotation

  // routers
  createBaseRoutes(Routes.sailor);
  customer_routes.createCustomerRoutes(Routes.sailor);
  market_routes.createMarketRoutes(Routes.sailor);
  delivery_routes.createDeliveryRoutes(Routes.sailor);

  // injection containers
  await initRepositories();
  await initBaseProviders();
  await initCustomerProviders();
  await initMarketProviders();
  await initDeliveryProviders();

  runApp(
    riverpod.ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppNotifier(AuthRepository()),
      child: Consumer<AppNotifier>(
        builder: (context, provider, child) {
          if (provider.textDirection == null && provider.loading) {
            provider.initialize();
          }

          return provider.loading
              ? SizedBox()
              : MultiProvider(
                  providers: baseProviders
                    ..addAll(customerProviders)
                    ..addAll(marketProviders)
                    ..addAll(deliveryProviders),
                  child: MaterialApp(
                    title: 'Tezal Market',
                    theme: provider.themeData,
                    debugShowCheckedModeBanner: false,
                    // routing setting
                    navigatorKey: Routes.sailor.navigatorKey,
                    onGenerateRoute: Routes.sailor.generator(),
                    builder: (context, child) => Directionality(
                      textDirection: provider.textDirection!,
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
                      Locale("en", "EN"),
                      Locale("fa", "FA"),
                      Locale("tr", "TR"),
                    ],
                    locale: provider.locale,
                  ),
                );
        },
      ),
    );
  }
}
