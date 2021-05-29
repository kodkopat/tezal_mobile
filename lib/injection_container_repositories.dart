import 'package:get/get.dart';

import 'features/data/repositories/auth_repository.dart';
import 'features/data/repositories/customer_address_repository.dart';
import 'features/data/repositories/customer_basket_repository.dart';
import 'features/data/repositories/customer_campaign_repository.dart';
import 'features/data/repositories/customer_category_repository.dart';
import 'features/data/repositories/customer_market_repository.dart';
import 'features/data/repositories/customer_order_repository.dart';
import 'features/data/repositories/customer_product_repository.dart';
import 'features/data/repositories/customer_repository.dart';
import 'features/data/repositories/customer_search_repository.dart';
import 'features/data/repositories/customer_wallet_repository.dart';
import 'features/data/repositories/market_order_repository.dart';
import 'features/data/repositories/market_product_repository.dart';
import 'features/data/repositories/market_repository.dart';
import 'features/data/repositories/market_wallet_repository.dart';
import 'features/data/repositories/shared_application_repository.dart';

// put repositories to Get Service Locator
void initRepositories() {
  Get.put<AuthRepository>(
    AuthRepository(),
  );

  Get.put<CustomerAddressRepository>(
    CustomerAddressRepository(),
  );

  Get.put<CustomerBasketRepository>(
    CustomerBasketRepository(),
  );

  Get.put<CustomerCampaignRepository>(
    CustomerCampaignRepository(),
  );

  Get.put<CustomerCategoryRepository>(
    CustomerCategoryRepository(),
  );

  Get.put<CustomerMarketRepository>(
    CustomerMarketRepository(),
  );

  Get.put<CustomerOrderRepository>(
    CustomerOrderRepository(),
  );

  Get.put<CustomerProductRepository>(
    CustomerProductRepository(),
  );

  Get.put<CustomerRepository>(
    CustomerRepository(),
  );

  Get.put<CustomerSearchRepository>(
    CustomerSearchRepository(),
  );

  Get.put<CustomerWalletRepository>(
    CustomerWalletRepository(),
  );

  Get.put<MarketOrderRepository>(
    MarketOrderRepository(),
  );

  Get.put<MarketProductRepository>(
    MarketProductRepository(),
  );

  Get.put<MarketRepository>(
    MarketRepository(),
  );

  Get.put<MarketWalletRepository>(
    MarketWalletRepository(),
  );

  Get.put<SharedApplicationRepository>(
    SharedApplicationRepository(),
  );
}
