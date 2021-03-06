// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/customer/product_result_model.dart';
import '../../base_widgets/shared_photo.dart';
import '../../customer_providers/liked_product_notifier.dart';
import 'product_counter.dart';
import 'product_like_toggle.dart';

class ProductHorizontalListItem extends StatelessWidget {
  ProductHorizontalListItem({
    required this.product,
    required this.onTap,
    required this.onAddToBasket,
    required this.onRemoveFromBasket,
  });

  final ProductResultModel product;
  final VoidCallback onTap;
  final VoidCallback onAddToBasket;
  final VoidCallback onRemoveFromBasket;

  @override
  Widget build(BuildContext context) {
    var productNotifier =
        Provider.of<LikedProductNotifier>(context, listen: false);

    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(144)
        ..margin(horizontal: 8)
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
      child: Stack(
        children: [
          Column(
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
                  child: (product.photo == null || product.photo!.isEmpty)
                      ? SizedBox()
                      : SharedPhoto.getProductPhoto(id: product.photo!.first),
                ),
              ),
              Txt(
                "${product.name}",
                style: AppTxtStyles().body
                  ..padding(right: 4)
                  ..textOverflow(TextOverflow.ellipsis)
                  ..maxLines(1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldOriginalPrice(),
                      _fieldDiscountedPrice(),
                    ],
                  ),
                  _fieldDiscountedRate(),
                ],
              ),
              // if (product.onSale ?? false)
              ProductListItemCounter(
                hieght: 28,
                defaultValue: product.amount * product.step,
                step: product.step,
                unit: "${product.productUnit}",
                onIncrease: onAddToBasket,
                onDecrease: onRemoveFromBasket,
              ),
            ],
          ),
          Positioned(
            right: 2,
            top: 2,
            child: ProductListItemLikeToggle(
              defaultValue: product.liked,
              onChange: (value) async {
                if (value) {
                  productNotifier.likeProduct(
                    productId: product.id,
                  );
                } else {
                  productNotifier.unlikeProduct(
                    productId: product.id,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldOriginalPrice() {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateOriginalPrice(),
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

  Widget _fieldDiscountedPrice() => RichText(
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

  Widget _fieldDiscountedRate() {
    if (_generateDiscountedRate().isEmpty) {
      return SizedBox();
    }

    return Txt(
      _generateDiscountedRate(),
      style: AppTxtStyles().subHeading
        ..bold()
        ..padding(horizontal: 8, vertical: 4)
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.red)
        ..background.color(Colors.red.withOpacity(0.1))
        ..borderRadius(
          topLeft: 4,
          bottomLeft: 4,
          topRight: 24,
          bottomRight: 24,
        ),
    );
  }

  String _generateOriginalPrice() {
    var priceTxt;
    if (product.originalPrice == null) {
      priceTxt = " ?????? ???????? ";
    } else if (product.originalPrice == 0) {
      priceTxt = " ???????????? ";
    } else {
      var temp;
      if ("${product.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.originalPrice);
      } else {
        temp = "${product.originalPrice}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt;
  }

  String _generateDiscountedPrice() {
    var priceTxt;
    if (product.discountedPrice == null) {
      priceTxt = " ?????? ???????? ";
    } else if (product.discountedPrice == 0) {
      priceTxt = " ???????????? ";
    } else {
      var temp;
      if ("${product.originalPrice}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(product.originalPrice);
      } else {
        temp = "${product.originalPrice}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt;
  }

  String _generateDiscountedRate() {
    var discountRateTxt;
    if (product.discountRate == null || product.discountRate == 0) {
      discountRateTxt = "";
    } else {
      discountRateTxt = "${(product.discountRate * 100).toStringAsFixed(0)}??";
    }
    return discountRateTxt;
  }
}
