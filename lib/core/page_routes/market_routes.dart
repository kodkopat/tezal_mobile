// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/presentation/market_pages/dashboard/dashboard_page.dart';

void createMarketRoutes(Sailor sailor) {
  sailor.addRoutes(
    [
      SailorRoute(
        name: DashBoardPage.route,
        builder: (ctx, args, map) => DashBoardPage(),
      ),
    ],
  );
}
