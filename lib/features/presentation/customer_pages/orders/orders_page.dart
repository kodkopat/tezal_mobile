import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/order_notifier.dart';
import 'widgets/order_list.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/customer_orders";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderNotifier>(
      builder: (context, provider, child) {
        if (provider.olderOrdersResultModel == null &&
            provider.errorMsg == null) {
          provider.fetchOlderOrders();
        }

        return provider.loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.errorMsg != null
                ? Txt(
                    provider.errorMsg,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.olderOrdersResultModel.data.isEmpty
                    ? Txt(
                        "لیست سفارشات شما خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : OrderList(
                        orderList: provider.olderOrdersResultModel.data,
                      );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "سفارشات من",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
