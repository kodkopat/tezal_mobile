import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/market_order_repository.dart';
import 'data/repositories/market_product_repository.dart';
import 'data/repositories/market_repository.dart';
import 'data/repositories/market_wallet_repository.dart';
import 'presentation/providers/market_providers/comments_notifier.dart';
import 'presentation/providers/market_providers/default_hours_notifier.dart';
import 'presentation/providers/market_providers/main_category_notifier.dart';
import 'presentation/providers/market_providers/orders_notifier.dart';
import 'presentation/providers/market_providers/photos_notifier.dart';
import 'presentation/providers/market_providers/products_notifier.dart';
import 'presentation/providers/market_providers/profile_notifier.dart';
import 'presentation/providers/market_providers/search_notifier.dart';
import 'presentation/providers/market_providers/wallet_notifier.dart';

List<SingleChildWidget> marketProviders = [
  ChangeNotifierProvider(
    create: (ctx) => OrdersNotifier(
      MarketOrderRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => SearchNotifier(
      MarketProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => MainCategoryNotifier(
      MarketProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => ProductsNotifier(
      MarketProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => WalletNotifier(
      MarketWalletRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => ProfileNotifier(
      MarketRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => DefaultHoursNotifier(
      MarketRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CommentsNotifier(
      MarketRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => PhotosNotifier(
      MarketRepository(),
    ),
  ),
];
