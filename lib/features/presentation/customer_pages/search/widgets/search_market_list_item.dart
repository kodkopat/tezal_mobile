import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/search_result_model.dart';
import 'search_market_product_list.dart';

class SearchMarketListItem extends StatelessWidget {
  const SearchMarketListItem({
    Key key,
    @required this.market,
  }) : super(key: key);

  final Market market;

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
                "${market.name}",
                style: AppTxtStyles().body..bold(),
              ),
              Txt(
                "مشاهده همه محصولات \u203A",
                style: AppTxtStyles().body,
              ),
            ],
          ),
        ),
        SearchMarketProductList(
          products: market.products,
        ),
      ],
    );
  }
}
