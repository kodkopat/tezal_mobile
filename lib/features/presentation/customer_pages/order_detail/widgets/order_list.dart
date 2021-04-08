import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/order_detail_result_model.dart';
import '../../../providers/customer_providers/order_notifier.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key key,
    @required this.orderItems,
    @required this.orderNotifier,
  }) : super(key: key);

  final List<OrderItem> orderItems;
  final OrderNotifier orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..margin(horizontal: 16, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: orderItems.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return OrderListItem(
            orderItem: orderItems[index],
            orderNotifier: orderNotifier,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 32,
          );
        },
      ),
    );
  }
}
