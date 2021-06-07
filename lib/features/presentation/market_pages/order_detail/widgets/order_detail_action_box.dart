// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class OrderDetailActionBox extends StatelessWidget {
  OrderDetailActionBox({required this.marketOrder});

  final MarketOrder marketOrder;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..margin(vertical: 8)
        ..padding(horizontal: 16, vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Txt(
                    "نام مشتری: ",
                    style: AppTxtStyles().body
                      ..textAlign.right()
                      ..bold(),
                  ),
                  Txt(
                    "${marketOrder.customerName}",
                    style: AppTxtStyles().body,
                  ),
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Txt(
                    "شماره تماس: ",
                    style: AppTxtStyles().body
                      ..textAlign.right()
                      ..bold(),
                  ),
                  Txt(
                    "-",
                    style: AppTxtStyles().body,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: _fieldTotalPrice),
              _verticalDivider,
              Expanded(flex: 1, child: _fieldTotalDiscount),
              _verticalDivider,
              Expanded(flex: 1, child: SizedBox() /* _fieldDeliveryCost */),
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Txt(
                  "تایید سفارش",
                  gesture: Gestures()..onTap(() {}),
                  style: AppTxtStyles().body
                    ..bold()
                    ..height(48)
                    ..textColor(Colors.white)
                    ..alignmentContent.center(true)
                    ..border(
                      all: 0.5,
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    )
                    ..background.color(Theme.of(context).primaryColor)
                    ..borderRadius(all: 12)
                    ..ripple(true),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Txt(
                  "لغو سفارش",
                  gesture: Gestures()..onTap(() {}),
                  style: AppTxtStyles().body
                    ..bold()
                    ..height(48)
                    ..textColor(Colors.black54)
                    ..alignmentContent.center(true)
                    ..border(
                      all: 0.5,
                      style: BorderStyle.solid,
                      color: Colors.black54,
                    )
                    ..borderRadius(all: 12)
                    ..ripple(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _verticalDivider => SizedBox(
        height: 40,
        child: VerticalDivider(
          color: Colors.black12,
          thickness: 0.5,
          width: 0,
        ),
      );

  Widget get _fieldTotalPrice {
    return CustomRichText(
      title: "قیمت محصولات" + "\n",
      text: _generatePriceText(
        marketOrder.totalPrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldTotalDiscount {
    return CustomRichText(
      title: "تخفیف محصولات" + "\n",
      text: _generatePriceText(
        marketOrder.totalPrice - marketOrder.totalDiscount,
      ),
      textAlign: TextAlign.center,
    );
  }

  /* Widget get _fieldDeliveryCost {
    return CustomRichText(
      title: "هزینه ارسال" + "\n",
      text: _generatePriceText(
        marketOrder.deliveryCost,
      ),
      textAlign: TextAlign.center,
    );
  } */

  String _generatePriceText(num price) {
    var text;
    if (price == 0) {
      text = " رایگان ";
    } else {
      var temp;
      if ("$price".length >= 3) {
        temp = intl.NumberFormat("#,000").format(price);
      } else {
        temp = "$price";
      }

      text = " $temp " + "تومان";
    }

    return text;
  }
}
