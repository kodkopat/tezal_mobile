import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/older_orders_result_model.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({@required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${order.marketName}",
                style: AppTxtStyles().body,
              ),
              Txt(
                "+${intl.NumberFormat("#,000").format(order.totalPrice)}",
                style: AppTxtStyles().subHeading
                  ..textDirection(TextDirection.ltr),
              ),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Txt(
                order.date.toString().split(" ")[0].replaceAll("-", "/"),
                style: AppTxtStyles().footNote..textColor(Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
