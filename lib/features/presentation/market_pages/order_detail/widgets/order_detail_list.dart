import 'package:flutter/material.dart';

import '../../../../data/models/market/orders_result_model.dart';
import 'order_detail_list_item.dart';

class OrderDetailList extends StatelessWidget {
  OrderDetailList({
    required this.marketOrderItems,
    required this.onItemTap,
  });

  final List<MarketOrderItem> marketOrderItems;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: marketOrderItems.length,
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderDetailListItem(
          marketOrderItem: marketOrderItems[index],
          onTap: () => onItemTap(index),
        );
      },
    );
  }
}
