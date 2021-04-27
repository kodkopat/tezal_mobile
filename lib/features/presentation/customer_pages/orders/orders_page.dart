// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/order_notifier.dart';
import 'widgets/older_order_list.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/customer_orders";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderNotifier>(
      builder: (context, provider, child) {
        if (provider.olderOrders == null) {
          provider.fetchOlderOrders(context);
        }

        return provider.olderOrdersLoading
            ? AppLoading()
            : provider.olderOrders == null
                ? provider.olderOrdersErrorMsg == null
                    ? Txt("لیست سفارشات شما خالی است",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.olderOrdersErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : provider.olderOrders!.isEmpty
                    ? Txt("لیست سفارشات شما خالی است",
                        style: AppTxtStyles().body..alignment.center())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OlderOrderList(
                                orderList: provider.olderOrders!),
                          ),
                          const SizedBox(height: 8),
                          if (provider.enableLoadMoreData!)
                            LoadMoreBtn(onTap: () {
                              provider.fetchOlderOrders(context);
                            })
                        ],
                      );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "سفارشات من",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: consumer,
    );
  }
}
