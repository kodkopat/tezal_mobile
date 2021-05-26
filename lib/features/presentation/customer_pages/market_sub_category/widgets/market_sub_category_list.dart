import 'package:flutter/material.dart';

import '../../../../data/models/customer/sub_category_result_model.dart';
import '../../../customer_providers/category_notifier.dart';
import 'market_sub_category_list_item.dart';

class MarketSubCategoryList extends StatelessWidget {
  MarketSubCategoryList({
    required this.subCategories,
    required this.onItemTap,
    required this.categoryNotifier,
  });

  final List<SubCategory> subCategories;
  final void Function(int) onItemTap;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: subCategories.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return MarketSubCategoryListItem(
          categoryNotifier: categoryNotifier,
          subCategory: subCategories[index],
          onTap: () => onItemTap(index),
        );
      },
    );
  }
}
