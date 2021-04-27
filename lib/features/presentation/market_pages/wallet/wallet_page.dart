import 'package:flutter/material.dart';

import '../../customer_widgets/simple_app_bar.dart';

class WalletPage extends StatelessWidget {
  static const route = "/market_wallet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "کیف پول",
      ),
    );
  }
}
