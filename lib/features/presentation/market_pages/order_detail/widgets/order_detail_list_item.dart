import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/orders_result_model.dart';

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
        ..margin(vertical: 4)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Row(
        children: [
          Parent(
            style: ParentStyle()
              ..width(72)
              ..height(72)
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
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                "${marketOrderItem.productName}",
                style: AppTxtStyles().body
                  ..padding(right: 4)
                  ..textOverflow(TextOverflow.ellipsis)
                  ..maxLines(1),
              ),
              const SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _fieldTotalOriginalPrice,
                      const SizedBox(width: 4),
                      _fieldDiscountedRate,
                    ],
                  ),
                  _fieldTotalDiscountedPrice,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _fieldDiscountedRate {
    if (_generateDiscountedRate().isEmpty) {
      return SizedBox();
    }

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateDiscountedRate(),
        style: TextStyle(
          color: Colors.red,
          letterSpacing: 0.5,
          fontFamily: 'Yekan',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String _generateDiscountedRate() {
    var op = marketOrderItem.originalPrice;
    var dp = marketOrderItem.discountedPrice;

    if (op == null || dp == null) {
      return "10٪";
    }

    num discountRateTxt = (dp / op) * 100;
    if (discountRateTxt < 1)
      return "";
    else
      return "${discountRateTxt.toStringAsFixed(1)}٪";
  }

  Widget get _fieldTotalOriginalPrice => RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: _generateTotalOriginalPrice(),
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            letterSpacing: 0.5,
            fontFamily: 'Yekan',
            decoration: TextDecoration.lineThrough,
            fontSize: 10,
          ),
        ),
      );

  String _generateTotalOriginalPrice() {
    var priceTxt;
    if (marketOrderItem.originalPrice == null) {
      // priceTxt = "-";
      return " 500 " + "تومان";
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

  Widget get _fieldTotalDiscountedPrice => RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: _generateTotalDiscountedPrice(),
          style: TextStyle(
            color: Colors.green,
            letterSpacing: 0.5,
            fontFamily: 'Yekan',
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );

  String _generateTotalDiscountedPrice() {
    var priceTxt;
    if (marketOrderItem.originalPrice == null ||
        marketOrderItem.discountedPrice == null) {
      // priceTxt = "-";
      return " 450 " + "تومان";
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
}
