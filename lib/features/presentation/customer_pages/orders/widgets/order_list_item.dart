import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../data/models/older_orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    @required this.order,
    @required this.onTap,
  });

  final Order order;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 3),
          blur: 6,
          spread: 0,
        ),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRichText(
            title: "از: ",
            text: "${order.marketName}",
          ),
          CustomRichText(
            title: "مبلغ: ",
            text: _generatePrice(),
          ),
          CustomRichText(
            title: "تاریخ: ",
            text: order.date.toString().split(" ")[0].replaceAll("-", "/"),
          ),
          /* CustomRichText(
            title: "شیوه پرداخت: ",
            text: "${order.paymentType}",
          ), */
          CustomRichText(
            title: "وضعیت سفارش: ",
            text: "${order.status}",
          ),
        ],
      ),
    );
  }

  String _generatePrice() {
    var priceTxt;
    if (order.totalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (order.totalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${order.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(order.totalPrice);
      } else {
        temp = "${order.totalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
