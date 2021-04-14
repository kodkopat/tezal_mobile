// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/market_detail_result_model.dart';
import '../../customer_pages/category/category_page.dart';
import '../../customer_pages/products/produtct_page.dart';
import 'category_list_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    required this.categories,
    required this.marketId,
  });

  final List<Category> categories;
  final String marketId;

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? Txt(
            "دسته‌بندی محصولات برای فروشگاه مورد نظر وجود ندارد!",
            style: AppTxtStyles().body..alignment.center(),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CategoryListItem(
                category: categories[index],
                onCategoryTap: () {
                  Routes.sailor.navigate(
                    CategoryPage.route,
                    params: {
                      "marketId": marketId,
                      "mainCategoryId": "${categories[index].id}",
                    },
                  );
                },
                onSeeAllTap: () {
                  Routes.sailor.navigate(
                    ProductsPage.route,
                    params: {
                      "marketId": marketId,
                      "categoryId": "${categories[index].id}",
                    },
                  );
                },
              );
            },
          );
  }
}
