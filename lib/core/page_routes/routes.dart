import 'package:sailor/sailor.dart';

import '../../features/presentation/customer_pages/address_detail/address_detail_page.dart';
import '../../features/presentation/customer_pages/addresses/addresses_page.dart';
import '../../features/presentation/customer_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/customer_pages/edit_profile/edit_profile_page.dart';
import '../../features/presentation/customer_pages/liked_products/liked_products_page.dart';
import '../../features/presentation/customer_pages/market_comments/market_comments_page.dart';
import '../../features/presentation/customer_pages/market_detail/market_detail_page.dart';
import '../../features/presentation/customer_pages/product_comments/product_comments_page.dart';
import '../../features/presentation/customer_pages/product_detail/product_detail_page.dart';
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
          name: EditProfilePage.route,
          builder: (ctx, args, map) => EditProfilePage(),
        ),
        SailorRoute(
          name: MarketDetailPage.route,
          builder: (ctx, args, map) {
            final marketId = map.param<String>("marketId");
            return MarketDetailPage(marketId: marketId);
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
          name: ProductDetailPage.route,
          builder: (ctx, args, map) {
            final productId = map.param<String>("productId");
            return ProductDetailPage(productId: productId);
          },
          params: [
            SailorParam<String>(
              name: "productId",
              isRequired: true,
              defaultValue: null,
            ),
          ],
        ),
        SailorRoute(
          name: ProductCommentsPage.route,
          builder: (ctx, args, map) {
            final productId = map.param<String>("productId");
            return ProductCommentsPage(productId: productId);
          },
          params: [
            SailorParam<String>(
              name: "productId",
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
        SailorRoute(
          name: AddressDetailPage.route,
          builder: (ctx, args, map) {
            final addressId = map.param<String>("addressId");
            return AddressDetailPage(addressId: addressId);
          },
          params: [
            SailorParam<String>(
              name: "addressId",
              isRequired: true,
              defaultValue: null,
            ),
          ],
        ),
        SailorRoute(
          name: LikedProductsPage.route,
          builder: (ctx, args, map) => LikedProductsPage(),
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
