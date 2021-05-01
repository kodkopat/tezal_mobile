// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' as intl;

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/market/product_result_model.dart';
import '../../customer_widgets/custom_rich_text.dart';

class ProductListItem extends StatelessWidget {
  ProductListItem({
    required this.product,
    required this.onTap,
  });

  final ProductResultModel product;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
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
                    Txt(
                      "${product.productName}",
                      style: AppTxtStyles().subHeading..bold(),
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
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return SizedBox() /* CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: basketNotifier.customerProductRepo.productphoto(
        id: product.id,
        multi: false,
      ),
      successBuilder: (context, data) {
        return data!.fold(
          (left) => SizedBox(),
          (right) => Image.memory(
            base64Decode(right.data.photos.first),
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    ) */
        ;
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
    // total price
    var priceTxt;
    if (product.originalPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.originalPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp = "2000";
      // if ("${product.originalPrice}".length >= 3) {
      //   temp = intl.NumberFormat("#,000").format(product.originalPrice);
      // } else {
      //   temp = "${product.originalPrice}";
      // }

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
    if (product.discountedPrice == null) {
      priceTxt = " ذکر نشده ";
    } else if (product.discountedPrice == 0) {
      priceTxt = " رایگان ";
    } else {
      var temp = "2000";
      // if ("${product.discountedPrice}".length >= 3) {
      //   temp = intl.NumberFormat("#,000").format(product.discountedPrice);
      // } else {
      //   temp = "${product.discountedPrice}";
      // }

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
    num discountRateTxt = 2000
        /* 100 - (product.discountedPrice) * 100 / (product.originalPrice) */;
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
      var temp = "20000";
      // if ("${product.originalPrice}".length >= 3) {
      //   temp = intl.NumberFormat("#,000").format(product.originalPrice);
      // } else {
      //   temp = "${product.originalPrice}";
      // }

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
      var temp = "20000";
      // if ("${product.originalPrice - product.discountedPrice}".length >= 3) {
      //   temp = intl.NumberFormat("#,000")
      //       .format(product.originalPrice - product.discountedPrice);
      // } else {
      //   temp = "${product.originalPrice - product.discountedPrice}";
      // }

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
    // total discount
    var priceTxt;
    if (product.discountedPrice == null) {
      priceTxt = "-";
    } else {
      var temp = "20000";
      // if ("${product.discountedPrice}".length >= 3) {
      //   temp = intl.NumberFormat("#,000").format(product.discountedPrice);
      // } else {
      //   temp = "${product.discountedPrice}";
      // }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt;
  }
}
