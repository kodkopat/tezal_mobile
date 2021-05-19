// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/carousel_image_slider.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../data/models/market/product_result_model.dart';
import '../../../data/models/photos_result_model.dart';
import '../../../data/repositories/shared_application_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../product_comments/product_comments_page.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatelessWidget {
  static const route = "/market_product_detail";

  ProductDetailPage({required this.product});

  final ProductResultModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات محصول",
        showBackBtn: true,
      ),
      body: _listOfSections(context, product),
    );
  }

  Widget _listOfSections(BuildContext context, ProductResultModel product) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(product),
          const SizedBox(height: 8),
          _sectionTitleAndLike(product),
          if (product.description != null)
            Txt(
              "${product.description}",
              style: AppTxtStyles().body
                ..margin(vertical: 4)
                ..textAlign.right(),
            ),
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
                  _fieldOriginalPrice(product),
                  _fieldDiscountedPrice(product),
                ],
              ),
              _fieldDiscountedRate(product),
            ],
          ),
          SizedBox(height: 16),
          Parent(
            gesture: Gestures()
              ..onTap(() {
                Routes.sailor.navigate(
                  ProductCommentsPage.route,
                  params: {"productId": product.id},
                );
              }),
            style: ParentStyle()
              ..margin(vertical: 8)
              ..padding(right: 16, left: 4, vertical: 4)
              ..background.color(Colors.white)
              ..borderRadius(all: 8)
              ..boxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 3.0),
                blur: 6,
                spread: 0,
              )
              ..ripple(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  "مشاهده نظرات کاربران",
                  style: AppTxtStyles().body..bold(),
                ),
                Parent(
                  style: ParentStyle()
                    ..width(48)
                    ..height(48)
                    ..alignmentContent.center(),
                  child: Image.asset(
                    "assets/images/ic_comment.png",
                    color: Colors.black12,
                    fit: BoxFit.contain,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(ProductResultModel product) {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: SharedApplicationRepository().getProductPhotos(
        productId: product.id,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (left) => CarouselImageSlider(images: []),
          (right) => CarouselImageSlider(
            images: right.data!.map((e) => "${e.photo}").toList(),
          ),
        );
      },
      errorBuilder: (context, data) {
        return CarouselImageSlider(images: []);
      },
    );
  }

  Widget _sectionTitleAndLike(ProductResultModel product) {
    return Txt(
      "${product.name}",
      style: AppTxtStyles().heading
        ..textOverflow(TextOverflow.ellipsis)
        ..maxLines(1)
        ..bold(),
    );
  }

  Widget _fieldOriginalPrice(ProductResultModel product) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateOriginalPrice(product),
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

  Widget _fieldDiscountedPrice(ProductResultModel product) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        text: _generateDiscountedPrice(product),
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

  Widget _fieldDiscountedRate(ProductResultModel product) {
    if (_generateDiscountedRate(product).isEmpty) {
      return SizedBox();
    }

    return Txt(
      _generateDiscountedRate(product),
      style: AppTxtStyles().subHeading
        ..bold()
        ..textDirection(TextDirection.ltr)
        ..textColor(Colors.red)
        ..background.color(Colors.red.withOpacity(0.1))
        ..borderRadius(topLeft: 4, bottomLeft: 4, topRight: 24, bottomRight: 24)
        ..padding(horizontal: 12, vertical: 8),
    );
  }

  String _generateOriginalPrice(ProductResultModel product) {
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

  String _generateDiscountedPrice(ProductResultModel product) {
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

  String _generateDiscountedRate(ProductResultModel product) {
    var td = product.discountedPrice;
    var tp = product.originalPrice;

    if (td == null || td == 0) {
      return "";
    } else {
      num discountRate = (td / tp) * 100;
      if (discountRate < 1)
        return "";
      else
        return "${discountRate.toStringAsFixed(1)}٪";
    }
  }
}
