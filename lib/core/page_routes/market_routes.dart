// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/data/models/market/orders_result_model.dart';
import '../../features/presentation/market_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/market_pages/order_detail/order_detail_page.dart';

void createMarketRoutes(Sailor sailor) {
  sailor.addRoutes(
    [
      SailorRoute(
        name: DashBoardPage.route,
        builder: (ctx, args, map) => DashBoardPage(),
      ),
      SailorRoute(
        name: OrderDetailPage.route,
        builder: (ctx, args, map) {
          final marketOrder = map.param<MarketOrder>("marketOrder");

          return OrderDetailPage(marketOrder: marketOrder);
        },
        params: [
          SailorParam<MarketOrder>(
            name: "marketOrder",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
    ],
  );
}
