// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/older_orders_result_model.dart';
import '../../order_detail/order_detail_page.dart';
import 'older_order_list_item.dart';

class OlderOrderList extends StatelessWidget {
  OlderOrderList({required this.orderList});

  final List<Order> orderList;

  @override
  Widget build(BuildContext context) {
    return orderList.isEmpty
        ? _emptyState
        : ListView.separated(
            shrinkWrap: true,
            itemCount: orderList.length,
            padding: EdgeInsets.symmetric(horizontal: 16),
            physics: NeverScrollableScrollPhysics(),
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
            separatorBuilder: (context, index) => CustomPaint(
              painter: DashedLinePainter(),
            ),
          );
  }

  Widget get _emptyState => Txt(
        "لیست سفارشات خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
