import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/older_orders_result_model.dart';
import '../../order_detail/order_detail_page.dart';
import 'older_order_list_item.dart';

class OlderOrderList extends StatelessWidget {
  const OlderOrderList({required this.orderList});

  final List<Order> orderList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orderList.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return OlderOrderListItem(
          order: orderList[index],
          onTap: () {
            Routes.sailor.navigate(
              OrderDetailPage.route,
              params: {"orderId": orderList[index].id},
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
