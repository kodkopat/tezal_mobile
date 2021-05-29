// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_providers/order_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/older_order_list.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/customer_orders";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchOlderOrdersCalled) {
          provider.fetchOlderOrders(context);
        }

        return provider.loading
            ? AppLoading()
            : provider.orders == null
                ? provider.errorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.errorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OlderOrderList(orderList: provider.orders!),
                        if (provider.enableLoadMoreOption!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchOlderOrders(context);
                          })
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).olderOrdersPage,
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: consumer,
    );
  }
}
