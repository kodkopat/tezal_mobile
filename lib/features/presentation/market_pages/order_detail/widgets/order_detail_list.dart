// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          "محصولات موجود در سفارش",
          style: AppTxtStyles().body
            ..padding(all: 4)
            ..bold(),
        ),
        SizedBox(
          height: 224,
          child: ListView.separated(
            itemCount: marketOrderItems.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return OrderDetailListItem(
                marketOrderItem: marketOrderItems[index],
                marketOrderPhoto: marketOrderPhotos[index],
                onTap: () => onItemTap(index),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}
