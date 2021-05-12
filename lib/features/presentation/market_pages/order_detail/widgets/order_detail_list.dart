import 'package:flutter/material.dart';

import '../../../../data/models/market/orders_result_model.dart';
import 'order_detail_list_item.dart';

class OrderDetailList extends StatelessWidget {
  OrderDetailList({
    required this.marketOrderItems,
    required this.marketOrderPhotos,
    required this.onItemTap,
  });

  final List<MarketOrderItem> marketOrderItems;
  final List<String> marketOrderPhotos;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: marketOrderItems.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderDetailListItem(
          marketOrderItem: marketOrderItems[index],
          marketOrderPhoto: marketOrderPhotos[index],
          onTap: () => onItemTap(index),
        );
      },
    );
  }
}
