import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../data/models/market/orders_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/order_notifier.dart';
import '../orders/widgets/order_list_item.dart';
import 'widgets/order_detail_action_box.dart';
import 'widgets/order_detail_list.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/market_order_detail";

  OrderDetailPage({required this.marketOrder});

  final MarketOrder marketOrder;

  @override
  Widget build(BuildContext context) {
    var orderNotifier = Provider.of<OrderNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات سفارش",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderListItem(
              marketOrder: marketOrder,
              onTap: () {},
              showIcons: true,
            ),
            SizedBox(height: 8),
            OrderDetailList(
              marketOrderItems: marketOrder.items!,
              onItemTap: (index) {},
            ),
            OrderDetailActionBox(
              onApproveOrder: () async {
                await orderNotifier.approveOrder(
                  context: context,
                  orderId: "marketOrder.id",
                );
                Routes.sailor.pop();
              },
              onRejectOrder: () async {
                await orderNotifier.rejectOrder(
                  context: context,
                  orderId: "marketOrder.id",
                );
                Routes.sailor.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
