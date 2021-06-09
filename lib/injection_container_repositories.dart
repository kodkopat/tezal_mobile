import 'package:get/get.dart';

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
import 'features/data/repositories/delivery_order_repository.dart';
import 'features/data/repositories/delivery_repository.dart';
import 'features/data/repositories/delivery_wallet_repository.dart';
import 'features/data/repositories/market_order_repository.dart';
import 'features/data/repositories/market_product_repository.dart';
import 'features/data/repositories/market_repository.dart';
import 'features/data/repositories/market_wallet_repository.dart';
import 'features/data/repositories/shared_application_repository.dart';
import 'features/data/repositories/shared_user_repository.dart';

// put repositories to Get Service Locator
Future<void> initRepositories() async {
  // auth repository

  Get.put<SharedUserRepository>(
    SharedUserRepository(),
  );

  // customer repositories

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

  // delivery repositories

  Get.put<DeliveryOrderRepository>(
    DeliveryOrderRepository(),
  );

  Get.put<DeliveryRepository>(
    DeliveryRepository(),
  );

  Get.put<DeliveryWalletRepository>(
    DeliveryWalletRepository(),
  );

  // market repositories

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

  // shared repository

  Get.put<SharedApplicationRepository>(
    SharedApplicationRepository(),
  );
}
