import 'package:flutter/material.dart';

import '../../../../data/models/older_orders_result_model.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({@required this.orderList});

  final List<Order> orderList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderList.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return OrderListItem(
          order: orderList[index],
        );
      },
    );
  }
}
