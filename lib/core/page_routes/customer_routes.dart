import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/data/models/customer/market_detail_result_model.dart';
import '../../features/data/models/customer/order_detail_result_model.dart';
import '../../features/data/repositories/customer_market_repository.dart';
import '../../features/data/repositories/customer_order_repository.dart';
import '../../features/data/repositories/customer_product_repository.dart';
import '../../features/presentation/customer_pages/address_detail/address_detail_page.dart';
import '../../features/presentation/customer_pages/address_save/address_save_page.dart';
import '../../features/presentation/customer_pages/addresses/addresses_page.dart';
import '../../features/presentation/customer_pages/basket/basket_page.dart';
import '../../features/presentation/customer_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/customer_pages/home/home_page.dart';
import '../../features/presentation/customer_pages/liked_products/liked_products_page.dart';
import '../../features/presentation/customer_pages/market_category/market_category.dart';
import '../../features/presentation/customer_pages/market_comment/market_comment_page.dart';
import '../../features/presentation/customer_pages/market_comments/market_comments_page.dart';
import '../../features/presentation/customer_pages/market_detail/market_detail_page.dart';
import '../../features/presentation/customer_pages/market_main_category/market_main_category.dart';
import '../../features/presentation/customer_pages/market_sub_category/market_sub_category.dart';
import '../../features/presentation/customer_pages/order_detail/order_detail_page.dart';
import '../../features/presentation/customer_pages/orders/orders_page.dart';
import '../../features/presentation/customer_pages/product_comment/product_comment_page.dart';
import '../../features/presentation/customer_pages/product_comments/product_comments_page.dart';
import '../../features/presentation/customer_pages/product_detail/product_detail_page.dart';
import '../../features/presentation/customer_pages/products/produtct_page.dart';
import '../../features/presentation/customer_pages/profile/profile_page.dart';
import '../../features/presentation/customer_pages/profile_edit/edit_profile_page.dart';
import '../../features/presentation/customer_pages/search/search_page.dart';
import '../../features/presentation/customer_pages/settings/settings_page.dart';
import '../../features/presentation/customer_pages/wallet/wallet_page.dart';
import '../../features/presentation/customer_pages/wallet_charge/charge_wallet_page.dart';
import '../../features/presentation/providers/customer_providers/market_comments_notifier.dart';
import '../../features/presentation/providers/customer_providers/market_detail_provider.dart';
import '../../features/presentation/providers/customer_providers/order_detail_notifier.dart';
import '../../features/presentation/providers/customer_providers/product_comments_notifier.dart';
import '../../features/presentation/providers/customer_providers/product_details_notifier.dart';
import '../../features/presentation/providers/customer_providers/products_notifier.dart';

