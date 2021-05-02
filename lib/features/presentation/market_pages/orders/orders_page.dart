// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/order_notifier.dart';
import '../order_detail/order_detail_page.dart';
import 'widgets/order_filter_box_drop_down.dart';
import 'widgets/order_list.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/market_orders";

  late final OrderNotifier orderNotifier;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchOrdersCalled) {
          provider.fetchOrders(context);
        }

        return provider.ordersLoading
            ? Center(child: AppLoading())
            : provider.marketOrders == null
                ? provider.ordersErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.ordersErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(top: 48, bottom: 16),
                        child: Column(
                          children: [
                            OrderList(
                              marketOrders: provider.marketOrders!,
                              onItemTap: (index) {
                                Routes.sailor.navigate(
                                  OrderDetailPage.route,
                                  params: {
                                    "marketOrder": provider.marketOrders![index]
                                  },
                                );
                              },
                            ),
                            if (provider.enableLoadMoreData!)
                              LoadMoreBtn(onTap: () {
                                provider.fetchOrders(context);
                              }),
                          ],
                        ),
                      ),
                      OrderFilterBoxDropDown(
                        labelText: "فیلتر کردن سفارشات",
                        textList: provider.orderStatusList,
                        defaultListIndex: provider.orderStatusListIndex,
                        onIndexChanged: (index) {
                          provider.refresh(context, index);
                        },
                      ),
                    ],
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "سفارشات",
      ),
      body: consumer,
    );
  }
}
