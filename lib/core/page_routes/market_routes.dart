import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/data/models/market/market_comments_result_model.dart';
import '../../features/data/models/market/market_default_hours_result_model.dart';
import '../../features/data/models/market/market_profile_result_model.dart';
import '../../features/data/models/market/order_comments_result_model.dart';
import '../../features/data/models/market/orders_result_model.dart';
import '../../features/data/models/market/product_comments_result_model.dart';
import '../../features/data/models/market/product_result_model.dart';
import '../../features/data/repositories/market_order_repository.dart';
import '../../features/data/repositories/market_product_repository.dart';
import '../../features/presentation/market_pages/add_product/add_product_page.dart';
import '../../features/presentation/market_pages/add_product_draft/add_product_draft_page.dart';
import '../../features/presentation/market_pages/add_products/add_products_page.dart';
import '../../features/presentation/market_pages/comment_reply/comment_reply.dart';
import '../../features/presentation/market_pages/comments/comments_page.dart';
import '../../features/presentation/market_pages/dashboard/dashboard_page.dart';
import '../../features/presentation/market_pages/default_hours/default_hours_page.dart';
import '../../features/presentation/market_pages/default_hours_edit/edit_default_hours_page.dart';
import '../../features/presentation/market_pages/order_comment_reply/order_comment_reply_page.dart';
import '../../features/presentation/market_pages/order_comments/order_comments_page.dart';
import '../../features/presentation/market_pages/order_detail/order_detail_page.dart';
import '../../features/presentation/market_pages/orders/orders_page.dart';
import '../../features/presentation/market_pages/photos/photos_page.dart';
import '../../features/presentation/market_pages/product_comment_reply/product_comment_reply_page.dart';
import '../../features/presentation/market_pages/product_comments/product_comments_page.dart';
import '../../features/presentation/market_pages/product_detail/product_detail_page.dart';
import '../../features/presentation/market_pages/products/products_page.dart';
import '../../features/presentation/market_pages/profile/profile_page.dart';
import '../../features/presentation/market_pages/profile_info/profile_info_page.dart';
import '../../features/presentation/market_pages/profile_info_edit/edit_profile_page.dart';
import '../../features/presentation/market_pages/search_products/search_products_page.dart';
import '../../features/presentation/market_pages/wallet/wallet_page.dart';
import '../../features/presentation/market_pages/wallet_withdrawal/wallet_withdrawal_page.dart';
import '../../features/presentation/market_pages/wallet_withdrawal_requests/wallet_withdrawal_requests_page.dart';
import '../../features/presentation/market_providers/order_comments_notifier.dart';
import '../../features/presentation/market_providers/order_notifier.dart';
import '../../features/presentation/market_providers/product_comments_notifier.dart';

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
        name: ProfileInfoPage.route,
        builder: (ctx, args, map) => ProfileInfoPage(),
      ),
      SailorRoute(
        name: SearchProductsPage.route,
        builder: (ctx, args, map) => SearchProductsPage(),
      ),
      SailorRoute(
        name: ProductDetailPage.route,
        builder: (ctx, args, map) {
          final product = map.param<ProductResultModel>("product");

          return ProductDetailPage(product: product);
        },
        params: [
          SailorParam<ProductResultModel>(
            name: "product",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: EditProfilePage.route,
        builder: (ctx, args, map) {
          final marketProfile =
              map.param<MarketProfileResultModel>("marketProfile");

          return EditProfilePage(marketProfile: marketProfile);
        },
        params: [
          SailorParam<MarketProfileResultModel>(
            name: "marketProfile",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: PhotosPage.route,
        builder: (ctx, args, map) => PhotosPage(),
      ),
      SailorRoute(
        name: DefaultHoursPage.route,
        builder: (ctx, args, map) => DefaultHoursPage(),
      ),
      SailorRoute(
        name: EditDefaultHoursPage.route,
        builder: (ctx, args, map) {
          final marketDefaultHours =
              map.param<MarketDefaultHoursResultModel>("marketDefaultHours");

          return EditDefaultHoursPage(
            marketDefaultHours: marketDefaultHours,
          );
        },
        params: [
          SailorParam<MarketDefaultHoursResultModel>(
            name: "marketDefaultHours",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: OrderDetailPage.route,
        builder: (ctx, args, map) {
          final marketOrder = map.param<MarketOrder>("marketOrder");

          return ChangeNotifierProvider(
            create: (ctx) => OrderNotifier(
              MarketOrderRepository(),
            ),
            child: OrderDetailPage(marketOrder: marketOrder),
          );
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
        name: CommentsPage.route,
        builder: (ctx, args, map) => CommentsPage(),
      ),
      SailorRoute(
        name: CommentReplyPage.route,
        builder: (ctx, args, map) {
          final marketComment = map.param<MarketComment>("marketComment");

          return CommentReplyPage(
            marketComment: marketComment,
          );
        },
        params: [
          SailorParam<MarketComment>(
            name: "marketComment",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: OrderCommentsPage.route,
        builder: (ctx, args, map) {
          final orderId = map.param<String>("orderId");

          return ChangeNotifierProvider(
            create: (ctx) => OrderCommentsNotifier(
              MarketOrderRepository(),
            ),
            child: OrderCommentsPage(orderId: orderId),
          );
        },
        params: [
          SailorParam<String>(
            name: "orderId",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: OrderCommentReplyPage.route,
        builder: (ctx, args, map) {
          final orderComment = map.param<OrderComment>("orderComment");

          return ChangeNotifierProvider(
            create: (ctx) => OrderCommentsNotifier(
              MarketOrderRepository(),
            ),
            child: OrderCommentReplyPage(orderComment: orderComment),
          );
        },
        params: [
          SailorParam<OrderComment>(
            name: "orderComment",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: ProductCommentsPage.route,
        builder: (ctx, args, map) {
          final productId = map.param<String>("productId");

          return ChangeNotifierProvider(
            create: (ctx) => ProductCommentsNotifier(
              MarketProductRepository(),
            ),
            child: ProductCommentsPage(productId: productId),
          );
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
        name: ProductCommentReplyPage.route,
        builder: (ctx, args, map) {
          final productComment = map.param<ProductComment>("productComment");

          return ChangeNotifierProvider(
            create: (ctx) => ProductCommentsNotifier(
              MarketProductRepository(),
            ),
            child: ProductCommentReplyPage(productComment: productComment),
          );
        },
        params: [
          SailorParam<ProductComment>(
            name: "productComment",
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
          final isProductExist = map.param<bool>("isProductExist");

          return AddProductPage(
            product: product,
            isProductExist: isProductExist,
          );
        },
        params: [
          SailorParam<ProductResultModel>(
            name: "product",
            isRequired: true,
            defaultValue: null,
          ),
          SailorParam<bool>(
            name: "isProductExist",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
      SailorRoute(
        name: AddProductDraftPage.route,
        builder: (ctx, args, map) {
          final mainCategoryId = map.param<String>("mainCategoryId");
          final mainCategoryName = map.param<String>("mainCategoryName");
          final subCategoryId = map.param<String>("subCategoryId");
          final subCategoryName = map.param<String>("subCategoryName");

          return AddProductDraftPage(
            mainCategoryId: mainCategoryId,
            mainCategoryName: mainCategoryName,
            subCategoryId: subCategoryId,
            subCategoryName: subCategoryName,
          );
        },
        params: [
          SailorParam<String>(
            name: "mainCategoryId",
            isRequired: true,
            defaultValue: null,
          ),
          SailorParam<String>(
            name: "mainCategoryName",
            isRequired: true,
            defaultValue: null,
          ),
          SailorParam<String>(
            name: "subCategoryId",
            isRequired: true,
            defaultValue: null,
          ),
          SailorParam<String>(
            name: "subCategoryName",
            isRequired: true,
            defaultValue: null,
          ),
        ],
      ),
    ],
  );
}
