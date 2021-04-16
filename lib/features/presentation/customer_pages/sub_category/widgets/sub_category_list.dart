import 'package:flutter/material.dart';

import '../../../../data/models/sub_category_result_model.dart';
import '../../../providers/customer_providers/category_notifier.dart';
import 'sub_category_list_item.dart';

class SubCategoryList extends StatelessWidget {
  SubCategoryList({
    required this.subCategories,
    required this.categoryNotifier,
  });

  final List<SubCategory> subCategories;
  final CategoryNotifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: subCategories.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return SubCategoryListItem(
          subCategory: subCategories[index],
          onTap: () {},
          categoryNotifier: categoryNotifier,
        );
      },
    );
  }
}
