// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/older_orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class OlderOrderListItem extends StatelessWidget {
  const OlderOrderListItem({
    required this.order,
    required this.onTap,
  });

  final Order order;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldOrderMarket,
              _fieldOrderDate,
              _fieldOrderStatus,
            ],
          ),
          _fieldOrderPriceText,
        ],
      ),
    );
  }

  Widget get _fieldOrderMarket {
    return CustomRichText(
      title: "فروشگاه: ",
      text: "${order.marketName}",
    );
  }

  Widget get _fieldOrderStatus {
    return CustomRichText(
      title: "وضعیت: ",
      text: "${order.status}",
    );
  }

  Widget get _fieldOrderDate {
    return CustomRichText(
      title: "تاریخ سفارش: ",
      text: _generateTransactionDateText(),
    );
  }

  String _generateTransactionDateText() {
    return order.date.toString().split(" ")[0].replaceAll("-", "/");
  }

  Widget get _fieldOrderPriceText {
    return Txt(
      _generateOrderPriceText(),
      style: AppTxtStyles().subHeading
        ..textColor(Colors.black87)
        ..bold(),
    );
  }

  String _generateOrderPriceText() {
    String priceTxt;
    if (order.totalPrice == null) {
      priceTxt = " نامشخص ";
    } else {
      var temp;
      if ("${order.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(order.totalPrice);
      } else {
        temp = "${order.totalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt.replaceAll("-", "");
  }
}
