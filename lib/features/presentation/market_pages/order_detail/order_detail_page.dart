import 'package:flutter/material.dart';

import '../../../data/models/market/market_orders_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../orders/widgets/order_list_item.dart';
import 'widgets/order_detail_list.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/market_order_detail";

  OrderDetailPage({required this.marketOrder});

  final MarketOrder marketOrder;

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
