import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/customer_address_repository.dart';
import 'data/repositories/customer_basket_repository.dart';
import 'data/repositories/customer_campaign_repository.dart';
import 'data/repositories/customer_category_repository.dart';
import 'data/repositories/customer_market_repository.dart';
import 'data/repositories/customer_order_repository.dart';
import 'data/repositories/customer_product_repository.dart';
import 'data/repositories/customer_repository.dart';
import 'data/repositories/customer_search_repository.dart';
import 'data/repositories/customer_wallet_repository.dart';
import 'presentation/providers/customer_providers/address_notifier.dart';
import 'presentation/providers/customer_providers/basket_notifier.dart';
import 'presentation/providers/customer_providers/campaign_notifier.dart';
import 'presentation/providers/customer_providers/category_notifier.dart';
import 'presentation/providers/customer_providers/contacts_notifier.dart';
import 'presentation/providers/customer_providers/liked_product_notifier.dart';
import 'presentation/providers/customer_providers/market_notifier.dart';
import 'presentation/providers/customer_providers/order_notifier.dart';
import 'presentation/providers/customer_providers/profile_notifier.dart';
import 'presentation/providers/customer_providers/search_notifier.dart';
import 'presentation/providers/customer_providers/wallet_notifier.dart';

List<SingleChildWidget> customerProviders = [
  ChangeNotifierProvider(
    create: (ctx) => ContactsNotifier(),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CampaignNotifier(
      CustomerCampaignRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => CategoryNotifier(
      CustomerCategoryRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => MarketNotifier(
      CustomerMarketRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => ProfileNotifier(
      CustomerRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => AddressNotifier(
      CustomerAddressRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => WalletNotifier(
      CustomerWalletRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => SearchNotifier(
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
