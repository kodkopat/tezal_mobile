// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/basket_result_model.dart';
import '../../../base_widgets/shared_photo.dart';
import '../../../customer_providers/basket_notifier.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../../customer_widgets/product_list/product_counter.dart';

class BasketListItem extends StatelessWidget {
  BasketListItem({
    required this.basketItem,
    required this.onAddToBasket,
    required this.onRemoveFromBasket,
    required this.onRemoveItem,
    required this.basketNotifier,
  });

  final BasketItem basketItem;
  final VoidCallback onAddToBasket;
  final VoidCallback onRemoveFromBasket;
  final VoidCallback onRemoveItem;
  final BasketNotifier basketNotifier;
  final productCounterKey = GlobalKey<ProductListItemCounterState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  child: SharedPhoto.getProductPhoto(id: basketItem.id),
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
                          "${basketItem.name}",
                          style: AppTxtStyles().subHeading..bold(),
                        ),
                        Parent(
                          gesture: Gestures()..onTap(onRemoveItem),
                          style: ParentStyle()
                            ..width(48)
                            ..height(48)
                            ..borderRadius(all: 24)
                            ..alignmentContent.center()
                            ..ripple(true),
                          child: Image.asset(
                            "assets/images/ic_delete.png",
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
                              _fieldTotalPrice,
                            _fieldTotalDiscountedPrice,
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
          SizedBox(height: 12),
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
          SizedBox(height: 12),
          ProductListItemCounter(
            hieght: 32,
            defaultValue: basketItem.amount * basketItem.step,
            step: basketItem.step,
            unit: "${basketItem.productUnit}",
            onIncrease: onAddToBasket,
            onDecrease: onRemoveFromBasket,
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

  Widget get _fieldTotalPrice => RichText(
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

  String _generateTotalPrice() {
    var priceTxt;
    if (basketItem.totalPrice == null) {
      priceTxt = " ?????? ???????? ";
    } else if (basketItem.totalPrice == 0) {
      priceTxt = " ???????????? ";
    } else {
      var temp;
      if ("${basketItem.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.totalPrice);
      } else {
        temp = "${basketItem.totalPrice}";
      }

      priceTxt = " $temp " + "??????????";
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
            fontSize: 14,
          ),
        ),
      );

  String _generateTotalDiscountedPrice() {
    var priceTxt;
    if (basketItem.totalDiscountedPrice == null) {
      priceTxt = " ?????? ???????? ";
    } else if (basketItem.totalDiscountedPrice == 0) {
      priceTxt = " ???????????? ";
    } else {
      var temp;
      if ("${basketItem.totalDiscountedPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(basketItem.totalDiscountedPrice);
      } else {
        temp = "${basketItem.totalDiscountedPrice}";
      }

      priceTxt = " $temp " + "??????????";
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
        100 - (basketItem.discountedPrice) * 100 / (basketItem.originalPrice);
    if (discountRateTxt < 1)
      return "";
    else
      return "${discountRateTxt.toStringAsFixed(1)}??";
  }

  Widget get _fieldOriginalPrice => CustomRichText(
        title: "???????? ???? ????????" + "\n",
        text: _generateOriginalPrice(),
        textAlign: TextAlign.center,
      );

  String _generateOriginalPrice() {
    var priceTxt;
    if (basketItem.originalPrice == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${basketItem.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.originalPrice);
      } else {
        temp = "${basketItem.originalPrice}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt;
  }

  Widget get _fieldDiscountedPrice => CustomRichText(
        title: "?????????? ???? ????????" + "\n",
        text: _generateDiscountedPrice(),
        textAlign: TextAlign.center,
      );

  String _generateDiscountedPrice() {
    var priceTxt;
    if (basketItem.originalPrice == null ||
        basketItem.discountedPrice == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${basketItem.originalPrice - basketItem.discountedPrice}".length >=
          3) {
        temp = intl.NumberFormat("#,000")
            .format(basketItem.originalPrice - basketItem.discountedPrice);
      } else {
        temp = "${basketItem.originalPrice - basketItem.discountedPrice}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt;
  }

  Widget get _fieldTotalDiscount => CustomRichText(
        title: "?????? ???? ????????" + "\n",
        text: _generateTotalDiscount(),
        textAlign: TextAlign.center,
      );

  String _generateTotalDiscount() {
    var priceTxt;
    if (basketItem.totalDiscount == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${basketItem.totalDiscount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.totalDiscount);
      } else {
        temp = "${basketItem.totalDiscount}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt;
  }
}
