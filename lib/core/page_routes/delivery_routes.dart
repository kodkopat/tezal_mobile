// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/presentation/delivery_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/delivery_pages/orders/orders_page.dart';
import '../../features/presentation/delivery_pages/profile/profile_page.dart';
import '../../features/presentation/delivery_pages/wallet/wallet_page.dart';
import '../../features/presentation/delivery_pages/wallet_withdrawal/wallet_withdrawal_page.dart';
import '../../features/presentation/delivery_pages/wallet_withdrawal_requests/wallet_withdrawal_requests_page.dart';

void createDeliveryRoutes(Sailor sailor) {
  sailor.addRoutes(
    [
      SailorRoute(
        name: DashBoardPage.route,
        builder: (ctx, args, map) => DashBoardPage(),
      ),
      SailorRoute(
        name: OrdersPage.route,
        builder: (ctx, args, map) => OrdersPage(),
      ),
      SailorRoute(
        name: WalletPage.route,
        builder: (ctx, args, map) => WalletPage(),
      ),
      SailorRoute(
        name: ProfilePage.route,
        builder: (ctx, args, map) => ProfilePage(),
      ),
      SailorRoute(
        name: WithdrawalWalletPage.route,
        builder: (ctx, args, map) => WithdrawalWalletPage(),
      ),
      SailorRoute(
        name: WalletWithdrawalRequestsPage.route,
        builder: (ctx, args, map) => WalletWithdrawalRequestsPage(),
      ),
    ],
  );
}
