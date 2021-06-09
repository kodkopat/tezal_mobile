import 'package:flutter/material.dart';

import '../../../../data/models/delivery/orders_result_model.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  OrderList({
    required this.orderItems,
    required this.onItemTap,
  });

  final List<OrderItem> orderItems;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orderItems.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderListItem(
          orderItem: orderItems[index],
          onTap: () => onItemTap(index),
          showIcons: false,
        );
      },
    );
  }
}
