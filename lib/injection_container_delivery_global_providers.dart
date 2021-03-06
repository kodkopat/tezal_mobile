import 'package:get/get.dart';

import 'features/data/repositories/delivery_order_repository.dart';
import 'features/data/repositories/delivery_wallet_repository.dart';
import 'features/presentation/delivery_providers/orders_notifier.dart';
import 'features/presentation/delivery_providers/profile_notifier.dart';
import 'features/presentation/delivery_providers/wallet_notifier.dart';

// put customer global providers to Get Service Locator
Future<void> initDeliveryProviders() async {
  Get.put<DeliveryOrdersNotifier>(DeliveryOrdersNotifier(
    Get.find<DeliveryOrderRepository>(),
  ));

  Get.put<DeliveryProfileNotifier>(
    DeliveryProfileNotifier(),
  );

  Get.put<DeliveryWalletNotifier>(
    DeliveryWalletNotifier(
      Get.find<DeliveryWalletRepository>(),
    ),
  );
}
