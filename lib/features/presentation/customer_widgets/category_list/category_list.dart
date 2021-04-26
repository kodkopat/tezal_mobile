// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/customer/market_detail_result_model.dart';
import '../../customer_pages/market_category/market_category.dart';
import '../../providers/customer_providers/basket_notifier.dart';
import 'category_list_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    required this.marketId,
    required this.categories,
    required this.basketNotifier,
  });

  final String marketId;
  final List<Category> categories;
  final BasketNotifier basketNotifier;

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
                basketNotifier: basketNotifier,
                onCategoryTap: () {
                  Routes.sailor.navigate(
                    MarketCategoryPage.route,
                    params: {
                      "marketId": marketId,
                      "marketCategories": categories,
                    },
                  );
                },
              );
            },
          );
  }
}
