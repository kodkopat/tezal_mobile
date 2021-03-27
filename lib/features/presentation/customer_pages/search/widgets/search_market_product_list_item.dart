import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/photo_result_model.dart';
import '../../../../data/models/search_result_model.dart';
import '../../../../data/repositories/customer_product_repository.dart';

class SearchMarketProductListItem extends StatelessWidget {
  SearchMarketProductListItem({
    Key key,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  final Product product;
  final void Function() onTap;
  final _customerProductRepo = CustomerProductRepository();

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(160)
        ..margin(horizontal: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Parent(
                style: ParentStyle()
                  ..width(160)
                  ..height(128)
                  ..borderRadius(all: 8)
                  ..background.image(
                    alignment: Alignment.center,
                    path: "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: _futureImgFile,
                ),
              ),
              SizedBox(height: 8),
              Txt(
                "${product.name}",
                style: AppTxtStyles().subHeading
                  ..padding(right: 4)
                  ..bold(),
              ),
            ],
          ),
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldOriginalPrice(product),
              _fieldDiscountedPrice(product),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotoResultModel>>(
      future: _customerProductRepo.marketProductPhoto(id: product.id),
      successBuilder: (context, data) {
        return data.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data.photo),
            fit: BoxFit.fill,
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }

  Widget _fieldOriginalPrice(Product product) {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var priceTxt;
    if (product.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${product.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.originalPrice);
      } else {
        temp = "${product.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    var discountRateTxt;
    if (product.discountRate == null || product.discountRate == 0) {
      discountRateTxt = "";
    } else {
      discountRateTxt = "${product.discountRate}٪";
    }

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: "قیمت" + ": ",
            style: textStyle,
          ),
          TextSpan(
            text: priceTxt,
            style: textStyle.copyWith(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: " $discountRateTxt ",
            style: textStyle.copyWith(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldDiscountedPrice(Product product) {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var priceTxt;
    if (product.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${product.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.originalPrice);
      } else {
        temp = "${product.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: "قیمت نهایی" + ": ",
            style: textStyle,
          ),
          TextSpan(
            text: priceTxt,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
