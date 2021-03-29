import 'package:flutter/material.dart';
import 'package:tezal/features/data/models/basket_result_model.dart';

import 'basket_list_item.dart';

class BasketList extends StatelessWidget {
  const BasketList({
    Key key,
    @required this.basketItems,
  }) : super(key: key);

  final List<BasketItem> basketItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: basketItems.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return BasketListItem(
          baskteItem: basketItems[index],
        );
      },
    );
  }
}
