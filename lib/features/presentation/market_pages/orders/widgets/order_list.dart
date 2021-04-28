import 'package:flutter/material.dart';

import '../../../../data/models/market/market_orders_result_model.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  OrderList({
    required this.marketOrders,
    required this.onItemTap,
  });

  final List<MarketOrder> marketOrders;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: marketOrders.length,
      padding: EdgeInsets.symmetric(vertical: 8),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderListItem(
          marketOrder: marketOrders[index],
          onTap: () => onItemTap(index),
          showIcons: false,
        );
      },
    );
  }
}
