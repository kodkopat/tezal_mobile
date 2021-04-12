// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/order_notifier.dart';
import 'widgets/order_list.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/customer_order_detail";

  const OrderDetailPage({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OrderNotifier>(
      builder: (context, provider, child) {
        if (provider.orderDetailResultModel == null &&
            provider.orderDetailErrorMsg == null) {
          provider.fetchOrderDetail(orderId: orderId);
        }

        return provider.orderDetailLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.orderDetailErrorMsg != null
                ? Txt(
                    provider.orderDetailErrorMsg!,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : OrderList(
                    orderItems: provider.orderDetailResultModel!.data?.items,
                    orderNotifier: provider,
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات سفارش",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
