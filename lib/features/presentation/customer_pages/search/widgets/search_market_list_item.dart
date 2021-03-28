import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/search_result_model.dart';
import '../../market_detail/market_detail_page.dart';
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
                "جزئیات فروشگاه \u00BB",
                gesture: Gestures()
                  ..onTap(() {
                    Routes.sailor.navigate(
                      MarketDetailPage.route,
                      params: {
                        "marketId": market,
                      },
                    );
                  }),
                style: AppTxtStyles().footNote
                  ..borderRadius(all: 4)
                  ..margin(top: 2)
                  ..padding(horizontal: 4, vertical: 2)
                  ..ripple(true),
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
