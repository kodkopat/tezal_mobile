import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/shared_application_repository.dart';
import 'presentation/providers/base_providers/contacts_notifier.dart';
import 'presentation/providers/base_providers/direction_notifier.dart';
import 'presentation/providers/base_providers/location_notifier.dart';
import 'presentation/providers/base_providers/photo_notifier.dart';
import 'presentation/providers/base_providers/update_notifier.dart';

List<SingleChildWidget> baseProviders = [
  ChangeNotifierProvider(
    create: (ctx) => UpdateNotifier(
      SharedApplicationRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => ContactsNotifier(
      SharedApplicationRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => PhotoNotifier(
      SharedApplicationRepository(),
    ),
  ),
  ChangeNotifierProvider(
    create: (ctx) => LocationNotifier(),
  ),
  ChangeNotifierProvider(
    create: (ctx) => DirectionNotifier(),
  ),
];
