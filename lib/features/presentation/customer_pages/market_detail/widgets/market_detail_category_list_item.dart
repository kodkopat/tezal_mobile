import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market_detail_result_model.dart';
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
          padding: EdgeInsets.fromLTRB(4, 16, 20, 8),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${category.name}",
                style: AppTxtStyles().body..bold(),
              ),
              Txt(
                "مشاهده همه محصولات \u00BB",
                gesture: Gestures()..onTap(() {}),
                style: AppTxtStyles().footNote
                  ..borderRadius(all: 4)
                  ..margin(top: 2)
                  ..padding(horizontal: 4, vertical: 2)
                  ..ripple(true),
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
