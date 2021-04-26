// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/order_detail_result_model.dart';
import '../../../providers/customer_providers/order_detail_notifier.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    required this.orderItems,
    required this.orderDetailNotifier,
  });

  final List<OrderItem> orderItems;
  final OrderDetailNotifier orderDetailNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(horizontal: 16, vertical: 16)
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return OrderListItem(
            orderItem: orderItems[index],
            orderDetailNotifier: orderDetailNotifier,
            showCommentOption: true,
          );
        },
        separatorBuilder: (context, index) {
          return CustomPaint(painter: DashedLinePainter());
        },
      ),
    );
  }
}