void createCustomerRoutes(Sailor sailor) {
  sailor.addRoutes(
    [
      SailorRoute(
        name: DashBoardPage.route,
        builder: (ctx, args, map) => DashBoardPage(),
      ),
      SailorRoute(
        name: HomePage.route,
        builder: (ctx, args, map) => HomePage(),
      ),
      SailorRoute(
        name: SearchPage.route,
        builder: (ctx, args, map) => SearchPage(),
      ),
      SailorRoute(
        name: BasketPage.route,
        builder: (ctx, args, map) => BasketPage(),
      ),
      SailorRoute(
        name: ProfilePage.route,
        builder: (ctx, args, map) => ProfilePage(),
      ),
      SailorRoute(
        name: SettingsPage.route,
        builder: (ctx, args, map) => SettingsPage(),
      ),
      SailorRoute(
        name: EditProfilePage.route,
        builder: (ctx, args, map) => EditProfilePage(),
      ),
      SailorRoute(
        name: MarketDetailPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) =>
                    MarketDetailNotifier(CustomerMarketRepository()),
              ),
              ChangeNotifierProvider(
                create: (ctx) => MarketCommentsNotifier(
                  CustomerMarketRepository(),
                ),
              )
            ],
            child: MarketDetailPage(marketId: marketId),
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: MarketCategoryPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");
          final marketCategories =
              map.param<List<Category>>("marketCategories");

          return MarketCategoryPage(
            marketId: marketId,
            categories: marketCategories,
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
          SailorParam<List<Category>>(
            name: "marketCategories",
            isRequired: true,
            defaultValue: [],
          ),
        ],
      ),
      SailorRoute(
        name: MarketMainCategoryPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");
          return MarketMainCategoryPage(
            marketId: marketId,
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: MarketSubCategoryPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");
          final mainCategoryId = map.param<String>("mainCategoryId");
          return MarketSubCategoryPage(
            marketId: marketId,
            mainCategoryId: mainCategoryId,
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
          SailorParam<String>(
            name: "mainCategoryId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: ProductsPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");
          final categoryId = map.param<String>("categoryId");

          return ChangeNotifierProvider(
            create: (ctx) => ProductsNotifier(
              CustomerProductRepository(),
            ),
            child: ProductsPage(
              marketId: marketId,
              categoryId: categoryId,
            ),
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
          SailorParam<String>(
            name: "categoryId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: ProductDetailPage.route,
        builder: (ctx, args, map) {
          final productId = map.param<String>("productId");
          final onAddToBasket = map.param<void Function()>("onAddToBasket");
          final onRemoveFromBasket =
              map.param<void Function()>("onRemoveFromBasket");

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => ProductCommentsNotifier(
                  CustomerProductRepository(),
                ),
              ),
              ChangeNotifierProvider(
                create: (ctx) => ProductDetailNotifier(
                  CustomerProductRepository(),
                ),
              ),
            ],
            child: ProductDetailPage(
              productId: productId,
              onAddToBasket: onAddToBasket,
              onRemoveFromBasket: onRemoveFromBasket,
            ),
          );
        },
        params: [
          SailorParam<String>(
            name: "productId",
            isRequired: true,
            defaultValue: "",
          ),
          SailorParam<void Function()>(
            name: "onAddToBasket",
            isRequired: true,
            defaultValue: () {},
          ),
          SailorParam<void Function()>(
            name: "onRemoveFromBasket",
            isRequired: true,
            defaultValue: () {},
          ),
        ],
      ),
      SailorRoute(
        name: ProductCommentsPage.route,
        builder: (ctx, args, map) {
          final productId = map.param<String>("productId");

          return ChangeNotifierProvider(
            create: (ctx) => ProductCommentsNotifier(
              CustomerProductRepository(),
            ),
            child: ProductCommentsPage(productId: productId),
          );
        },
        params: [
          SailorParam<String>(
            name: "productId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: ProductCommentPage.route,
        builder: (ctx, args, map) {
          final orderItem = map.param<OrderItem>("orderItem");
          final orderDetailNotifier =
              map.param<OrderDetailNotifier>("orderDetailNotifier");

          return ProductCommentPage(
            orderItem: orderItem,
            orderDetailNotifier: orderDetailNotifier,
          );
        },
        params: [
          SailorParam<OrderItem>(
            name: "orderItem",
            isRequired: true,
            defaultValue: null,
          ),
          SailorParam<OrderDetailNotifier>(
            name: "orderDetailNotifier",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: MarketCommentsPage.route,
        builder: (ctx, args, map) {
          final marketId = map.param<String>("marketId");

          return ChangeNotifierProvider(
            create: (ctx) => MarketCommentsNotifier(
              CustomerMarketRepository(),
            ),
            child: MarketCommentsPage(marketId: marketId),
          );
        },
        params: [
          SailorParam<String>(
            name: "marketId",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: MarketCommentPage.route,
        builder: (ctx, args, map) {
          final marketName = map.param<String>("marketName");
          return MarketCommentPage(marketName: marketName);
        },
        params: [
          SailorParam<String>(
            name: "marketName",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: WalletPage.route,
        builder: (ctx, args, map) => WalletPage(),
      ),
      SailorRoute(
        name: ChargeWalletPage.route,
        builder: (ctx, args, map) => ChargeWalletPage(),
      ),
      SailorRoute(
        name: OrdersPage.route,
        builder: (ctx, args, map) => OrdersPage(),
      ),
      SailorRoute(
        name: OrderDetailPage.route,
        builder: (ctx, args, map) {
          final orderId = map.param<String>("orderId");

          return ChangeNotifierProvider(
            create: (ctx) => OrderDetailNotifier(
              CustomerOrderRepository(),
              CustomerProductRepository(),
            ),
            child: OrderDetailPage(orderId: orderId),
          );
        },
        params: [
          SailorParam<String>(
            name: "orderId",
            isRequired: true,
            defaultValue: "",
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
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: AddressSavePage.route,
        builder: (ctx, args, map) {
          var id, name, address, description;

          if (map != null) {
            id = map.param<String>("id");
            name = map.param<String>("name");
            address = map.param<String>("address");
            description = map.param<String>("description");
          }

          return AddressSavePage(
            id: id,
            name: name,
            address: address,
            description: description,
          );
        },
        params: [
          SailorParam<String>(name: "id"),
          SailorParam<String>(name: "name"),
          SailorParam<String>(name: "address"),
          SailorParam<String>(name: "description"),
        ],
      ),
      SailorRoute(
        name: LikedProductsPage.route,
        builder: (ctx, args, map) => LikedProductsPage(),
      ),
    ],
  );
}
