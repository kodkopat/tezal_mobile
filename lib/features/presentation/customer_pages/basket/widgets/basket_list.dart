import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/basket_result_model.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import 'basket_list_item.dart';

class BasketList extends StatelessWidget {
  const BasketList({
    Key key,
    @required this.basketItems,
    @required this.basketNotifier,
  }) : super(key: key);

  final List<BasketItem> basketItems;
  final BasketNotifier basketNotifier;

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
        itemCount: basketItems.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return BasketListItem(
            basketItem: basketItems[index],
            basketNotifier: basketNotifier,
            onRemoveItem: () async {
              await basketNotifier.customerBasketRepo.removeProductToBasket(
                productId: basketItems[index].id,
                amount: basketItems[index].amount,
              );
              basketNotifier.refresh();
            },
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
