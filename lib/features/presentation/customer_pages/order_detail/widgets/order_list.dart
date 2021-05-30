// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/order_detail_result_model.dart';
import '../../../customer_providers/order_detail_notifier.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    required this.orderItems,
    required this.orderDetailNotifier,
    required this.onItemCommentTap,
  });

  final List<OrderItem> orderItems;
  final OrderDetailNotifier orderDetailNotifier;
  final void Function(int) onItemCommentTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(horizontal: 16, vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
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
            showCommentOption: true,
            onCommentTap: () => onItemCommentTap(index),
          );
        },
        separatorBuilder: (context, index) {
          return CustomPaint(painter: DashedLinePainter());
        },
      ),
    );
  }
}
