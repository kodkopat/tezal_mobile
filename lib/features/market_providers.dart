import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/market_order_repository.dart';
import 'presentation/providers/market_providers/order_notifier.dart';

List<SingleChildWidget> marketProviders = [
  ChangeNotifierProvider(
    create: (ctx) => OrderNotifier(
      MarketOrderRepository(),
    ),
  ),
];
