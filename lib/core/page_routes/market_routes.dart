// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/data/models/market/orders_result_model.dart';
import '../../features/data/models/market/product_result_model.dart';
import '../../features/presentation/market_pages/add_bank_card_informations/add_bank_card_informations_page.dart';
import '../../features/presentation/market_pages/add_product/add_product_page.dart';
import '../../features/presentation/market_pages/add_products/add_products_page.dart';
import '../../features/presentation/market_pages/bank_card_informations/banks_card_informations.dart';
import '../../features/presentation/market_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/market_pages/order_detail/order_detail_page.dart';
import '../../features/presentation/market_pages/orders/orders_page.dart';
import '../../features/presentation/market_pages/products/products_page.dart';
import '../../features/presentation/market_pages/profile/profile_page.dart';
import '../../features/presentation/market_pages/wallet/wallet_page.dart';
import '../../features/presentation/market_pages/wallet_withdrawal/wallet_withdrawal_page.dart';
import '../../features/presentation/market_pages/wallet_withdrawal_requests/wallet_withdrawal_requests_page.dart';

void createMarketRoutes(Sailor sailor) {
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
        name: ProductsPage.route,
        builder: (ctx, args, map) => ProductsPage(),
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
        name: BankCardInformationsPage.route,
        builder: (ctx, args, map) => BankCardInformationsPage(),
      ),
      SailorRoute(
        name: AddBankCardInformationsPage.route,
        builder: (ctx, args, map) => AddBankCardInformationsPage(),
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
      SailorRoute(
        name: WithdrawalWalletPage.route,
        builder: (ctx, args, map) => WithdrawalWalletPage(),
      ),
      SailorRoute(
        name: WalletWithdrawalRequestsPage.route,
        builder: (ctx, args, map) => WalletWithdrawalRequestsPage(),
      ),
      SailorRoute(
        name: AddProductsPage.route,
        builder: (ctx, args, map) => AddProductsPage(),
      ),
      SailorRoute(
        name: AddProductPage.route,
        builder: (ctx, args, map) {
          final product = map.param<ProductResultModel>("product");

          return AddProductPage(product: product);
        },
        params: [
          SailorParam<ProductResultModel>(
            name: "product",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
    ],
  );
}
