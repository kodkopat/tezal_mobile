import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../data/models/photos_result_model.dart';
import '../../../data/models/product_result_model.dart';
import '../../../data/repositories/customer_basket_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../custom_rich_text.dart';
import 'product_list_item_counter.dart';
import 'product_list_item_like_toggle.dart';

class ProductListItem extends StatelessWidget {
  ProductListItem({
    Key key,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  final ProdutcResultModel product;
  final void Function() onTap;
  final _customerProductRepo = CustomerProductRepository();
  final _customerBasketRepo = CustomerBasketRepository();

  final productCounterKey = GlobalKey<ProductListItemCounterState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(192)
        ..margin(horizontal: 8)
        ..padding(horizontal: 4, vertical: 4)
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
                  ..width(192)
                  ..height(144)
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
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    "${product.name}",
                    style: AppTxtStyles().subHeading
                      ..padding(right: 4)
                      ..textOverflow(TextOverflow.ellipsis)
                      ..maxLines(1)
                      ..bold(),
                  ),
                  ProductListItemLikeToggle(
                    defaultValue: product.liked,
                    onChange: (value) {
                      if (value) {
                        _customerProductRepo.likeProduct(
                          id: product.id,
                        );
                      } else {
                        _customerProductRepo.unlikeProduct(
                          id: product.id,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _fieldOriginalPrice(),
                  _fieldDiscountedRate(),
                ],
              ),
              _fieldDiscountedPrice(),
            ],
          ),
          ProductListItemCounter(
            key: productCounterKey,
            defaultValue: product.amount,
            onIncrease: (value) {
              _customerBasketRepo.addProductToBasket(
                productId: product.id,
                amount: 1,
              );
            },
            onDecrease: (value) {
              _customerBasketRepo.removeProductToBasket(
                productId: product.id,
                amount: 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: _customerProductRepo.productphoto(id: product.id),
      successBuilder: (context, data) {
        return data.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data.photos.first),
            fit: BoxFit.fill,
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }

  Widget _fieldOriginalPrice() {
    return CustomRichText(
      title: "قیمت",
      text: _generateOriginalPrice(),
      dashedLineText: true,
    );
  }

  Widget _fieldDiscountedPrice() {
    return CustomRichText(
      title: "قیمت نهایی",
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
        ..bold()
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.white)
        ..background.color(Colors.red)
        ..borderRadius(all: 4)
        ..padding(horizontal: 8),
    );
  }

  String _generateOriginalPrice() {
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

    return priceTxt;
  }

  String _generateDiscountedPrice() {
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

    return priceTxt;
  }

  String _generateDiscountedRate() {
    var discountRateTxt;
    if (product.discountRate == null || product.discountRate == 0) {
      discountRateTxt = "";
    } else {
      discountRateTxt = "${product.discountRate}٪";
    }
    return discountRateTxt;
  }
}
