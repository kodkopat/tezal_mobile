import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'presentation/providers/base_providers/contacts_notifier.dart';
import 'presentation/providers/base_providers/direction_notifier.dart';
import 'presentation/providers/base_providers/location_notifier.dart';

List<SingleChildWidget> baseProviders = [
  ChangeNotifierProvider(
    create: (ctx) => ContactsNotifier(),
  ),
  ChangeNotifierProvider(
    create: (ctx) => LocationNotifier(),
  ),
  ChangeNotifierProvider(
    create: (ctx) => DirectionNotifier(),
  ),
];
