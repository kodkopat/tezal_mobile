import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class OrderDetailListItem extends StatelessWidget {
  OrderDetailListItem({
    required this.marketOrderItem,
    required this.marketOrderPhoto,
    required this.onTap,
  });

  final MarketOrderItem marketOrderItem;
  final String marketOrderPhoto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(144)
        ..padding(horizontal: 4, vertical: 4)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Parent(
            style: ParentStyle()
              ..width(144)
              ..height(112)
              ..borderRadius(all: 6)
              ..background.image(
                alignment: Alignment.center,
                path: "assets/images/img_placeholder.jpg",
                fit: BoxFit.fill,
              ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              child: Image.memory(
                base64Decode(marketOrderPhoto),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Txt(
            "${marketOrderItem.productName}",
            style: AppTxtStyles().body
              ..padding(right: 4)
              ..textOverflow(TextOverflow.ellipsis)
              ..maxLines(1),
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldTotalPrice(),
                  _fieldTotalDiscountedPrice(),
                ],
              ),
              _fieldDiscountedRate(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fieldTotalPrice() {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateTotalPrice(),
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.black54,
          letterSpacing: 0.5,
          fontFamily: 'Yekan',
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }

  String _generateTotalPrice() {
    var priceTxt;
    if (marketOrderItem.totalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (marketOrderItem.totalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${marketOrderItem.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(marketOrderItem.totalPrice);
      } else {
        temp = "${marketOrderItem.totalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget _fieldTotalDiscountedPrice() {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateTotalDiscountedPrice(),
        style: TextStyle(
          color: Colors.green,
          letterSpacing: 0.5,
          fontFamily: 'Yekan',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  String _generateTotalDiscountedPrice() {
    var priceTxt;
    if (marketOrderItem.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (marketOrderItem.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${marketOrderItem.discountedPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(marketOrderItem.discountedPrice);
      } else {
        temp = "${marketOrderItem.discountedPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget _fieldDiscountedRate() {
    if (_generateDiscountedRate().isEmpty) {
      return SizedBox();
    }

    return Txt(
      _generateDiscountedRate(),
      style: AppTxtStyles().subHeading
        ..bold()
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.red)
        ..background.color(Colors.red.withOpacity(0.1))
        ..borderRadius(topLeft: 4, bottomLeft: 4, topRight: 24, bottomRight: 24)
        ..padding(horizontal: 12, vertical: 8),
    );
  }

  String _generateDiscountedRate() {
    var td = marketOrderItem.totalDiscount;
    var tp = marketOrderItem.totalPrice;

    if (td == null || td == 0) {
      return "";
    } else {
      num discountRate = (td / tp) * 100;
      if (discountRate < 1)
        return "";
      else
        return "${discountRate.toStringAsFixed(1)}٪";
    }
  }

  Widget get _fieldOriginalPrice => CustomRichText(
        title: "قیمت هر واحد" + "\n",
        text: _generateOriginalPrice(),
        textAlign: TextAlign.center,
      );

  String _generateOriginalPrice() {
    var priceTxt;
    if (marketOrderItem.originalPrice == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${marketOrderItem.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(marketOrderItem.originalPrice);
      } else {
        temp = "${marketOrderItem.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget get _fieldDiscountedPrice => CustomRichText(
        title: "تخفیف هر واحد" + "\n",
        text: _generateDiscountedPrice(),
        textAlign: TextAlign.center,
      );

  String _generateDiscountedPrice() {
    var priceTxt;
    if (marketOrderItem.originalPrice == null ||
        marketOrderItem.discountedPrice == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${marketOrderItem.originalPrice - marketOrderItem.discountedPrice}"
              .length >=
          3) {
        temp = intl.NumberFormat("#,000").format(
            marketOrderItem.originalPrice - marketOrderItem.discountedPrice);
      } else {
        temp =
            "${marketOrderItem.originalPrice - marketOrderItem.discountedPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget get _fieldTotalDiscount => CustomRichText(
        title: "سود کل خرید" + "\n",
        text: _generateTotalDiscount(),
        textAlign: TextAlign.center,
      );

  String _generateTotalDiscount() {
    var priceTxt;
    if (marketOrderItem.totalDiscount == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${marketOrderItem.totalDiscount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(marketOrderItem.totalDiscount);
      } else {
        temp = "${marketOrderItem.totalDiscount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
