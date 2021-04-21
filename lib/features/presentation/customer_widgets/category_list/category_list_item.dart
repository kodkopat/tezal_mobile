// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/market_detail_result_model.dart';
import '../../customer_pages/product_detail/product_detail_page.dart';
import '../product_list/product_horizontal_list.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    required this.category,
    required this.onCategoryTap,
  });

  final Category category;
  final void Function() onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Txt(
              "${category.name}",
              gesture: Gestures()..onTap(onCategoryTap),
              style: AppTxtStyles().body
                ..margin(right: 20, top: 16, bottom: 8)
                ..padding(all: 4)
                ..borderRadius(all: 4)
                ..ripple(true)
                ..bold(),
            ),
            Txt(
              "مشاهده محصولات دسته‌بندی \u00BB",
              gesture: Gestures()..onTap(onCategoryTap),
              style: AppTxtStyles().footNote
                ..margin(left: 16, top: 18, bottom: 8)
                ..padding(all: 4)
                ..borderRadius(all: 4)
                ..ripple(true),
            ),
          ],
        ),
        ProductHorizontalList(
          products: category.products!,
          onItemTap: (index) {
            Routes.sailor.navigate(
              ProductDetailPage.route,
              params: {
                "productId": category.products![index].id,
              },
            );
          },
        ),
      ],
    );
  }
}
