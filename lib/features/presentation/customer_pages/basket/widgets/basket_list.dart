// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/basket_result_model.dart';
import '../../../customer_providers/basket_notifier.dart';
import 'basket_list_item.dart';

class BasketList extends StatelessWidget {
  const BasketList({
    required this.basketItems,
    required this.basketNotifier,
    required this.onItemAddToBasket,
    required this.onItemRemoveFromBasket,
  });

  final List<BasketItem> basketItems;
  final BasketNotifier basketNotifier;
  final void Function(int) onItemAddToBasket;
  final void Function(int) onItemRemoveFromBasket;

  @override
  Widget build(BuildContext context) {
    return basketItems.isEmpty
        ? _basketEmptyState()
        : Parent(
            style: ParentStyle()
              ..margin(horizontal: 16, vertical: 8)
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
              itemCount: basketItems.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BasketListItem(
                  basketItem: basketItems[index],
                  basketNotifier: basketNotifier,
                  onAddToBasket: () => onItemAddToBasket(index),
                  onRemoveFromBasket: () => onItemRemoveFromBasket(index),
                  onRemoveItem: () async {
                    await basketNotifier.customerBasketRepo
                        .removeProductFromBasket(
                      productId: basketItems[index].id,
                      amount: basketItems[index].amount,
                    );
                    basketNotifier.refresh();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return CustomPaint(painter: DashedLinePainter());
              },
            ),
          );
  }

  Widget _basketEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Parent(
            style: ParentStyle()
              ..width(80)
              ..alignmentContent.center(),
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: Image.asset(
                "assets/images/img_tezal_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Txt(
            "هنوز کالایی را به سبد خرید خود اضافه نکرده‌اید",
            style: AppTxtStyles().footNote..alignment.center(),
          ),
        ],
      ),
    );
  }
}
