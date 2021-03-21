import 'package:flutter/material.dart';

import '../../data/models/market_detail_result_model.dart';
import 'market_detail_category_list_item.dart';

class MarketDetailCategoryList extends StatelessWidget {
  const MarketDetailCategoryList({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return MarketDetailCategoryListItem(
          category: categories[index],
        );
      },
    );
  }
}
