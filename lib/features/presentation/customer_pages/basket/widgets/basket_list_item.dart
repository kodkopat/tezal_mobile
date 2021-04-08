import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/basket_result_model.dart';
import '../../../../data/models/photos_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../../customer_widgets/product_list/product_list_item_counter.dart';
import '../../../providers/customer_providers/basket_notifier.dart';

class BasketListItem extends StatelessWidget {
  BasketListItem({
    Key key,
    @required this.basketItem,
    @required this.onRemoveItem,
    @required this.basketNotifier,
  }) : super(key: key);

  final BasketItem basketItem;
  final void Function() onRemoveItem;
  final BasketNotifier basketNotifier;
  final productCounterKey = GlobalKey<ProductListItemCounterState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          "${basketItem.productName}",
                          style: AppTxtStyles().subHeading..bold(),
                        ),
                        Parent(
                          gesture: Gestures()..onTap(onRemoveItem),
                          style: ParentStyle()
                            ..width(48)
                            ..height(48)
                            ..borderRadius(all: 24)
                            ..ripple(true),
                          child: Icon(
                            Feather.trash_2,
                            color: Colors.black26,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
          SizedBox(height: 12),
          Row(
            textDirection: TextDirection.rtl,
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
            key: productCounterKey,
            defaultValue: basketItem.amount * basketItem.step,
            unit: "${basketItem.productUnit}",
            step: basketItem.step,
            onIncrease: (value) async {
              await basketNotifier.customerBasketRepo.addProductToBasket(
                productId: basketItem.id,
                amount: 1,
              );
              basketNotifier.refresh();
            },
            onDecrease: (value) async {
              await basketNotifier.customerBasketRepo.removeProductToBasket(
                productId: basketItem.id,
                amount: 1,
              );
              basketNotifier.refresh();
            },
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: basketNotifier.customerProductRepo.productphoto(
        id: basketItem.id,
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
    if (basketItem.totalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (basketItem.totalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${basketItem.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.totalPrice);
      } else {
        temp = "${basketItem.totalPrice}";
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
    if (basketItem.totalDiscountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (basketItem.totalDiscountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${basketItem.totalDiscountedPrice}".length >= 3) {
        temp =
            intl.NumberFormat("#,000").format(basketItem.totalDiscountedPrice);
      } else {
        temp = "${basketItem.totalDiscountedPrice}";
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
    double discountRateTxt =
        100 - (basketItem.discountedPrice) * 100 / (basketItem.originalPrice);
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
    if (basketItem.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (basketItem.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${basketItem.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.originalPrice);
      } else {
        temp = "${basketItem.originalPrice}";
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
    if (basketItem.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (basketItem.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${basketItem.discountedPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.discountedPrice);
      } else {
        temp = "${basketItem.discountedPrice}";
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
    if (basketItem.totalDiscount == null) {
      priceTxt = " ذکر نشده ";
    } else {
      var temp;
      if ("${basketItem.totalDiscount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(basketItem.totalDiscount);
      } else {
        temp = "${basketItem.totalDiscount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
