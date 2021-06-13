// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/market/product_result_model.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: connect this section to shared photo
          // ProductPhotosWidget(productId: product.id),
          const SizedBox(height: 8),
          _sectionTitleAndCommentsBtn(product),
          const SizedBox(height: 8),
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
          if (product.description != null) const SizedBox(height: 8),
          if (product.description != null)
            Txt(
              "توضیحات محصول",
              style: AppTxtStyles().body
                ..margin(vertical: 4)
                ..textAlign.right()
                ..bold(),
            ),
          if (product.description != null)
            Txt(
              "${product.description}",
              style: AppTxtStyles().body
                ..margin(vertical: 4)
                ..textAlign.right(),
            ),
        ],
      ),
    );
  }

  Widget _sectionTitleAndCommentsBtn(ProductResultModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Txt(
          "${product.name}",
          style: AppTxtStyles().heading
            ..textOverflow(TextOverflow.ellipsis)
            ..maxLines(1)
            ..bold(),
        ),
        Parent(
          gesture: Gestures()
            ..onTap(() {
              Routes.sailor.navigate(
                ProductCommentsPage.route,
                params: {"productId": product.id},
              );
            }),
          style: ParentStyle()
            ..width(48)
            ..height(48)
            ..alignmentContent.center()
            ..borderRadius(all: 24)
            ..ripple(true),
          child: Image.asset(
            "assets/images/ic_comment.png",
            color: Colors.black12,
            fit: BoxFit.contain,
            width: 24,
            height: 24,
          ),
        ),
      ],
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
