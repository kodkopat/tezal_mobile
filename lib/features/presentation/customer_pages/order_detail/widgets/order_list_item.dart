import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/order_detail_result_model.dart';
import '../../../../data/models/photos_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../../providers/customer_providers/order_notifier.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem({
    @required this.orderItem,
    @required this.orderNotifier,
  });

  final OrderItem orderItem;
  final OrderNotifier orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Parent(
              style: ParentStyle()
                ..width(96)
                ..height(96)
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
            SizedBox(width: 8),
            Expanded(
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    "${orderItem.productName}",
                    style: AppTxtStyles().subHeading..bold(),
                  ),
                  SizedBox(height: 4),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _fieldOriginalPrice(),
                      _fieldDiscountedRate(),
                    ],
                  ),
                  _fieldDiscountPrice(),
                  _fieldDiscountedPrice(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: orderNotifier.customerProductRepo.productphoto(
        id: orderItem.id,
        multi: false,
      ),
      successBuilder: (context, data) {
        return data.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data.photos.first),
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }

  Widget _fieldOriginalPrice() {
    return CustomRichText(
      title: "قیمت: ",
      text: _generateOriginalPrice(),
      dashedLineText: true,
    );
  }

  Widget _fieldDiscountPrice() {
    return CustomRichText(
      title: "تخفیف:",
      text: _generateDiscountPrice(),
    );
  }

  Widget _fieldDiscountedPrice() {
    return CustomRichText(
      title: "قیمت نهایی:",
      text: _generateDiscountedPrice(),
    );
  }

  Widget _fieldDiscountedRate() {
    if (_generateDiscountedRate().isEmpty) {
      return SizedBox();
    }

    return Txt(
      _generateDiscountedRate(),
      style: AppTxtStyles().footNote
        ..width(36)
        ..fontSize(10)
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.white)
        ..background.color(Colors.red)
        ..borderRadius(all: 4),
    );
  }

  String _generateOriginalPrice() {
    var priceTxt;
    if (orderItem.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (orderItem.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${orderItem.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(orderItem.originalPrice);
      } else {
        temp = "${orderItem.originalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  String _generateDiscountPrice() {
    var priceTxt;
    if (orderItem.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else {
      var temp;
      if ("${orderItem.discountedPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(orderItem.discountedPrice);
      } else {
        temp = "${orderItem.discountedPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  String _generateDiscountedPrice() {
    var priceTxt;
    if (orderItem.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (orderItem.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${orderItem.discountedPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(orderItem.discountedPrice);
      } else {
        temp = "${orderItem.discountedPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  String _generateDiscountedRate() {
    double discountRateTxt =
        100 - (orderItem.discountedPrice) * 100 / (orderItem.originalPrice);
    if (discountRateTxt < 1)
      return "0٪";
    else
      return "${discountRateTxt.toStringAsFixed(1)}٪";
  }
}
