import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/market/product_result_model.dart';
import '../../../../data/models/photo_result_model.dart';
import '../../../../data/repositories/shared_application_repository.dart';

class AddProductListItem extends StatelessWidget {
  AddProductListItem({
    required this.product,
    required this.onTap,
    required this.onEditTap,
  });

  final ProductResultModel product;
  final VoidCallback onTap;
  final VoidCallback onEditTap;

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
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Parent(
              style: ParentStyle()
                ..width(double.infinity)
                ..borderRadius(all: 8)
                ..background.image(
                  alignment: Alignment.center,
                  path: "assets/images/img_placeholder.jpg",
                  fit: BoxFit.fill,
                ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: _futureImgFile,
              ),
            ),
          ),
          Txt(
            "${product.name}",
            style: AppTxtStyles().body
              ..margin(vertical: 4)
              ..bold(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_generateDiscountedRate().isNotEmpty)
                    Row(
                      children: [
                        _fieldOriginalPrice,
                        SizedBox(width: 4),
                        _fieldDiscountedRate,
                      ],
                    ),
                  _fieldDiscountedPrice,
                ],
              ),
              Parent(
                gesture: Gestures()..onTap(onEditTap),
                style: ParentStyle()
                  ..width(36)
                  ..height(36)
                  ..borderRadius(all: 4)
                  ..alignmentContent.center()
                  ..background.color(Color(0xffEFEFEF))
                  ..ripple(true),
                child: Icon(
                  Feather.plus,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile =>
      CustomFutureBuilder<Either<Failure, PhotoResultModel>>(
        future: SharedApplicationRepository().getProductPhoto(
          productId: product.id,
        ),
        successBuilder: (context, data) {
          print("photoData: $data\n");
          return data!.fold(
            (left) => SizedBox(),
            (right) => Image.memory(
              base64Decode(right.data!.photo),
              fit: BoxFit.fill,
            ),
          );
        },
        errorBuilder: (context, data) => SizedBox(),
      );

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
    var op = product.originalPrice;
    var dp = product.discountedPrice;

    if (op == null || dp == null) {
      return "10٪";
    }

    num discountRateTxt = (dp / op) * 100;
    if (discountRateTxt < 1)
      return "";
    else
      return "${discountRateTxt.toStringAsFixed(1)}٪";
  }

  Widget get _fieldOriginalPrice => RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: _generateOriginalPrice(),
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            letterSpacing: 0.5,
            fontFamily: 'Yekan',
            decoration: TextDecoration.lineThrough,
            fontSize: 10,
          ),
        ),
      );

  String _generateOriginalPrice() {
    var priceTxt;
    if (product.originalPrice == null) {
      // priceTxt = "-";
      return " 500 " + "تومان";
    } else {
      var temp;
      if ("${product.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.originalPrice);
      } else {
        temp = "${product.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget get _fieldDiscountedPrice => RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: _generateDiscountedPrice(),
          style: TextStyle(
            color: Colors.green,
            letterSpacing: 0.5,
            fontFamily: 'Yekan',
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );

  String _generateDiscountedPrice() {
    var priceTxt;
    if (product.originalPrice == null || product.discountedPrice == null) {
      // priceTxt = "-";
      return " 450 " + "تومان";
    } else {
      var temp;
      if ("${product.originalPrice - product.discountedPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000")
            .format(product.originalPrice - product.discountedPrice);
      } else {
        temp = "${product.originalPrice - product.discountedPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
