import 'package:get/get.dart';

import 'features/data/repositories/customer_address_repository.dart';
import 'features/data/repositories/customer_basket_repository.dart';
import 'features/data/repositories/customer_campaign_repository.dart';
import 'features/data/repositories/customer_market_repository.dart';
import 'features/data/repositories/customer_order_repository.dart';
import 'features/data/repositories/customer_product_repository.dart';
import 'features/data/repositories/customer_repository.dart';
import 'features/data/repositories/customer_search_repository.dart';
import 'features/data/repositories/customer_wallet_repository.dart';
import 'features/presentation/customer_providers/addresses_notifier.dart';
import 'features/presentation/customer_providers/basket_notifier.dart';
import 'features/presentation/customer_providers/campaign_notifier.dart';
import 'features/presentation/customer_providers/liked_product_notifier.dart';
import 'features/presentation/customer_providers/market_notifier.dart';
import 'features/presentation/customer_providers/order_notifier.dart';
import 'features/presentation/customer_providers/profile_notifier.dart';
import 'features/presentation/customer_providers/search_notifier.dart';
import 'features/presentation/customer_providers/wallet_notifier.dart';

// put customer global providers to Get Service Locator
void initCustomerProviders() {
  Get.put<AddressesNotifier>(
    AddressesNotifier(
      Get.find<CustomerAddressRepository>(),
    ),
  );

  Get.put<BasketNotifier>(
    BasketNotifier(
      Get.find<CustomerBasketRepository>(),
      Get.find<CustomerProductRepository>(),
    ),
  );

  Get.put<CampaignNotifier>(
    CampaignNotifier(
      Get.find<CustomerCampaignRepository>(),
    ),
  );

  Get.put<LikedProductNotifier>(
    LikedProductNotifier(
      Get.find<CustomerProductRepository>(),
    ),
  );

  Get.put<MarketNotifier>(
    MarketNotifier(
      Get.find<CustomerMarketRepository>(),
    ),
  );

  Get.put<OrderNotifier>(
    OrderNotifier(
      Get.find<CustomerOrderRepository>(),
      Get.find<CustomerProductRepository>(),
    ),
  );

  Get.put<ProfileNotifier>(
    ProfileNotifier(
      Get.find<CustomerRepository>(),
    ),
  );

  Get.put<SearchNotifier>(
    SearchNotifier(
      Get.find<CustomerSearchRepository>(),
    ),
  );

  Get.put<WalletNotifier>(
    WalletNotifier(
      Get.find<CustomerWalletRepository>(),
    ),
  );
}
