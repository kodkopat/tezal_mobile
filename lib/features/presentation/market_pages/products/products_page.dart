import 'package:flutter/material.dart';

import '../../customer_widgets/simple_app_bar.dart';

class ProductsPage extends StatelessWidget {
  static const route = "/market_products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "محصولات",
      ),
    );
  }
}
