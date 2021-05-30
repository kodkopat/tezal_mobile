import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/customer_address_repository.dart';
import '../data/repositories/customer_basket_repository.dart';
import '../data/repositories/customer_campaign_repository.dart';
import '../data/repositories/customer_market_repository.dart';
import '../data/repositories/customer_order_repository.dart';
import '../data/repositories/customer_product_repository.dart';
import '../data/repositories/customer_repository.dart';
import '../data/repositories/customer_search_repository.dart';
import '../data/repositories/customer_wallet_repository.dart';
import 'customer_providers/addresses_notifier.dart';
import 'customer_providers/basket_notifier.dart';
import 'customer_providers/campaign_notifier.dart';
import 'customer_providers/liked_product_notifier.dart';
import 'customer_providers/market_category_notifier.dart';
import 'customer_providers/order_notifier.dart';
import 'customer_providers/profile_notifier.dart';
import 'customer_providers/search_notifier.dart';
import 'customer_providers/wallet_notifier.dart';

List<SingleChildWidget> customerProviders = [
  ChangeNotifierProvider(
    create: (ctx) => CampaignNotifier(
      CustomerCampaignRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => MarketCategoryNotifier(
      CustomerMarketRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CustomerProfileNotifier(
      CustomerRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => AddressesNotifier(
      CustomerAddressRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CustomerWalletNotifier(
      CustomerWalletRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CustomerSearchNotifier(
      CustomerSearchRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => LikedProductNotifier(
      CustomerProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => BasketNotifier(
      CustomerBasketRepository(),
      CustomerProductRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => OrderNotifier(
      CustomerOrderRepository(),
      CustomerProductRepository(),
    ),
  ),
];
