import 'package:get/get.dart';

import 'features/data/repositories/auth_repository.dart';
import 'features/data/repositories/shared_application_repository.dart';
import 'features/presentation/app_notifier.dart';
import 'features/presentation/base_providers/contacts_provider.dart';
import 'features/presentation/base_providers/update_notifier.dart';

Future<void> initBaseProviders() async {
  Get.put<AppNotifier>(
    AppNotifier(
      Get.find<AuthRepository>(),
    ),
  );

  Get.put<UpdateNotifier>(
    UpdateNotifier(
      Get.find<SharedApplicationRepository>(),
    ),
  );

  Get.put<ContactsStateNotifier>(
    ContactsStateNotifier(
      Get.find<SharedApplicationRepository>(),
    ),
  );
}
