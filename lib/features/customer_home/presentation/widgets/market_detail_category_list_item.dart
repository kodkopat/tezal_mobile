import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tezal/core/styles/txt_styles.dart';

import '../../data/models/market_detail_result_model.dart';
import 'market_detail_product_list.dart';

class MarketDetailCategoryListItem extends StatelessWidget {
  const MarketDetailCategoryListItem({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 16, 20, 8),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${category.name}",
                style: AppTxtStyles().body..bold(),
              ),
              Txt(
                "مشاهده همه محصولات \u203A",
                style: AppTxtStyles().body,
              ),
            ],
          ),
        ),
        MarketDetailProductList(
          products: category.products,
        ),
      ],
    );
  }
}
