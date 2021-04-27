import 'package:flutter/material.dart';

import '../../customer_widgets/simple_app_bar.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/market_orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "سفارشات",
      ),
    );
  }
}
