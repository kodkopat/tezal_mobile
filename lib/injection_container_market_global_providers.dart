import 'package:get/get.dart';

import 'features/data/repositories/market_order_repository.dart';
import 'features/data/repositories/market_product_repository.dart';
import 'features/data/repositories/market_repository.dart';
import 'features/data/repositories/market_wallet_repository.dart';
import 'features/presentation/market_providers/comments_notifier.dart';
import 'features/presentation/market_providers/default_hours_notifier.dart';
import 'features/presentation/market_providers/main_category_notifier.dart';
import 'features/presentation/market_providers/orders_notifier.dart';
import 'features/presentation/market_providers/photos_notifier.dart';
import 'features/presentation/market_providers/profile_notifier.dart';
import 'features/presentation/market_providers/search_notifier.dart';
import 'features/presentation/market_providers/wallet_notifier.dart';

// put market global providers to Get Service Locator
Future<void> initMarketProviders() async {
  Get.put<CommentsNotifier>(
    CommentsNotifier(
      Get.find<MarketRepository>(),
    ),
  );

  Get.put<DefaultHoursNotifier>(
    DefaultHoursNotifier(
      Get.find<MarketRepository>(),
    ),
  );

  Get.put<MainCategoryNotifier>(
    MainCategoryNotifier(
      Get.find<MarketProductRepository>(),
    ),
  );

  Get.put<OrdersNotifier>(
    OrdersNotifier(
      Get.find<MarketOrderRepository>(),
    ),
  );

  Get.put<PhotosNotifier>(
    PhotosNotifier(
      Get.find<MarketRepository>(),
    ),
  );

  Get.put<MarketProfileNotifier>(
    MarketProfileNotifier(
      Get.find<MarketRepository>(),
    ),
  );

  Get.put<MarketSearchNotifier>(
    MarketSearchNotifier(
      Get.find<MarketProductRepository>(),
    ),
  );

  Get.put<MarketWalletNotifier>(
    MarketWalletNotifier(
      Get.find<MarketWalletRepository>(),
    ),
  );
}
