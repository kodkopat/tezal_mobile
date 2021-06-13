// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/order_detail_result_model.dart';
import '../../../base_widgets/shared_photo.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem({
    required this.orderItem,
    required this.showCommentOption,
    required this.onCommentTap,
  });

  final OrderItem orderItem;
  final bool showCommentOption;
  final VoidCallback onCommentTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Parent(
                style: ParentStyle()
                  ..width(96)
                  ..height(96)
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
                  child: SharedPhoto.getProductPhoto(id: orderItem.id),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          "${orderItem.productName}",
                          style: AppTxtStyles().subHeading..bold(),
                        ),
                        if (showCommentOption)
                          Parent(
                            gesture: Gestures()..onTap(onCommentTap),
                            style: ParentStyle()
                              ..width(48)
                              ..height(48)
                              ..borderRadius(all: 24)
                              ..alignmentContent.center()
                              ..ripple(true),
                            child: Image.asset(
                              "assets/images/ic_comment.png",
                              fit: BoxFit.contain,
                              color: Colors.black26,
                              width: 24,
                              height: 24,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_generateDiscountedRate().isNotEmpty)
                              _fieldTotalPrice(),
                            _fieldTotalDiscountedPrice(),
                          ],
                        ),
                        _fieldDiscountedRate(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _fieldOriginalPrice,
              _verticalDivider,
              _fieldDiscountedPrice,
              _verticalDivider,
              _fieldTotalDiscount,
            ],
          ),
          const SizedBox(height: 12),
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

  Widget _fieldTotalPrice() {
    return RichText(
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
    if (orderItem.totalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (orderItem.totalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${orderItem.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(orderItem.totalPrice);
      } else {
        temp = "${orderItem.totalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget _fieldTotalDiscountedPrice() {
    return RichText(
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
    if (orderItem.totalDiscountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (orderItem.totalDiscountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${orderItem.totalDiscountedPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(orderItem.totalDiscountedPrice);
      } else {
        temp = "${orderItem.totalDiscountedPrice}";
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
    num discountRateTxt =
        100 - (orderItem.discountedPrice) * 100 / (orderItem.originalPrice);
    if (discountRateTxt < 1)
      return "";
    else
      return "${discountRateTxt.toStringAsFixed(1)}٪";
  }

  Widget get _fieldOriginalPrice => CustomRichText(
        title: "قیمت هر واحد" + "\n",
        text: _generateOriginalPrice(),
        textAlign: TextAlign.center,
      );

  String _generateOriginalPrice() {
    var priceTxt;
    if (orderItem.originalPrice == null) {
      priceTxt = "-";
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

  Widget get _fieldDiscountedPrice => CustomRichText(
        title: "تخفیف هر واحد" + "\n",
        text: _generateDiscountedPrice(),
        textAlign: TextAlign.center,
      );

  String _generateDiscountedPrice() {
    var priceTxt;
    if (orderItem.originalPrice == null || orderItem.discountedPrice == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${orderItem.originalPrice - orderItem.discountedPrice}".length >=
          3) {
        temp = intl.NumberFormat("#,000")
            .format(orderItem.originalPrice - orderItem.discountedPrice);
      } else {
        temp = "${orderItem.originalPrice - orderItem.discountedPrice}";
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
    if (orderItem.totalDiscount == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${orderItem.totalDiscount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(orderItem.totalDiscount);
      } else {
        temp = "${orderItem.totalDiscount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
