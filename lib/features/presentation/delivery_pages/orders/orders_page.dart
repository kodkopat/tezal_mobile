// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/orders_notifier.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/delivery_orders";

  late final OrdersNotifier orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).ordersPage,
      ),
      body: Center(
        child: Txt(
          "سفارشات",
          style: AppTxtStyles().body,
        ),
      ),
    );
  }
}
