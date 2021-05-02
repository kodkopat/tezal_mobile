import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/market_order_repository.dart';
import 'data/repositories/market_product_repository.dart';
import 'data/repositories/market_wallet_repository.dart';
import 'presentation/providers/market_providers/main_category_notifier.dart';
import 'presentation/providers/market_providers/order_notifier.dart';
import 'presentation/providers/market_providers/wallet_notifier.dart';

List<SingleChildWidget> marketProviders = [
  ChangeNotifierProvider(
    create: (ctx) => OrderNotifier(
      MarketOrderRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => MainCategoryNotifier(
      MarketProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => WalletNotifier(
      MarketWalletRepository(),
    ),
  ),
];
