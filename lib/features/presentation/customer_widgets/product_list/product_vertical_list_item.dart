import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../data/models/customer/photos_result_model.dart';
import '../../../data/models/customer/product_result_model.dart';
import '../../customer_widgets/custom_rich_text.dart';
import '../../customer_widgets/product_list/product_counter.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/liked_product_notifier.dart';
import 'product_counter.dart';
import 'product_like_toggle.dart';

// ignore: must_be_immutable
class ProductVerticalListItem extends StatelessWidget {
  ProductVerticalListItem({
    required this.product,
    required this.onTap,
    required this.onAddToBasket,
    required this.onRemoveFromBasket,
  });

  final ProductResultModel product;
  final VoidCallback onTap;
  final VoidCallback onAddToBasket;
  final VoidCallback onRemoveFromBasket;
  late LikedProductNotifier productNotifier;
  late BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    productNotifier = Provider.of<LikedProductNotifier>(
      context,
      listen: false,
    );

    basketNotifier = Provider.of<BasketNotifier>(
      context,
      listen: false,
    );

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
                          "${product.name}",
                          style: AppTxtStyles().subHeading..bold(),
                        ),
                        ProductListItemLikeToggle(
                          defaultValue: product.liked,
                          onChange: (value) async {
                            if (value) {
                              // productNotifier.likeProduct(
                              //   productId: product.id,
                              // );
                            } else {
                              // productNotifier.unlikeProduct(
                              //   productId: product.id,
                              // );
                            }
                          },
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
            defaultValue: product.amount * product.step,
            step: product.step,
            unit: "${product.productUnit}",
            onIncrease: onAddToBasket,
            onDecrease: onRemoveFromBasket,
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile =>
      CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
        future: basketNotifier.customerProductRepo.getPhoto(id: product.id),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => SizedBox(),
            (right) => Image.memory(
              base64Decode(right.data!.photos.first),
              fit: BoxFit.fill,
            ),
          );
        },
        errorBuilder: (context, data) => SizedBox(),
      );

  Widget get _verticalDivider => SizedBox(
        height: 40,
        child: VerticalDivider(
          color: Colors.black12,
          thickness: 0.5,
          width: 0,
        ),
      );

  Widget _fieldTotalPrice() => RichText(
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

  String _generateTotalPrice() {
    var priceTxt;
    if (product.totalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.totalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${product.totalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.totalPrice);
      } else {
        temp = "${product.totalPrice}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }

  Widget _fieldTotalDiscountedPrice() => RichText(
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

  String _generateTotalDiscountedPrice() {
    var priceTxt;
    if (product.totalDiscountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.totalDiscountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp;
      if ("${product.totalDiscountedPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.totalDiscountedPrice);
      } else {
        temp = "${product.totalDiscountedPrice}";
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
        100 - (product.discountedPrice) * 100 / (product.originalPrice);
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
    if (product.originalPrice == null) {
      priceTxt = "-";
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

  Widget get _fieldDiscountedPrice => CustomRichText(
        title: "تخفیف هر واحد" + "\n",
        text: _generateDiscountedPrice(),
        textAlign: TextAlign.center,
      );

  String _generateDiscountedPrice() {
    var priceTxt;
    if (product.originalPrice == null || product.discountedPrice == null) {
      priceTxt = "-";
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

  Widget get _fieldTotalDiscount => CustomRichText(
        title: "سود کل خرید" + "\n",
        text: _generateTotalDiscount(),
        textAlign: TextAlign.center,
      );

  String _generateTotalDiscount() {
    var priceTxt;
    if (product.totalDiscount == null) {
      priceTxt = "-";
    } else {
      var temp;
      if ("${product.totalDiscount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.totalDiscount);
      } else {
        temp = "${product.totalDiscount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
