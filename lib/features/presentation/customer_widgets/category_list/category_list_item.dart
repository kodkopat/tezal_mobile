// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/market_detail_result_model.dart';
import '../product_list/product_horizontal_list.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    required this.category,
    required this.onCategoryTap,
    required this.onSeeAllTap,
  });

  final Category category;
  final void Function() onCategoryTap;
  final void Function() onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4, 16, 20, 8),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${category.name}",
                gesture: Gestures()..onTap(onCategoryTap),
                style: AppTxtStyles().body..bold(),
              ),
              Txt(
                "مشاهده همه محصولات \u00BB",
                gesture: Gestures()..onTap(onSeeAllTap),
                style: AppTxtStyles().footNote
                  ..borderRadius(all: 4)
                  ..margin(top: 2)
                  ..padding(horizontal: 4, vertical: 2)
                  ..ripple(true),
              ),
            ],
          ),
        ),
        ProductHorizontalList(
          products: category.products!,
        ),
      ],
    );
  }
}
