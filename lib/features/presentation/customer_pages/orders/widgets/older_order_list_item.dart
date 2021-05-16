// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/languages/language.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/older_orders_result_model.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldOrderMarket(context),
              _fieldOrderDate(context),
              _fieldOrderStatus(context),
            ],
          ),
          _fieldOrderPriceText,
        ],
      ),
    );
  }

  Widget _fieldOrderMarket(BuildContext context) {
    return CustomRichText(
      title: Lang.of(context).orderMarket + ": ",
      text: "${order.marketName}",
    );
  }

  Widget _fieldOrderStatus(BuildContext context) {
    return CustomRichText(
      title: Lang.of(context).orderStatus + ": ",
      text: "${order.status}",
    );
  }

  Widget _fieldOrderDate(BuildContext context) {
    return CustomRichText(
      title: Lang.of(context).orderDate + ": ",
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
