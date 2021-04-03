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
                          ..width(36)
                          ..height(36)
                          ..alignment.centerLeft()
                          ..borderRadius(all: 18)
                          ..ripple(true),
                        child: Icon(
                          Feather.trash_2,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
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
        ProductListItemCounter(
          key: productCounterKey,
          defaultValue: basketItem.amount,
          unit: ("${basketItem.productUnit}".toLowerCase() == "kilogram")
              ? "کیلوگرم"
              : null,
          hieght: 32,
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

  String _generateDiscountPrice() {
    var priceTxt;
    if (basketItem.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
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

  String _generateDiscountedRate() {
    double discountRateTxt =
        100 - (basketItem.discountedPrice) * 100 / (basketItem.originalPrice);
    if (discountRateTxt < 1)
      return "0٪";
    else
      return "${discountRateTxt.toStringAsFixed(1)}٪";
  }
}
