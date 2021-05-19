// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/orders_notifier.dart';
import '../order_detail/order_detail_page.dart';
import 'widgets/order_drop_down_direction.dart';
import 'widgets/order_drop_down_filter.dart';
import 'widgets/order_drop_down_sort.dart';
import 'widgets/order_list.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/market_orders";

  late final OrdersNotifier orderNotifier;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrdersNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchOrdersCalled) {
          provider.fetchOrders(context);
        }

        return provider.loading
            ? Center(child: AppLoading())
            : provider.marketOrders == null
                ? provider.errorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.errorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(top: 96, bottom: 16),
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
                            if (provider.enableLoadMoreOption!)
                              LoadMoreBtn(onTap: () {
                                provider.fetchOrders(context);
                              }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: OrderDropDownSort(
                                labelText: "مرتب‌سازی سفارشات",
                                textList: provider.orderSortList,
                                defaultListIndex: provider.orderSortListIndex,
                                onIndexChanged: (index) {
                                  provider.refresh(
                                    context,
                                    orderSortListIndex: index,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: OrderDropDownDirection(
                                labelText: "ترتیب نمایش",
                                textList: provider.orderDirectionList,
                                defaultListIndex:
                                    provider.orderDirectionListIndex,
                                onIndexChanged: (index) {
                                  provider.refresh(
                                    context,
                                    orderDirectionListIndex: index,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      OrderDropDownFilter(
                        labelText: "فیلتر کردن سفارشات",
                        textList: provider.orderStatusList,
                        defaultListIndex: provider.orderStatusListIndex,
                        onIndexChanged: (index) {
                          provider.refresh(
                            context,
                            orderStatusListIndex: index,
                          );
                        },
                        clearFilterOnTap: () {
                          provider.clearFilter(context);
                        },
                      ),
                    ],
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).ordersPage,
      ),
      body: consumer,
    );
  }
}
