import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/delivery_wallet_repository.dart';
import 'delivery_providers/profile_notifier.dart';
import 'delivery_providers/wallet_notifier.dart';

List<SingleChildWidget> deliveryProviders = [
  ChangeNotifierProvider(
    create: (ctx) => DeliveryWalletNotifier(
      DeliveryWalletRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => DeliveryProfileNotifier(),
  ),
];
