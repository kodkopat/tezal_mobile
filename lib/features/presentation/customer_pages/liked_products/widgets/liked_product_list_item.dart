import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/liked_products_result_model.dart';
import 'liked_product_list_item_like_toggle.dart';

class LikedProductListItem extends StatelessWidget {
  const LikedProductListItem({
    Key key,
    @required this.likedProduct,
  }) : super(key: key);

  final LikedProduct likedProduct;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LikedProductListItemLikeToggle(
            onChange: (value) {},
            defaultValue: true,
          ),
          _verticalDivider,
          _fieldName,
          _verticalDivider,
          _fieldCategory,
        ],
      ),
    );
  }

  Widget get _verticalDivider {
    return SizedBox(
      height: 48,
      child: VerticalDivider(
        color: Colors.black12,
        thickness: 0.5,
        width: 0,
      ),
    );
  }

  Widget get _fieldName {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "نام محصول" + "\n",
            style: txtStyle,
          ),
          TextSpan(
            text: (likedProduct.name == null)
                ? " ذکر نشده "
                : "${likedProduct.name}",
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldCategory {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "دسته‌بندی" + "\n",
            style: txtStyle,
          ),
          TextSpan(
            text: (likedProduct.category == null)
                ? " ذکر نشده "
                : "${likedProduct.category}",
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
