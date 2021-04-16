import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../data/models/main_category_result_model.dart';
import '../../../providers/customer_providers/category_notifier.dart';
import '../../sub_category/sub_category_page.dart';
import 'main_category_list_item.dart';

class MainCategoryList extends StatelessWidget {
  MainCategoryList({
    required this.mainCategories,
    required this.categoryNotifier,
  });

  final List<MainCategory> mainCategories;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: mainCategories.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return MainCategoryListItem(
          mainCategory: mainCategories[index],
          onTap: () {
            Routes.sailor.navigate(
              SubCategoryPage.route,
              params: {"mainCategoryId": mainCategories[index].id},
            );
          },
          categoryNotifier: categoryNotifier,
        );
      },
    );
  }
}
