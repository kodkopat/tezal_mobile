// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/basket_notifier.dart';
import '../../providers/customer_providers/order_detail_notifier.dart';
import 'widgets/order_actions_box.dart';
import 'widgets/order_list.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/customer_order_detail";

  const OrderDetailPage({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    var basketNotifier = Provider.of<BasketNotifier>(context, listen: false);

    var consumer = Consumer<OrderDetailNotifier>(
      builder: (context, provider, child) {
        if (provider.orderDetailResultModel == null) {
          provider.fetchOrderDetail(orderId: orderId);
        }

        return provider.orderDetailLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.orderDetailResultModel == null
                ? provider.orderDetailErrorMsg == null
                    ? Txt("خطای بارگذاری جزئیات سفارش",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.orderDetailErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        OrderList(
                          orderItems:
                              provider.orderDetailResultModel!.data?.items,
                          orderDetailNotifier: provider,
                        ),
                        OrderActionsBox(
                          orderDetail: provider.orderDetailResultModel!,
                          orderDetailNotifier: provider,
                          basketNotifier: basketNotifier,
                        ),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات سفارش",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: consumer,
    );
  }
}
