import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tezal/core/styles/txt_styles.dart';
import 'package:tezal/features/data/models/basket_result_model.dart';

class BasketListItem extends StatelessWidget {
  const BasketListItem({
    Key key,
    this.baskteItem,
  }) : super(key: key);

  final BasketItem baskteItem;

  @override
  Widget build(BuildContext context) {
    return Txt(
      "${baskteItem.productName} ${baskteItem.amount}",
      style: AppTxtStyles().body
        ..padding(horizontal: 16, vertical: 8)
        ..alignment.centerRight(),
    );
  }
}
