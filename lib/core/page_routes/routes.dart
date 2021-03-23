import 'package:sailor/sailor.dart';

import '../../features/data/models/nearby_markets_result_model.dart';
import '../../features/presentation/customer_pages/addresses/addresses_page.dart';
import '../../features/presentation/customer_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/customer_pages/market_comments/market_comments_page.dart';
import '../../features/presentation/customer_pages/market_detail/market_detail_page.dart';
import '../../features/presentation/splash/splash_page.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: SplashPage.route,
          builder: (ctx, args, map) => SplashPage(),
        ),
      ],
    );
  }

  static void createCustomerRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: CustomerDashBoardPage.route,
          builder: (ctx, args, map) => CustomerDashBoardPage(),
        ),
        SailorRoute(
          name: MarketDetailPage.route,
          builder: (ctx, args, map) {
            final market = map.param<Market>("market");
            return MarketDetailPage(market: market);
          },
          params: [
            SailorParam<Market>(
              name: "market",
              isRequired: true,
              defaultValue: null,
            ),
          ],
        ),
        SailorRoute(
          name: MarketCommentsPage.route,
          builder: (ctx, args, map) {
            final marketId = map.param<String>("marketId");
            return MarketCommentsPage(marketId: marketId);
          },
          params: [
            SailorParam<String>(
              name: "marketId",
              isRequired: true,
              defaultValue: null,
            ),
          ],
        ),
        SailorRoute(
          name: AddressesPage.route,
          builder: (ctx, args, map) => AddressesPage(),
        ),
      ],
    );
  }

  static void createMarketRoutes() {
    sailor.addRoutes(
      [],
    );
  }

  static void createDeliveryRoutes() {
    sailor.addRoutes(
      [],
    );
  }
}
