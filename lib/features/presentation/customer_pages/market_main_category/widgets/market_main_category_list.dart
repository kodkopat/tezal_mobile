import 'package:flutter/material.dart';

import '../../../../data/models/customer/main_category_result_model.dart';
import '../../../providers/customer_providers/category_notifier.dart';
import 'market_main_category_list_item.dart';

class MarketMainCategoryList extends StatelessWidget {
  MarketMainCategoryList({
    required this.mainCategories,
    required this.onItemTap,
    required this.categoryNotifier,
  });

  final List<MainCategory> mainCategories;
  final void Function(int) onItemTap;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: mainCategories.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return MarketMainCategoryListItem(
          categoryNotifier: categoryNotifier,
          mainCategory: mainCategories[index],
          onTap: () => onItemTap(index),
        );
      },
    );
  }
}
